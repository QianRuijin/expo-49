package abi49_0_0.expo.modules.splashscreen

import android.content.Context
import expo.modules.splashscreen.singletons.SplashScreen
import abi49_0_0.expo.modules.core.interfaces.Package
import abi49_0_0.expo.modules.core.interfaces.ReactActivityLifecycleListener
import expo.modules.core.interfaces.SingletonModule

class SplashScreenPackage : Package {
  override fun createSingletonModules(context: Context?): List<SingletonModule> {
    return listOf(SplashScreen)
  }

  override fun createReactActivityLifecycleListeners(activityContext: Context): List<ReactActivityLifecycleListener> {
    return listOf(SplashScreenReactActivityLifecycleListener(activityContext))
  }
}
