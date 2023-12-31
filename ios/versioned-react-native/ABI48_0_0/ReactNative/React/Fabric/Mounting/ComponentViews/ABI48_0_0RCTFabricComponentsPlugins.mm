/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @generated by an internal plugin build system
 */

#ifndef ABI48_0_0RN_DISABLE_OSS_PLUGIN_HEADER

// OSS-compatibility layer

#import "ABI48_0_0RCTFabricComponentsPlugins.h"

#import <string>
#import <unordered_map>

Class<ABI48_0_0RCTComponentViewProtocol> ABI48_0_0RCTFabricComponentsProvider(const char *name) {
  static std::unordered_map<std::string, Class (*)(void)> sFabricComponentsClassMap = {
    {"SafeAreaView", ABI48_0_0RCTSafeAreaViewCls},
    {"ScrollView", ABI48_0_0RCTScrollViewCls},
    {"PullToRefreshView", ABI48_0_0RCTPullToRefreshViewCls},
    {"ActivityIndicatorView", ABI48_0_0RCTActivityIndicatorViewCls},
    {"Slider", ABI48_0_0RCTSliderCls},
    {"Switch", ABI48_0_0RCTSwitchCls},
    {"UnimplementedNativeView", ABI48_0_0RCTUnimplementedNativeViewCls},
    {"Paragraph", ABI48_0_0RCTParagraphCls},
    {"TextInput", ABI48_0_0RCTTextInputCls},
    {"InputAccessoryView", ABI48_0_0RCTInputAccessoryCls},
    {"View", ABI48_0_0RCTViewCls},
    {"Image", ABI48_0_0RCTImageCls},
    {"ModalHostView", ABI48_0_0RCTModalHostViewCls},
  };

  auto p = sFabricComponentsClassMap.find(name);
  if (p != sFabricComponentsClassMap.end()) {
    auto classFunc = p->second;
    return classFunc();
  }
  return ABI48_0_0RCTThirdPartyFabricComponentsProvider(name);
}

#endif // ABI48_0_0RN_DISABLE_OSS_PLUGIN_HEADER
