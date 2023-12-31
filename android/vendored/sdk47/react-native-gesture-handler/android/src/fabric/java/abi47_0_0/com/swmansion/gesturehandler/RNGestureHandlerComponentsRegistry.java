package abi47_0_0.com.swmansion.gesturehandler.react;

import com.facebook.jni.HybridData;
import com.facebook.proguard.annotations.DoNotStrip;
import abi47_0_0.com.facebook.react.fabric.ComponentFactory;
import com.facebook.soloader.SoLoader;

@DoNotStrip
public class RNGestureHandlerComponentsRegistry {
  static {
    SoLoader.loadLibrary("fabricjni_abi47_0_0");
    SoLoader.loadLibrary("gesturehandler_abi47_0_0");
  }

  @DoNotStrip private final HybridData mHybridData;

  @DoNotStrip
  private native HybridData initHybrid(ComponentFactory componentFactory);

  @DoNotStrip
  private RNGestureHandlerComponentsRegistry(ComponentFactory componentFactory) {
    mHybridData = initHybrid(componentFactory);
  }

  @DoNotStrip
  public static RNGestureHandlerComponentsRegistry register(ComponentFactory componentFactory) {
    return new RNGestureHandlerComponentsRegistry(componentFactory);
  }
}
