/**
 * This code was generated by [react-native-codegen](https://www.npmjs.com/package/react-native-codegen).
 *
 * Do not edit this file as changes may cause incorrect behavior and will be lost
 * once the code is regenerated.
 *
 * @generated by codegen project: GenerateModuleObjCpp
 *
 * We create an umbrella header (and corresponding implementation) here since
 * Cxx compilation in BUCK has a limitation: source-code producing genrule()s
 * must have a single output. More files => more genrule()s => slower builds.
 */

#import "SafeAreaContextSpec.h"


namespace ABI46_0_0facebook {
  namespace ABI46_0_0React {
    
    static ABI46_0_0facebook::jsi::Value __hostFunction_NativeSafeAreaContextSpecJSI_getConstants(ABI46_0_0facebook::jsi::Runtime& rt, TurboModule &turboModule, const ABI46_0_0facebook::jsi::Value* args, size_t count) {
      return static_cast<ObjCTurboModule&>(turboModule).invokeObjCMethod(rt, ObjectKind, "getConstants", @selector(getConstants), args, count);
    }

    NativeSafeAreaContextSpecJSI::NativeSafeAreaContextSpecJSI(const ObjCTurboModule::InitParams &params)
      : ObjCTurboModule(params) {
        
        methodMap_["getConstants"] = MethodMetadata {0, __hostFunction_NativeSafeAreaContextSpecJSI_getConstants};
        
    }
  } // namespace ABI46_0_0React
} // namespace ABI46_0_0facebook