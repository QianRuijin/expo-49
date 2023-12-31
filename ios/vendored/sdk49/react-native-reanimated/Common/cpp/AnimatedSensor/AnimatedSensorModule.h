#pragma once

#include <ABI49_0_0jsi/ABI49_0_0jsi.h>
#include <memory>
#include <unordered_set>

#include "PlatformDepMethodsHolder.h"
#include "RuntimeManager.h"
#include "Shareables.h"

namespace ABI49_0_0reanimated {

using namespace ABI49_0_0facebook;

enum SensorType {
  ACCELEROMETER = 1,
  GYROSCOPE = 2,
  GRAVITY = 3,
  MAGNETIC_FIELD = 4,
  ROTATION_VECTOR = 5,
};

class AnimatedSensorModule {
  std::unordered_set<int> sensorsIds_;
  RegisterSensorFunction platformRegisterSensorFunction_;
  UnregisterSensorFunction platformUnregisterSensorFunction_;

 public:
  AnimatedSensorModule(
      const PlatformDepMethodsHolder &platformDepMethodsHolder);
  ~AnimatedSensorModule();

  jsi::Value registerSensor(
      jsi::Runtime &rt,
      const std::shared_ptr<JSRuntimeHelper> &runtimeHelper,
      const jsi::Value &sensorType,
      const jsi::Value &interval,
      const jsi::Value &iosReferenceFrame,
      const jsi::Value &sensorDataContainer);
  void unregisterSensor(const jsi::Value &sensorId);
  void unregisterAllSensors();
};

} // namespace reanimated
