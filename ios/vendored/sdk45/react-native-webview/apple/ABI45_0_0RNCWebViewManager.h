/**
 * Copyright (c) 2015-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <ABI45_0_0React/ABI45_0_0RCTViewManager.h>

@interface ABI45_0_0RNCWebViewManager : ABI45_0_0RCTViewManager
  @property (nonatomic, copy) NSArray<NSDictionary *> * _Nullable menuItems;
  @property (nonatomic, copy) ABI45_0_0RCTDirectEventBlock onCustomMenuSelection;
@end