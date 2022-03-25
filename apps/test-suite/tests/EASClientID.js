'use strict';

import * as EASClientID from 'expo-eas-client-id';

export const name = 'EASClientID';

export function test(t) {
  t.describe('EASClientID', () => {
    t.it('gets the EAS client ID', async () => {
      const clientId = await EASClientID.getClientIDAsync();
      t.expect(clientId).toBeTruthy();
      const clientId2 = await EASClientID.getClientIDAsync();
      t.expect(clientId).toEqual(clientId2);
    });
  });
}