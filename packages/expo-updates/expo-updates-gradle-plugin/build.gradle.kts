import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
  kotlin("jvm") version "1.8.10"
  id("java-gradle-plugin")
}

repositories {
  google()
  mavenCentral()
}

dependencies {
  implementation(gradleApi())
  implementation("com.android.tools.build:gradle:7.4.2")
  implementation("com.facebook.react:react-native-gradle-plugin")
}

java {
  sourceCompatibility = JavaVersion.VERSION_11
  targetCompatibility = JavaVersion.VERSION_11
}

tasks.withType<KotlinCompile> {
  kotlinOptions {
    jvmTarget = JavaVersion.VERSION_11.toString()
  }
}

group = "expo.modules"

gradlePlugin {
  plugins {
    register("expoUpdatesPlugin") {
      id = "expo-updates-gradle-plugin"
      implementationClass = "expo.modules.updates.ExpoUpdatesPlugin"
    }
  }
}
