// Copyright © 2021-present 650 Industries, Inc. (aka Expo)

#pragma once

#include <fbjni/fbjni.h>
#include <jsi/jsi.h>
#include <react/jni/ReadableNativeArray.h>
#include <jni/JCallback.h>

#include <map>

#include "MethodMetadata.h"
#include "JNIFunctionBody.h"

namespace jni = facebook::jni;
namespace jsi = facebook::jsi;
namespace react = facebook::react;

namespace expo {
class JSIInteropModuleRegistry;

/**
 * A CPP part of the module.
 *
 * Right now objects of this class are stored by the ModuleHolder to ensure they will live
 * as long as the RN context.
 */
class JavaScriptModuleObject : public jni::HybridClass<JavaScriptModuleObject> {
public:
  static auto constexpr
    kJavaDescriptor = "Lexpo/modules/kotlin/jni/JavaScriptModuleObject;";
  static auto constexpr TAG = "JavaScriptModuleObject";

  static jni::local_ref<jhybriddata> initHybrid(jni::alias_ref<jhybridobject> jThis);

  static void registerNatives();

  /**
   * Pointer to the module registry interop.
   */
  JSIInteropModuleRegistry *jsiInteropModuleRegistry;

  /**
   * Returns a cached instance of jsi::Object representing this module.
   * @param runtime
   * @return Wrapped instance of JavaScriptModuleObject::HostObject
   */
  std::shared_ptr<jsi::Object> getJSIObject(jsi::Runtime &runtime);

  /**
   * Registers a sync function.
   * That function can be called via the `JavaScriptModuleObject.callSyncMethod` method.
   */
  void registerSyncFunction(
    jni::alias_ref<jstring> name,
    jint args,
    jni::alias_ref<JNIFunctionBody::javaobject> JSIFunctionBody
  );

  /**
   * Registers a async function.
   * That function can be called via the `JavaScriptModuleObject.callAsyncMethod` method.
   */
  void registerAsyncFunction(
    jni::alias_ref<jstring> name,
    jint args,
    jni::alias_ref<JNIAsyncFunctionBody::javaobject> JSIAsyncFunctionBody
  );

  /**
   * An inner class of the `JavaScriptModuleObject` that is exported to the JS.
   * It's an additional communication layer between JS and Kotlin.
   * So the high-level view on accessing the exported function will look like this:
   * `JS` --get function--> `JavaScriptModuleObject::HostObject` --access module metadata--> `JavaScriptModuleObject`
   *  --create JSI function--> `MethodMetadata`
   *
   * This abstraction wasn't necessary. However, it makes the management of ownership much easier -
   * `JavaScriptModuleObject` is held by the ModuleHolder and `JavaScriptModuleObject::HostObject` is stored in the JS runtime.
   * Without this distinction the `JavaScriptModuleObject` would have to turn into `HostObject` and `HybridObject` at the same time.
   */
  class HostObject : public jsi::HostObject {
  public:
    HostObject(JavaScriptModuleObject *);

    jsi::Value get(jsi::Runtime &, const jsi::PropNameID &name) override;

    void set(jsi::Runtime &, const jsi::PropNameID &name, const jsi::Value &value) override;

    std::vector<jsi::PropNameID> getPropertyNames(jsi::Runtime &rt) override;

  private:
    JavaScriptModuleObject *jsModule;
  };

private:
  friend HybridBase;
  /**
   * A reference to the `JavaScriptModuleObject::HostObject`.
   * Simple we cached that value to return the same object each time.
   */
  std::shared_ptr<jsi::Object> jsiObject = nullptr;
  jni::global_ref<JavaScriptModuleObject::javaobject> javaPart_;

  /**
   * Metadata map that stores information about all available methods on this module.
   */
  std::map<std::string, MethodMetadata> methodsMetadata;

  explicit JavaScriptModuleObject(jni::alias_ref<jhybridobject> jThis)
    : javaPart_(jni::make_global(jThis)) {}
};
} // namespace expo