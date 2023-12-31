package abi49_0_0.com.swmansion.reanimated;

import static abi49_0_0.com.swmansion.reanimated.Utils.simplifyStringNumbersList;

import com.facebook.jni.HybridData;
import com.facebook.proguard.annotations.DoNotStrip;
import abi49_0_0.com.facebook.react.bridge.ReactApplicationContext;
import abi49_0_0.com.facebook.react.bridge.queue.MessageQueueThread;
import abi49_0_0.com.facebook.react.turbomodule.core.CallInvokerHolderImpl;
import abi49_0_0.com.swmansion.reanimated.layoutReanimation.LayoutAnimations;
import abi49_0_0.com.swmansion.reanimated.layoutReanimation.NativeMethodsHolder;
import abi49_0_0.com.swmansion.reanimated.nativeProxy.NativeProxyCommon;

import java.lang.ref.WeakReference;
import java.util.HashMap;

public class NativeProxy extends NativeProxyCommon {
    @DoNotStrip
    @SuppressWarnings("unused")
    private final HybridData mHybridData;

    public NativeProxy(ReactApplicationContext context) {
        super(context);
        CallInvokerHolderImpl holder =
                (CallInvokerHolderImpl) context.getCatalystInstance().getJSCallInvokerHolder();
        LayoutAnimations LayoutAnimations = new LayoutAnimations(context);
        mHybridData =
                initHybrid(
                        context.getJavaScriptContextHolder().get(),
                        holder,
                        mScheduler,
                        LayoutAnimations);
        prepareLayoutAnimations(LayoutAnimations);
        ReanimatedMessageQueueThread messageQueueThread = new ReanimatedMessageQueueThread();
        installJSIBindings(messageQueueThread);
    }

    private native HybridData initHybrid(
            long jsContext,
            CallInvokerHolderImpl jsCallInvokerHolder,
            Scheduler scheduler,
            LayoutAnimations LayoutAnimations);

    private native void installJSIBindings(MessageQueueThread messageQueueThread);

    public native boolean isAnyHandlerWaitingForEvent(String eventName);

    public native void performOperations();

    @Override
    protected HybridData getHybridData() {
        return mHybridData;
    }

    public static NativeMethodsHolder createNativeMethodsHolder(LayoutAnimations layoutAnimations) {
        WeakReference<LayoutAnimations> weakLayoutAnimations = new WeakReference<>(layoutAnimations);
        return new NativeMethodsHolder() {
            @Override
            public void startAnimation(int tag, int type, HashMap<String, Object> values) {
                LayoutAnimations layoutAnimations = weakLayoutAnimations.get();
                if (layoutAnimations != null) {
                    HashMap<String, String> preparedValues = new HashMap<>();
                    for (String key : values.keySet()) {
                      String stringValue = values.get(key).toString();
                      if (key.endsWith("TransformMatrix")) {
                        preparedValues.put(key, simplifyStringNumbersList(stringValue));
                      } else {
                        preparedValues.put(key, stringValue);
                      }
                    }
                    layoutAnimations.startAnimationForTag(tag, type, preparedValues);
                }
            }

            @Override
            public boolean isLayoutAnimationEnabled() {
                LayoutAnimations layoutAnimations = weakLayoutAnimations.get();
                if (layoutAnimations != null) {
                    return layoutAnimations.isLayoutAnimationEnabled();
                }
                return false;
            }

            @Override
            public boolean hasAnimation(int tag, int type) {
                LayoutAnimations layoutAnimations = weakLayoutAnimations.get();
                if (layoutAnimations != null) {
                    return layoutAnimations.hasAnimationForTag(tag, type);
                }
                return false;
            }

            @Override
            public void clearAnimationConfig(int tag) {
                LayoutAnimations layoutAnimations = weakLayoutAnimations.get();
                if (layoutAnimations != null) {
                    layoutAnimations.clearAnimationConfigForTag(tag);
                }
            }

            @Override
            public void cancelAnimation(int tag, int type, boolean cancelled, boolean removeView) {
                LayoutAnimations layoutAnimations = weakLayoutAnimations.get();
                if (layoutAnimations != null) {
                    layoutAnimations.cancelAnimationForTag(tag, type, cancelled, removeView);
                }
            }

            @Override
            public int findPrecedingViewTagForTransition(int tag) {
                LayoutAnimations layoutAnimations = weakLayoutAnimations.get();
                if (layoutAnimations != null) {
                    return layoutAnimations.findPrecedingViewTagForTransition(tag);
                }
                return -1;
            }
        };
    }
}
