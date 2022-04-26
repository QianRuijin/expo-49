#import <ABI45_0_0ExpoModulesCore/ABI45_0_0EXUIManager.h>
#import <ABI45_0_0ExpoModulesCore/ABI45_0_0EXEventEmitterService.h>
#import <ABI45_0_0ExpoModulesCore/ABI45_0_0EXUtilitiesInterface.h>
#import <ABI45_0_0EXAdsAdMob/ABI45_0_0EXAdsAdMobInterstitial.h>

static NSString *const ABI45_0_0EXAdsAdMobInterstitialDidLoad = @"interstitialDidLoad";
static NSString *const ABI45_0_0EXAdsAdMobInterstitialDidFailToLoad = @"interstitialDidFailToLoad";
static NSString *const ABI45_0_0EXAdsAdMobInterstitialDidOpen = @"interstitialDidOpen";
static NSString *const ABI45_0_0EXAdsAdMobInterstitialDidClose = @"interstitialDidClose";
static NSString *const ABI45_0_0EXAdsAdMobInterstitialDidFailToOpen = @"interstitialDidFailToOpen";

@interface ABI45_0_0EXAdsAdMobInterstitial ()

@property (nonatomic, weak) id<ABI45_0_0EXEventEmitterService> eventEmitter;
@property (nonatomic, weak) id<ABI45_0_0EXUtilitiesInterface> utilities;
@property (nonatomic, strong) GADInterstitialAd *ad;

@end

@implementation ABI45_0_0EXAdsAdMobInterstitial {
  NSString *_adUnitID;
  bool _hasListeners;
  ABI45_0_0EXPromiseResolveBlock _showAdResolver;
  ABI45_0_0EXPromiseRejectBlock _showAdRejecter;
  ABI45_0_0EXPromiseResolveBlock _requestAdResolver;
  ABI45_0_0EXPromiseRejectBlock _requestAdRejecter;
}

ABI45_0_0EX_EXPORT_MODULE(ExpoAdsAdMobInterstitialManager);

- (void)setModuleRegistry:(ABI45_0_0EXModuleRegistry *)moduleRegistry
{
  _utilities = [moduleRegistry getModuleImplementingProtocol:@protocol(ABI45_0_0EXUtilitiesInterface)];
  _eventEmitter = [moduleRegistry getModuleImplementingProtocol:@protocol(ABI45_0_0EXEventEmitterService)];
}

- (NSArray<NSString *> *)supportedEvents
{
  return @[
    ABI45_0_0EXAdsAdMobInterstitialDidLoad,
    ABI45_0_0EXAdsAdMobInterstitialDidFailToLoad,
    ABI45_0_0EXAdsAdMobInterstitialDidOpen,
    ABI45_0_0EXAdsAdMobInterstitialDidFailToOpen,
    ABI45_0_0EXAdsAdMobInterstitialDidClose,
  ];
}

- (void)startObserving {
  _hasListeners = YES;
}

- (void)_maybeSendEventWithName:(NSString *)name body:(id)body {
  if (_hasListeners) {
    [_eventEmitter sendEventWithName:name body:body];
  }
}

- (void)stopObserving {
  _hasListeners = NO;
}

ABI45_0_0EX_EXPORT_METHOD_AS(setAdUnitID,
                    setAdUnitID:(NSString *)adUnitID
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  _adUnitID = adUnitID;
  resolve(nil);
}

ABI45_0_0EX_EXPORT_METHOD_AS(requestAd,
                    requestAdWithAdditionalRequestParams:(NSDictionary *)additionalRequestParams
                    resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  ABI45_0_0EX_WEAKIFY(self)
  if (_ad) {
    dispatch_async(dispatch_get_main_queue(), ^{
      ABI45_0_0EX_ENSURE_STRONGIFY(self);

      NSError *error;
      if ([self.ad canPresentFromRootViewController:self.utilities.currentViewController error:&error]) {
        [self requestAdWithParams:additionalRequestParams
                         resolver:resolve
                         rejecter:reject];
      } else {
        reject(@"E_AD_CANNOT_PRESENT", @"Add cannot be presented", error);
      }
    });
  } else {
    [self requestAdWithParams:additionalRequestParams
                     resolver:resolve
                     rejecter:reject];
  }
}

