package abi47_0_0.expo.modules.kotlin.functions

import abi47_0_0.com.facebook.react.bridge.ReadableArray
import abi47_0_0.expo.modules.kotlin.AppContext
import abi47_0_0.expo.modules.kotlin.ModuleHolder
import abi47_0_0.expo.modules.kotlin.Promise
import abi47_0_0.expo.modules.kotlin.exception.CodedException
import abi47_0_0.expo.modules.kotlin.exception.FunctionCallException
import abi47_0_0.expo.modules.kotlin.exception.UnexpectedException
import abi47_0_0.expo.modules.kotlin.exception.exceptionDecorator
import abi47_0_0.expo.modules.kotlin.jni.JavaScriptModuleObject
import abi47_0_0.expo.modules.kotlin.types.AnyType
import kotlinx.coroutines.launch

/**
 * Base class of async function components that require a promise to be called.
 */
abstract class AsyncFunction(
  name: String,
  desiredArgsTypes: Array<AnyType>
) : BaseAsyncFunctionComponent(name, desiredArgsTypes) {

  override fun call(holder: ModuleHolder, args: ReadableArray, promise: Promise) {
    val queue = when (queue) {
      Queues.MAIN -> holder.module.appContext.mainQueue
      Queues.DEFAULT -> null
    }

    if (queue == null) {
      callUserImplementation(args, promise)
    } else {
      queue.launch {
        try {
          exceptionDecorator({
            FunctionCallException(name, holder.name, it)
          }) {
            callUserImplementation(args, promise)
          }
        } catch (e: CodedException) {
          promise.reject(e)
        } catch (e: Throwable) {
          promise.reject(UnexpectedException(e))
        }
      }
    }
  }

  @Throws(CodedException::class)
  internal abstract fun callUserImplementation(args: ReadableArray, promise: Promise)

  internal abstract fun callUserImplementation(args: Array<Any?>, promise: Promise)

  override fun attachToJSObject(appContext: AppContext, jsObject: JavaScriptModuleObject) {
    jsObject.registerAsyncFunction(
      name,
      argsCount,
      desiredArgsTypes.map { it.getCppRequiredTypes() }.toTypedArray()
    ) { args, bridgePromise ->
      val queue = when (queue) {
        Queues.MAIN -> appContext.mainQueue
        Queues.DEFAULT -> appContext.modulesQueue
      }

      queue.launch {
        try {
          exceptionDecorator({
            FunctionCallException(name, jsObject.name, it)
          }) {
            callUserImplementation(args, bridgePromise)
          }
        } catch (e: CodedException) {
          bridgePromise.reject(e)
        } catch (e: Throwable) {
          bridgePromise.reject(UnexpectedException(e))
        }
      }
    }
  }
}
