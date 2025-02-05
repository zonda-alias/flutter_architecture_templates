# flutter_architecture_templates

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

flutter pub run change_app_package_name:main com.new.package.name

flutter packages pub run build_runner build --delete-conflicting-outputs

# https://fvm.app/documentation/guides/basic-commands
fvm releases

# https://docs.flutter.dev/release/upgrade
fvm flutter pub upgrade --major-versions


# native_flutter_proxy

buildscript {
    ext.kotlin_version = '1.9.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:8.4.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

android {
    namespace 'com.victorblaess.native_flutter_proxy'
    compileSdk 35
    ... ...

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = '17'
    }