- (void)requestAdWithParams:(NSDictionary *)additionalRequestParams
                   resolver:(ABI45_0_0EXPromiseResolveBlock)resolve
                   rejecter:(ABI45_0_0EXPromiseRejectBlock)reject
{
  _requestAdResolver = resolve;
  _requestAdRejecter = reject;
  
  
  GADRequest *request = [GADRequest request];
  if (additionalRequestParams) {
    GADExtras *extras = [[GADExtras alloc] init];
    extras.additionalParameters = additionalRequestParams;
    [request registerAdNetworkExtras:extras];
  }
  
  ABI45_0_0EX_WEAKIFY(self);
  [GADInterstitialAd loadWithAdUnitID:_adUnitID
                              request:request
                    completionHandler:^(GADInterstitialAd * _Nullable interstitialAd,
                                        NSError * _Nullable error) {
    ABI45_0_0EX_ENSURE_STRONGIFY(self);
  
    if (error) {
      [self _maybeSendEventWithName:ABI45_0_0EXAdsAdMobInterstitialDidFailToLoad body:@{ @"name": [error description] }];
      self->_requestAdRejecter(@"E_AD_REQUEST_FAILED", [error description], error);
      [self cleanupRequestAdPromise];
      return;
    }
    
    self.ad = interstitialAd;
    self.ad.fullScreenContentDelegate = self;
    
    [self _maybeSendEventWithName:ABI45_0_0EXAdsAdMobInterstitialDidLoad body:nil];
    self->_requestAdResolver(nil);
    [self cleanupRequestAdPromise];
  }];
  
}

ABI45_0_0EX_EXPORT_METHOD_AS(showAd,
                    showAd:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  if (_ad && _showAdResolver == nil) {
    _showAdResolver = resolve;
    _showAdRejecter = reject;
    ABI45_0_0EX_WEAKIFY(self);
    dispatch_async(dispatch_get_main_queue(), ^{
      ABI45_0_0EX_ENSURE_STRONGIFY(self);
      [self.ad presentFromRootViewController:self.utilities.currentViewController];
    });
  } else if (_showAdResolver != nil) {
    reject(@"E_AD_ALREADY_SHOWING", @"An ad is already being shown, await the first promise.", nil);
  } else {
    reject(@"E_AD_NOT_READY", @"Ad is not ready.", nil);
  }
}

ABI45_0_0EX_EXPORT_METHOD_AS(dismissAd,
                    dismissAd:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  ABI45_0_0EX_WEAKIFY(self);
  dispatch_async(dispatch_get_main_queue(), ^{
    ABI45_0_0EX_ENSURE_STRONGIFY(self);
    UIViewController *presentedViewController = self.utilities.currentViewController;
    if (presentedViewController != nil && [NSStringFromClass([presentedViewController class]) hasPrefix:@"GAD"]) {
      [presentedViewController dismissViewControllerAnimated:true completion:^{
        ABI45_0_0EX_ENSURE_STRONGIFY(self);
        self.ad = nil;
        resolve(nil);
      }];
    } else {
      reject(@"E_AD_NOT_SHOWN", @"Ad is not being shown.", nil);
    }
  });
}

ABI45_0_0EX_EXPORT_METHOD_AS(getIsReady,
                    getIsReady:(ABI45_0_0EXPromiseResolveBlock)resolve
                    rejecter:(ABI45_0_0EXPromiseRejectBlock)reject)
{
  resolve([NSNumber numberWithBool:_ad != nil]);
}

- (void)cleanupRequestAdPromise
{
  _requestAdResolver = nil;
  _requestAdRejecter = nil;
}

- (void)cleanupShowAdPromise
{
  _showAdResolver = nil;
  _showAdRejecter = nil;
}

#pragma mark - GADFullScreenContentDelegate

- (void)adDidPresentFullScreenContent:(id)ad {
  [self _maybeSendEventWithName:ABI45_0_0EXAdsAdMobInterstitialDidOpen body:nil];
  _showAdResolver(nil);
  [self cleanupShowAdPromise];
  
}

- (void)ad:(id)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
  [self _maybeSendEventWithName:ABI45_0_0EXAdsAdMobInterstitialDidFailToOpen body:nil];
  _showAdRejecter(@"E_AD_SHOW_FAILED", @"Ad failed to present full screen content", error);
  [self cleanupShowAdPromise];
}

- (void)adDidDismissFullScreenContent:(id)ad {
  [self _maybeSendEventWithName:ABI45_0_0EXAdsAdMobInterstitialDidClose body:nil];
}

@end