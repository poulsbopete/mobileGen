# mobileGen

This repository contains sample mobile applications (Android, iOS, React Native) that generate synthetic distributed traces using:

- Embrace.io mobile SDK (API Key: `123`)
- OpenTelemetry SDK and OTLP exporter for Elastic APM

## Environment Variables

First copy `.env.example` to `.env` and fill in your values:

```bash
cp .env.example .env
```

Set before building/running:

- `EMBRACE_API_KEY`: Your Embrace.io mobile SDK API key
- `OTEL_EXPORTER_OTLP_ENDPOINT`: e.g. `https://otel-demo-a5630c.apm.us-east-1.aws.elastic.cloud:443`
- `OTEL_EXPORTER_OTLP_HEADERS`: e.g. `ApiKey 123==`

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
