// Copyright 2015-present 650 Industries. All rights reserved.

#import <ABI45_0_0EXSegment/ABI45_0_0EXSegment.h>
#import <Analytics/SEGAnalytics.h>

static NSString *const ABI45_0_0EXSegmentEnabledKey = @"ABI45_0_0EXSegmentEnabledKey";

@interface ABI45_0_0EXSegment ()

@property (nonatomic, strong) SEGAnalytics *instance;

@end

@implementation ABI45_0_0EXSegment

ABI45_0_0EX_EXPORT_MODULE(ExponentSegment)

ABI45_0_0EX_EXPORT_METHOD_AS(initialize,
                    initialize:(NSString *)writeKey
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  SEGAnalyticsConfiguration *configuration = [SEGAnalyticsConfiguration configurationWithWriteKey:writeKey];
  NSNumber *enabledSetting = [[NSUserDefaults standardUserDefaults] objectForKey:ABI45_0_0EXSegmentEnabledKey];
  _instance = [[SEGAnalytics alloc] initWithConfiguration:configuration];
  if (enabledSetting != nil && ![enabledSetting boolValue]) {
    [_instance disable];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(identify,
                    identify:(NSString *)userId
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance identify:userId];
  }
  resolve(nil);
}


 ABI45_0_0EX_EXPORT_METHOD_AS(identifyWithTraits,
                     identifyWithTraits:(NSString *)userId
                     withTraits:(NSDictionary *)traits
                     withOptions:(nullable NSDictionary *)options
                     resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                     rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance identify:userId traits:traits options:options];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(track,
                    track:(NSString *)event
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance track:event];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(trackWithProperties,
                    trackWithProperties:(NSString *)event 
                    withProperties:(NSDictionary *)properties
                    withOptions:(nullable NSDictionary *)options
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance track:event properties:properties options:options];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(group,
                    group:(NSString *)groupId
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance group:groupId];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(groupWithTraits,
                    groupWithTraits:(NSString *)groupId
                    withTraits:(NSDictionary *)traits
                    withOptions:(nullable NSDictionary *)options
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance group:groupId traits:traits options:options];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(alias,
                    alias:(NSString *)newId
                    withOptions:(nullable NSDictionary *)options
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  SEGAnalytics *analytics = _instance;
  if (analytics) {
    [analytics alias:newId options:options];
    resolve(ABI45_0_0EXNullIfNil(nil));
  } else {
    reject(@"E_NO_SEG", @"Segment instance has not been initialized yet, have you tried calling Segment.initialize prior to calling Segment.alias?", nil);
  }
}

ABI45_0_0EX_EXPORT_METHOD_AS(screen,
                    screen:(NSString *)screenName
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance screen:screenName];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(screenWithProperties,
                    screenWithProperties:(NSString *)screenName
                    withProperties:(NSDictionary *)properties
                    withOptions:(NSDictionary *)options
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance screen:screenName properties:properties options:options];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(reset,
                    resetWithResolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance reset];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(flush,
                    flushWithResolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_instance) {
    [_instance flush];
  }
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(getEnabledAsync,
                    getEnabledWithResolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  NSNumber *optOutSetting = [[NSUserDefaults standardUserDefaults] objectForKey:ABI45_0_0EXSegmentEnabledKey];
  // default is enabled: true
  resolve(optOutSetting ?: @(YES));
}

ABI45_0_0EX_EXPORT_METHOD_AS(setEnabledAsync,
                    setEnabled:(BOOL)enabled
                    withResolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:ABI45_0_0EXSegmentEnabledKey];
  if (_instance) {
    if (enabled) {
      [_instance enable];
    } else {
      [_instance disable];
    }
  }
  resolve(nil);
}

@end