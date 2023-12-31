# @generated by expotools

require './versioned-react-native/ABI49_0_0/ReactNative/scripts/react_native_pods.rb'

use_react_native_ABI49_0_0!(
  :path => './versioned-react-native/ABI49_0_0/ReactNative',
  :hermes_enabled => true,
  :fabric_enabled => false,
)
setup_jsc_ABI49_0_0!(
  :react_native_path => './versioned-react-native/ABI49_0_0/ReactNative',
  :fabric_enabled => false,
)

pod 'ABI49_0_0ExpoKit',
  :path => './versioned-react-native/ABI49_0_0/Expo/ExpoKit',
  :project_name => 'ABI49_0_0',
  :subspecs => ['Expo', 'ExpoOptional']

use_pods! '{versioned,vendored}/sdk49/**/*.podspec.json', 'ABI49_0_0'
