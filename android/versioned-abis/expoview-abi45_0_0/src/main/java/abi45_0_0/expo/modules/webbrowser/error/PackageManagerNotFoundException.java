package abi45_0_0.expo.modules.webbrowser.error;

import abi45_0_0.expo.modules.core.errors.CodedException;

public class PackageManagerNotFoundException extends CodedException {

  public PackageManagerNotFoundException() {
    super("Package Manager not found!");
  }
}