# mobileGen

This repository contains sample mobile applications (Android, iOS, React Native) that generate synthetic distributed traces using:

- Embrace.io mobile SDK (API Key: `b9cb8c2b9e2d448fa49241eb3c347d22`)
- OpenTelemetry SDK and OTLP exporter for Elastic APM

## Environment Variables

Set before building/running:

- `OTEL_EXPORTER_OTLP_ENDPOINT`: e.g. `https://otel-demo-a5630c.apm.us-east-1.aws.elastic.cloud:443`
- `OTEL_EXPORTER_OTLP_HEADERS`: e.g. `ApiKey UjYyUWM1WUJXM0ZuaU1RdFFKa3Q6VzNBc29PZ0g2RXJqYmdXYWstMnBrUQ==`

## Directory Structure

- `android/` — Android (Kotlin) sample
- `ios/` — iOS (Swift) sample (skeleton, integrate into your Xcode project)
- `react-native/` — React Native (JS) sample

## Getting Started

### Android

```bash
cd android
# ensure you have Gradle installed or use the Gradle wrapper if configured
gradle assembleDebug
gradle installDebug
```

### iOS

```bash
cd ios
pod install
# add AppDelegate.swift from src/ into your Xcode project and build
```

### React Native

```bash
cd react-native
npm install
npx react-native run-android  # or run-ios
```
