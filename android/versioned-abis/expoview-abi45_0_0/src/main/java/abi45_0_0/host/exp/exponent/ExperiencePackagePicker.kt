package abi45_0_0.host.exp.exponent

import abi45_0_0.expo.modules.ads.admob.AdMobPackage
import abi45_0_0.expo.modules.ads.facebook.AdsFacebookPackage
import abi45_0_0.expo.modules.analytics.amplitude.AmplitudePackage
import abi45_0_0.expo.modules.analytics.segment.SegmentPackage
import abi45_0_0.expo.modules.application.ApplicationPackage
import abi45_0_0.expo.modules.av.AVPackage
import abi45_0_0.expo.modules.backgroundfetch.BackgroundFetchPackage
import abi45_0_0.expo.modules.barcodescanner.BarCodeScannerPackage
import abi45_0_0.expo.modules.battery.BatteryPackage
import abi45_0_0.expo.modules.brightness.BrightnessPackage
import abi45_0_0.expo.modules.calendar.CalendarPackage
import abi45_0_0.expo.modules.camera.CameraPackage
import abi45_0_0.expo.modules.cellular.CellularModule
import abi45_0_0.expo.modules.clipboard.ClipboardModule
import abi45_0_0.expo.modules.constants.ConstantsPackage
import abi45_0_0.expo.modules.contacts.ContactsPackage
import abi45_0_0.expo.modules.core.interfaces.Package
import abi45_0_0.expo.modules.crypto.CryptoPackage
import abi45_0_0.expo.modules.device.DevicePackage
import abi45_0_0.expo.modules.documentpicker.DocumentPickerPackage
import abi45_0_0.expo.modules.easclient.EASClientModule
import abi45_0_0.expo.modules.errorrecovery.ErrorRecoveryPackage
import abi45_0_0.expo.modules.facebook.FacebookPackage
import abi45_0_0.expo.modules.facedetector.FaceDetectorPackage
import abi45_0_0.expo.modules.filesystem.FileSystemPackage
import abi45_0_0.expo.modules.firebase.analytics.FirebaseAnalyticsPackage
import abi45_0_0.expo.modules.firebase.core.FirebaseCorePackage
import abi45_0_0.expo.modules.font.FontLoaderPackage
import abi45_0_0.expo.modules.gl.GLPackage
import abi45_0_0.expo.modules.google.signin.GoogleSignInPackage
import abi45_0_0.expo.modules.haptics.HapticsPackage
import abi45_0_0.expo.modules.imageloader.ImageLoaderPackage
import abi45_0_0.expo.modules.imagemanipulator.ImageManipulatorPackage
import abi45_0_0.expo.modules.imagepicker.ImagePickerPackage
import abi45_0_0.expo.modules.intentlauncher.IntentLauncherPackage
import abi45_0_0.expo.modules.keepawake.KeepAwakePackage
import abi45_0_0.expo.modules.kotlin.ModulesProvider
import abi45_0_0.expo.modules.kotlin.modules.Module
import abi45_0_0.expo.modules.lineargradient.LinearGradientModule
import abi45_0_0.expo.modules.localauthentication.LocalAuthenticationPackage
import abi45_0_0.expo.modules.localization.LocalizationPackage
import abi45_0_0.expo.modules.location.LocationPackage
import abi45_0_0.expo.modules.mailcomposer.MailComposerPackage
import expo.modules.manifests.core.Manifest
import abi45_0_0.expo.modules.medialibrary.MediaLibraryPackage
import abi45_0_0.expo.modules.navigationbar.NavigationBarPackage
import abi45_0_0.expo.modules.network.NetworkPackage
import abi45_0_0.expo.modules.notifications.NotificationsPackage
import abi45_0_0.expo.modules.permissions.PermissionsPackage
import abi45_0_0.expo.modules.print.PrintPackage
import abi45_0_0.expo.modules.screencapture.ScreenCapturePackage
import abi45_0_0.expo.modules.screenorientation.ScreenOrientationPackage
import abi45_0_0.expo.modules.securestore.SecureStorePackage
import abi45_0_0.expo.modules.sensors.SensorsPackage
import abi45_0_0.expo.modules.sharing.SharingPackage
import abi45_0_0.expo.modules.sms.SMSPackage
import abi45_0_0.expo.modules.speech.SpeechPackage
import abi45_0_0.expo.modules.splashscreen.SplashScreenPackage
import abi45_0_0.expo.modules.sqlite.SQLitePackage
import abi45_0_0.expo.modules.storereview.StoreReviewPackage
import abi45_0_0.expo.modules.systemui.SystemUIPackage
import abi45_0_0.expo.modules.taskManager.TaskManagerPackage
import abi45_0_0.expo.modules.updates.UpdatesPackage
import abi45_0_0.expo.modules.videothumbnails.VideoThumbnailsPackage
import abi45_0_0.expo.modules.webbrowser.WebBrowserPackage

object ExperiencePackagePicker : ModulesProvider {
  private val EXPO_MODULES_PACKAGES = listOf(
    AVPackage(),
    AdMobPackage(),
    AdsFacebookPackage(),
    ApplicationPackage(),
    AmplitudePackage(),
    BatteryPackage(),
    BackgroundFetchPackage(),
    BarCodeScannerPackage(),
    BrightnessPackage(),
    CalendarPackage(),
    CameraPackage(),
    ConstantsPackage(),
    ContactsPackage(),
    CryptoPackage(),
    DevicePackage(),
    DocumentPickerPackage(),
    ErrorRecoveryPackage(),
    FacebookPackage(),
    FaceDetectorPackage(),
    FileSystemPackage(),
    FirebaseCorePackage(),
    FirebaseAnalyticsPackage(),
    FontLoaderPackage(),
    GLPackage(),
    GoogleSignInPackage(),
    HapticsPackage(),
    ImageLoaderPackage(),
    ImageManipulatorPackage(),
    ImagePickerPackage(),
    IntentLauncherPackage(),
    KeepAwakePackage(),
    LocalAuthenticationPackage(),
    LocalizationPackage(),
    LocationPackage(),
    MailComposerPackage(),
    MediaLibraryPackage(),
    NavigationBarPackage(),
    NetworkPackage(),
    NotificationsPackage(),
    PermissionsPackage(),
    PrintPackage(),
    SMSPackage(),
    StoreReviewPackage(),
    SQLitePackage(),
    ScreenCapturePackage(),
    ScreenOrientationPackage(),
    SecureStorePackage(),
    SegmentPackage(),
    SensorsPackage(),
    SharingPackage(),
    SpeechPackage(),
    SplashScreenPackage(),
    SystemUIPackage(),
    TaskManagerPackage(),
    UpdatesPackage(),
    VideoThumbnailsPackage(),
    WebBrowserPackage()
  )

  /**
   * Returns all available packages.
   */
  fun packages(): List<Package> {
    return EXPO_MODULES_PACKAGES
  }

  /**
   * Returns packages filtered based on the app's manifest.
   * For now, filtering is not applied but it is on the todo list.
   */
  fun packages(manifest: Manifest?): List<Package> {
    return EXPO_MODULES_PACKAGES
  }

  override fun getModulesList(): List<Class<out Module>> = listOf(
    CellularModule::class.java,
    ClipboardModule::class.java,
    EASClientModule::class.java,
    LinearGradientModule::class.java,
  )
}