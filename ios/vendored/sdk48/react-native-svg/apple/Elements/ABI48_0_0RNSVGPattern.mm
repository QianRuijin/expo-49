/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */
#import "ABI48_0_0RNSVGPattern.h"
#import "ABI48_0_0RNSVGBrushType.h"
#import "ABI48_0_0RNSVGNode.h"
#import "ABI48_0_0RNSVGPainter.h"

#ifdef RN_FABRIC_ENABLED
#import <ABI48_0_0React/ABI48_0_0RCTConversions.h>
#import <ABI48_0_0React/ABI48_0_0RCTFabricComponentsPlugins.h>
#import <react/renderer/components/rnsvg/ComponentDescriptors.h>
#import <react/renderer/components/view/conversions.h>
#import "ABI48_0_0RNSVGFabricConversions.h"
#endif // RN_FABRIC_ENABLED

@implementation ABI48_0_0RNSVGPattern

#ifdef RN_FABRIC_ENABLED
using namespace ABI48_0_0facebook::ABI48_0_0React;

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const ABI48_0_0RNSVGPatternProps>();
    _props = defaultProps;
  }
  return self;
}

#pragma mark - ABI48_0_0RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<ABI48_0_0RNSVGPatternComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const ABI48_0_0RNSVGPatternProps>(props);

  self.x = [ABI48_0_0RNSVGLength lengthWithString:ABI48_0_0RCTNSStringFromString(newProps.x)];
  self.y = [ABI48_0_0RNSVGLength lengthWithString:ABI48_0_0RCTNSStringFromString(newProps.y)];
  if (ABI48_0_0RCTNSStringFromStringNilIfEmpty(newProps.height)) {
    self.patternheight = [ABI48_0_0RNSVGLength lengthWithString:ABI48_0_0RCTNSStringFromString(newProps.height)];
  }
  if (ABI48_0_0RCTNSStringFromStringNilIfEmpty(newProps.width)) {
    self.patternwidth = [ABI48_0_0RNSVGLength lengthWithString:ABI48_0_0RCTNSStringFromString(newProps.width)];
  }
  self.patternUnits = newProps.patternUnits == 0 ? kRNSVGUnitsObjectBoundingBox : kRNSVGUnitsUserSpaceOnUse;
  self.patternContentUnits = newProps.patternUnits == 0 ? kRNSVGUnitsObjectBoundingBox : kRNSVGUnitsUserSpaceOnUse;
  if (newProps.patternTransform.size() == 6) {
    self.patternTransform = CGAffineTransformMake(
        newProps.patternTransform.at(0),
        newProps.patternTransform.at(1),
        newProps.patternTransform.at(2),
        newProps.patternTransform.at(3),
        newProps.patternTransform.at(4),
        newProps.patternTransform.at(5));
  }
  self.minX = newProps.minX;
  self.minY = newProps.minY;
  self.vbWidth = newProps.vbWidth;
  self.vbHeight = newProps.vbHeight;
  self.align = ABI48_0_0RCTNSStringFromStringNilIfEmpty(newProps.align);
  self.meetOrSlice = intToRNSVGVBMOS(newProps.meetOrSlice);

  setCommonGroupProps(newProps, self);
  _props = std::static_pointer_cast<ABI48_0_0RNSVGPatternProps const>(props);
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];
  _x = nil;
  _y = nil;
  _patternheight = nil;
  _patternwidth = nil;
  _patternUnits = kRNSVGUnitsObjectBoundingBox;
  _patternContentUnits = kRNSVGUnitsObjectBoundingBox;
  _patternTransform = CGAffineTransformIdentity;

  _minX = 0;
  _minY = 0;
  _vbWidth = 0;
  _vbHeight = 0;
  _align = nil;
  _meetOrSlice = kRNSVGVBMOSMeet;
}
#endif // RN_FABRIC_ENABLED

- (instancetype)init
{
  if (self = [super init]) {
    _patternTransform = CGAffineTransformIdentity;
  }
  return self;
}

- (ABI48_0_0RNSVGPlatformView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  return nil;
}

- (void)parseReference
{
  self.dirty = false;
  NSArray<ABI48_0_0RNSVGLength *> *points = @[ self.x, self.y, self.patternwidth, self.patternheight ];
  ABI48_0_0RNSVGPainter *painter = [[ABI48_0_0RNSVGPainter alloc] initWithPointsArray:points];
  [painter setUnits:self.patternUnits];
  [painter setContentUnits:self.patternContentUnits];
  [painter setTransform:self.patternTransform];
  [painter setPattern:self];

  if (self.patternUnits == kRNSVGUnitsUserSpaceOnUse || self.patternContentUnits == kRNSVGUnitsUserSpaceOnUse) {
    [painter setUserSpaceBoundingBox:[self.svgView getContextBounds]];
  }

  [self.svgView definePainter:painter painterName:self.name];
}

- (void)setX:(ABI48_0_0RNSVGLength *)x
{
  if ([x isEqualTo:_x]) {
    return;
  }

  _x = x;
  [self invalidate];
}

- (void)setY:(ABI48_0_0RNSVGLength *)y
{
  if ([y isEqualTo:_y]) {
    return;
  }

  _y = y;
  [self invalidate];
}

- (void)setPatternwidth:(ABI48_0_0RNSVGLength *)patternwidth
{
  if ([patternwidth isEqualTo:_patternwidth]) {
    return;
  }

  _patternwidth = patternwidth;
  [self invalidate];
}

- (void)setPatternheight:(ABI48_0_0RNSVGLength *)patternheight
{
  if ([patternheight isEqualTo:_patternheight]) {
    return;
  }

  _patternheight = patternheight;
  [self invalidate];
}

- (void)setPatternUnits:(ABI48_0_0RNSVGUnits)patternUnits
{
  if (patternUnits == _patternUnits) {
    return;
  }

  _patternUnits = patternUnits;
  [self invalidate];
}

- (void)setPatternContentUnits:(ABI48_0_0RNSVGUnits)patternContentUnits
{
  if (patternContentUnits == _patternContentUnits) {
    return;
  }

  _patternContentUnits = patternContentUnits;
  [self invalidate];
}

- (void)setPatternTransform:(CGAffineTransform)patternTransform
{
  _patternTransform = patternTransform;
  [self invalidate];
}

- (void)setMinX:(CGFloat)minX
{
  if (minX == _minX) {
    return;
  }

  [self invalidate];
  _minX = minX;
}

- (void)setMinY:(CGFloat)minY
{
  if (minY == _minY) {
    return;
  }

  [self invalidate];
  _minY = minY;
}

- (void)setVbWidth:(CGFloat)vbWidth
{
  if (vbWidth == _vbWidth) {
    return;
  }

  [self invalidate];
  _vbWidth = vbWidth;
}

- (void)setVbHeight:(CGFloat)vbHeight
{
  if (_vbHeight == vbHeight) {
    return;
  }

  [self invalidate];
  _vbHeight = vbHeight;
}

- (void)setAlign:(NSString *)align
{
  if ([align isEqualToString:_align]) {
    return;
  }

  [self invalidate];
  _align = align;
}

- (void)setMeetOrSlice:(ABI48_0_0RNSVGVBMOS)meetOrSlice
{
  if (meetOrSlice == _meetOrSlice) {
    return;
  }

  [self invalidate];
  _meetOrSlice = meetOrSlice;
}

@end

#ifdef RN_FABRIC_ENABLED
Class<ABI48_0_0RCTComponentViewProtocol> ABI48_0_0RNSVGPatternCls(void)
{
  return ABI48_0_0RNSVGPattern.class;
}
#endif // RN_FABRIC_ENABLED
