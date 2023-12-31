package abi47_0_0.expo.modules.kotlin.types

import abi47_0_0.expo.modules.kotlin.jni.ExpectedType
import kotlin.reflect.KType

fun KType.toAnyType(): AnyType = AnyType(this)

class AnyType(val kType: KType) {
  private val converter: TypeConverter<*> by lazy {
    TypeConverterProviderImpl.obtainTypeConverter(kType)
  }

  fun convert(value: Any?): Any? = converter.convert(value)

  fun getCppRequiredTypes(): ExpectedType = converter.getCppRequiredTypes()
}
