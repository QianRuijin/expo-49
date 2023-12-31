import * as React from 'react';

import { Image } from '../Image';

const icon = require('../../assets/performance-icon.png');

export function PerformanceIcon(props: Partial<React.ComponentProps<typeof Image>>) {
  return <Image source={icon} {...props} />;
}
