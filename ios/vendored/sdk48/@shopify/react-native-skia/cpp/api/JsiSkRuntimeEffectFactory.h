#pragma once

#include <memory>
#include <string>
#include <utility>

#include <ABI48_0_0jsi/ABI48_0_0jsi.h>

#include "JsiSkHostObjects.h"
#include "JsiSkRuntimeEffect.h"

namespace ABI48_0_0RNSkia {

namespace jsi = ABI48_0_0facebook::jsi;

class JsiSkRuntimeEffectFactory : public JsiSkHostObject {
public:
  JSI_HOST_FUNCTION(Make) {
    auto sksl = arguments[0].asString(runtime).utf8(runtime);
    auto result = SkRuntimeEffect::MakeForShader(SkString(sksl));
    auto effect = result.effect;
    auto errorText = result.errorText;
    if (!effect) {
      throw jsi::JSError(runtime, std::string("Error in sksl:\n" +
                                              std::string(errorText.c_str()))
                                      .c_str());
      return jsi::Value::null();
    }
    return jsi::Object::createFromHostObject(
        runtime,
        std::make_shared<JsiSkRuntimeEffect>(getContext(), std::move(effect)));
  }

  JSI_EXPORT_FUNCTIONS(JSI_EXPORT_FUNC(JsiSkRuntimeEffectFactory, Make))

  explicit JsiSkRuntimeEffectFactory(
      std::shared_ptr<ABI48_0_0RNSkPlatformContext> context)
      : JsiSkHostObject(std::move(context)) {}
};

} // namespace ABI48_0_0RNSkia
