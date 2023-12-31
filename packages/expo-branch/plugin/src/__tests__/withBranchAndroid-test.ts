import { AndroidConfig } from 'expo/config-plugins';
import { resolve } from 'path';

import { getBranchApiKey, setBranchApiKey } from '../withBranchAndroid';

const { findMetaDataItem, getMainApplication, readAndroidManifestAsync } = AndroidConfig.Manifest;

const fixturesPath = resolve(__dirname, 'fixtures');

const sampleManifestPath = resolve(fixturesPath, 'react-native-AndroidManifest.xml');

describe(getBranchApiKey, () => {
  it(`returns null if no android branch api key is provided`, () => {
    expect(getBranchApiKey({ android: { config: {} } } as any)).toBe(null);
  });

  it(`returns apikey if android branch api key is provided`, () => {
    expect(
      getBranchApiKey({ android: { config: { branch: { apiKey: 'MY-API-KEY' } } } } as any)
    ).toBe('MY-API-KEY');
  });
});

describe(setBranchApiKey, () => {
  it('sets branch api key in AndroidManifest.xml if given', async () => {
    let androidManifestJson = await readAndroidManifestAsync(sampleManifestPath);
    androidManifestJson = await setBranchApiKey(
      { android: { config: { branch: { apiKey: 'MY-API-KEY' } } } } as any,
      androidManifestJson
    );
    let mainApplication = getMainApplication(androidManifestJson);

    expect(findMetaDataItem(mainApplication, 'io.branch.sdk.BranchKey')).toBeGreaterThan(-1);

    // Unset the item

    androidManifestJson = await setBranchApiKey(
      { android: { config: { branch: { apiKey: null } } } } as any,
      androidManifestJson
    );
    mainApplication = getMainApplication(androidManifestJson);

    expect(findMetaDataItem(mainApplication, 'io.branch.sdk.BranchKey')).toBe(-1);
  });
});
