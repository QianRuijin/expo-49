/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @generated by an internal plugin build system
 */

#ifndef ABI46_0_0RN_DISABLE_OSS_PLUGIN_HEADER

// OSS-compatibility layer

#import "ABI46_0_0RCTFabricComponentsPlugins.h"

#import <string>
#import <unordered_map>

Class<ABI46_0_0RCTComponentViewProtocol> ABI46_0_0RCTFabricComponentsProvider(const char *name) {
  static std::unordered_map<std::string, Class (*)(void)> sFabricComponentsClassMap = {
    {"SafeAreaView", ABI46_0_0RCTSafeAreaViewCls},
    {"ScrollView", ABI46_0_0RCTScrollViewCls},
    {"PullToRefreshView", ABI46_0_0RCTPullToRefreshViewCls},
    {"ActivityIndicatorView", ABI46_0_0RCTActivityIndicatorViewCls},
    {"Slider", ABI46_0_0RCTSliderCls},
    {"Switch", ABI46_0_0RCTSwitchCls},
    {"UnimplementedNativeView", ABI46_0_0RCTUnimplementedNativeViewCls},
    {"Paragraph", ABI46_0_0RCTParagraphCls},
    {"TextInput", ABI46_0_0RCTTextInputCls},
    {"InputAccessoryView", ABI46_0_0RCTInputAccessoryCls},
    {"View", ABI46_0_0RCTViewCls},
    {"Image", ABI46_0_0RCTImageCls},
  };

  auto p = sFabricComponentsClassMap.find(name);
  if (p != sFabricComponentsClassMap.end()) {
    auto classFunc = p->second;
    return classFunc();
  }
  return ABI46_0_0RCTThirdPartyFabricComponentsProvider(name);
}

#endif // ABI46_0_0RN_DISABLE_OSS_PLUGIN_HEADER