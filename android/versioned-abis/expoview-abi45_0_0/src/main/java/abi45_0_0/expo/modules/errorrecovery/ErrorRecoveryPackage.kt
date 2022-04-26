package abi45_0_0.expo.modules.errorrecovery

import android.content.Context

import abi45_0_0.expo.modules.core.BasePackage
import abi45_0_0.expo.modules.core.ExportedModule

class ErrorRecoveryPackage : BasePackage() {
  override fun createExportedModules(context: Context): List<ExportedModule> = listOf(ErrorRecoveryModule(context))
}