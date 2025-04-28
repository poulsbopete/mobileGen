package com.mobilegen

import android.app.Application
import com.embrace.Embrace
import io.opentelemetry.api.GlobalOpenTelemetry
import io.opentelemetry.sdk.OpenTelemetrySdk
import io.opentelemetry.sdk.trace.SdkTracerProvider
import io.opentelemetry.sdk.trace.export.BatchSpanProcessor
import io.opentelemetry.exporter.otlp.trace.OtlpGrpcSpanExporter

class MyApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // Initialize Embrace SDK with key from BuildConfig
        Embrace.start(this, BuildConfig.EMBRACE_API_KEY)
        val endpoint = BuildConfig.OTEL_EXPORTER_OTLP_ENDPOINT
        val headers = BuildConfig.OTEL_EXPORTER_OTLP_HEADERS
        val exporter = OtlpGrpcSpanExporter.builder()
            .setEndpoint(endpoint)
            .addHeader("Authorization", headers)
            .build()
        val tracerProvider = SdkTracerProvider.builder()
            .addSpanProcessor(BatchSpanProcessor.builder(exporter).build())
            .build()
        val openTelemetry = OpenTelemetrySdk.builder()
            .setTracerProvider(tracerProvider)
            .build()
        GlobalOpenTelemetry.set(openTelemetry)
    }
}
