/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "ABI46_0_0UIView+React.h"

#import <objc/runtime.h>

#import "ABI46_0_0RCTAssert.h"
#import "ABI46_0_0RCTLog.h"
#import "ABI46_0_0RCTShadowView.h"

@implementation UIView (ABI46_0_0React)

- (NSNumber *)ABI46_0_0ReactTag
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setABI46_0_0ReactTag:(NSNumber *)ABI46_0_0ReactTag
{
  objc_setAssociatedObject(self, @selector(ABI46_0_0ReactTag), ABI46_0_0ReactTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)rootTag
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setRootTag:(NSNumber *)rootTag
{
  objc_setAssociatedObject(self, @selector(rootTag), rootTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)nativeID
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setNativeID:(NSString *)nativeID
{
  objc_setAssociatedObject(self, @selector(nativeID), nativeID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldAccessibilityIgnoresInvertColors
{
  return self.accessibilityIgnoresInvertColors;
}

- (void)setShouldAccessibilityIgnoresInvertColors:(BOOL)shouldAccessibilityIgnoresInvertColors
{
  self.accessibilityIgnoresInvertColors = shouldAccessibilityIgnoresInvertColors;
}

- (BOOL)isABI46_0_0ReactRootView
{
  return ABI46_0_0RCTIsABI46_0_0ReactRootView(self.ABI46_0_0ReactTag);
}

- (NSNumber *)ABI46_0_0ReactTagAtPoint:(CGPoint)point
{
  UIView *view = [self hitTest:point withEvent:nil];
  while (view && !view.ABI46_0_0ReactTag) {
    view = view.superview;
  }
  return view.ABI46_0_0ReactTag;
}

- (NSArray<UIView *> *)ABI46_0_0ReactSubviews
{
  return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)ABI46_0_0ReactSuperview
{
  return self.superview;
}

- (void)insertABI46_0_0ReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  // We access the associated object directly here in case someone overrides
  // the `ABI46_0_0ReactSubviews` getter method and returns an immutable array.
  NSMutableArray *subviews = objc_getAssociatedObject(self, @selector(ABI46_0_0ReactSubviews));
  if (!subviews) {
    subviews = [NSMutableArray new];
    objc_setAssociatedObject(self, @selector(ABI46_0_0ReactSubviews), subviews, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  [subviews insertObject:subview atIndex:atIndex];
}

- (void)removeABI46_0_0ReactSubview:(UIView *)subview
{
  // We access the associated object directly here in case someone overrides
  // the `ABI46_0_0ReactSubviews` getter method and returns an immutable array.
  NSMutableArray *subviews = objc_getAssociatedObject(self, @selector(ABI46_0_0ReactSubviews));
  [subviews removeObject:subview];
  [subview removeFromSuperview];
}

#pragma mark - Display

- (ABI46_0_0YGDisplay)ABI46_0_0ReactDisplay
{
  return self.isHidden ? ABI46_0_0YGDisplayNone : ABI46_0_0YGDisplayFlex;
}

- (void)setABI46_0_0ReactDisplay:(ABI46_0_0YGDisplay)display
{
  self.hidden = display == ABI46_0_0YGDisplayNone;
}

#pragma mark - Layout Direction

- (UIUserInterfaceLayoutDirection)ABI46_0_0ReactLayoutDirection
{
  if ([self respondsToSelector:@selector(semanticContentAttribute)]) {
    return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute];
  } else {
    return [objc_getAssociatedObject(self, @selector(ABI46_0_0ReactLayoutDirection)) integerValue];
  }
}

- (void)setABI46_0_0ReactLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection
{
  if ([self respondsToSelector:@selector(setSemanticContentAttribute:)]) {
    self.semanticContentAttribute = layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight
        ? UISemanticContentAttributeForceLeftToRight
        : UISemanticContentAttributeForceRightToLeft;
  } else {
    objc_setAssociatedObject(
        self, @selector(ABI46_0_0ReactLayoutDirection), @(layoutDirection), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
}

#pragma mark - zIndex

- (NSInteger)ABI46_0_0ReactZIndex
{
  return self.layer.zPosition;
}

- (void)setABI46_0_0ReactZIndex:(NSInteger)ABI46_0_0ReactZIndex
{
  self.layer.zPosition = ABI46_0_0ReactZIndex;
}

- (NSArray<UIView *> *)ABI46_0_0ReactZIndexSortedSubviews
{
  // Check if sorting is required - in most cases it won't be.
  BOOL sortingRequired = NO;
  for (UIView *subview in self.subviews) {
    if (subview.ABI46_0_0ReactZIndex != 0) {
      sortingRequired = YES;
      break;
    }
  }
  return sortingRequired ? [self.ABI46_0_0ReactSubviews sortedArrayUsingComparator:^NSComparisonResult(UIView *a, UIView *b) {
    if (a.ABI46_0_0ReactZIndex > b.ABI46_0_0ReactZIndex) {
      return NSOrderedDescending;
    } else {
      // Ensure sorting is stable by treating equal zIndex as ascending so
      // that original order is preserved.
      return NSOrderedAscending;
    }
  }]
                         : self.subviews;
}

- (void)didUpdateABI46_0_0ReactSubviews
{
  for (UIView *subview in self.ABI46_0_0ReactSubviews) {
    [self addSubview:subview];
  }
}

- (void)didSetProps:(__unused NSArray<NSString *> *)changedProps
{
  // The default implementation does nothing.
}

- (void)ABI46_0_0ReactSetFrame:(CGRect)frame
{
  // These frames are in terms of anchorPoint = topLeft, but internally the
  // views are anchorPoint = center for easier scale and rotation animations.
  // Convert the frame so it works with anchorPoint = center.
  CGPoint position = {CGRectGetMidX(frame), CGRectGetMidY(frame)};
  CGRect bounds = {CGPointZero, frame.size};

  // Avoid crashes due to nan coords
  if (isnan(position.x) || isnan(position.y) || isnan(bounds.origin.x) || isnan(bounds.origin.y) ||
      isnan(bounds.size.width) || isnan(bounds.size.height)) {
    ABI46_0_0RCTLogError(
        @"Invalid layout for (%@)%@. position: %@. bounds: %@",
        self.ABI46_0_0ReactTag,
        self,
        NSStringFromCGPoint(position),
        NSStringFromCGRect(bounds));
    return;
  }

  self.center = position;
  self.bounds = bounds;
}

- (UIViewController *)ABI46_0_0ReactViewController
{
  id responder = [self nextResponder];
  while (responder) {
    if ([responder isKindOfClass:[UIViewController class]]) {
      return responder;
    }
    responder = [responder nextResponder];
  }
  return nil;
}

- (void)ABI46_0_0ReactAddControllerToClosestParent:(UIViewController *)controller
{
  if (!controller.parentViewController) {
    UIView *parentView = (UIView *)self.ABI46_0_0ReactSuperview;
    while (parentView) {
      if (parentView.ABI46_0_0ReactViewController) {
        [parentView.ABI46_0_0ReactViewController addChildViewController:controller];
        [controller didMoveToParentViewController:parentView.ABI46_0_0ReactViewController];
        break;
      }
      parentView = (UIView *)parentView.ABI46_0_0ReactSuperview;
    }
    return;
  }
}

/**
 * Focus manipulation.
 */
- (BOOL)ABI46_0_0ReactIsFocusNeeded
{
  return [(NSNumber *)objc_getAssociatedObject(self, @selector(ABI46_0_0ReactIsFocusNeeded)) boolValue];
}

- (void)setABI46_0_0ReactIsFocusNeeded:(BOOL)isFocusNeeded
{
  objc_setAssociatedObject(self, @selector(ABI46_0_0ReactIsFocusNeeded), @(isFocusNeeded), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ABI46_0_0ReactFocus
{
  if (![self becomeFirstResponder]) {
    self.ABI46_0_0ReactIsFocusNeeded = YES;
  }
}

- (void)ABI46_0_0ReactFocusIfNeeded
{
  if (self.ABI46_0_0ReactIsFocusNeeded) {
    if ([self becomeFirstResponder]) {
      self.ABI46_0_0ReactIsFocusNeeded = NO;
    }
  }
}

- (void)ABI46_0_0ReactBlur
{
  [self resignFirstResponder];
}

#pragma mark - Layout

- (UIEdgeInsets)ABI46_0_0ReactBorderInsets
{
  CGFloat borderWidth = self.layer.borderWidth;
  return UIEdgeInsetsMake(borderWidth, borderWidth, borderWidth, borderWidth);
}

- (UIEdgeInsets)ABI46_0_0ReactPaddingInsets
{
  return UIEdgeInsetsZero;
}

- (UIEdgeInsets)ABI46_0_0ReactCompoundInsets
{
  UIEdgeInsets borderInsets = self.ABI46_0_0ReactBorderInsets;
  UIEdgeInsets paddingInsets = self.ABI46_0_0ReactPaddingInsets;

  return UIEdgeInsetsMake(
      borderInsets.top + paddingInsets.top,
      borderInsets.left + paddingInsets.left,
      borderInsets.bottom + paddingInsets.bottom,
      borderInsets.right + paddingInsets.right);
}

- (CGRect)ABI46_0_0ReactContentFrame
{
  return UIEdgeInsetsInsetRect(self.bounds, self.ABI46_0_0ReactCompoundInsets);
}

#pragma mark - Accessibility

- (UIView *)ABI46_0_0ReactAccessibilityElement
{
  return self;
}

- (NSArray<NSDictionary *> *)accessibilityActions
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setAccessibilityActions:(NSArray<NSDictionary *> *)accessibilityActions
{
  objc_setAssociatedObject(
      self, @selector(accessibilityActions), accessibilityActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)accessibilityLanguage
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setAccessibilityLanguage:(NSString *)accessibilityLanguage
{
  objc_setAssociatedObject(
      self, @selector(accessibilityLanguage), accessibilityLanguage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)accessibilityRole
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setAccessibilityRole:(NSString *)accessibilityRole
{
  objc_setAssociatedObject(self, @selector(accessibilityRole), accessibilityRole, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary<NSString *, id> *)accessibilityState
{
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setAccessibilityState:(NSDictionary<NSString *, id> *)accessibilityState
{
  objc_setAssociatedObject(self, @selector(accessibilityState), accessibilityState, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary<NSString *, id> *)accessibilityValueInternal
{
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setAccessibilityValueInternal:(NSDictionary<NSString *, id> *)accessibilityValue
{
  objc_setAssociatedObject(
      self, @selector(accessibilityValueInternal), accessibilityValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Debug
- (void)ABI46_0_0React_addRecursiveDescriptionToString:(NSMutableString *)string atLevel:(NSUInteger)level
{
  for (NSUInteger i = 0; i < level; i++) {
    [string appendString:@"   | "];
  }

  [string appendString:self.description];
  [string appendString:@"\n"];

  for (UIView *subview in self.subviews) {
    [subview ABI46_0_0React_addRecursiveDescriptionToString:string atLevel:level + 1];
  }
}

- (NSString *)ABI46_0_0React_recursiveDescription
{
  NSMutableString *description = [NSMutableString string];
  [self ABI46_0_0React_addRecursiveDescriptionToString:description atLevel:0];
  return description;
}

@end