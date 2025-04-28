package com.mobilegen

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.opentelemetry.api.GlobalOpenTelemetry
import io.opentelemetry.api.trace.Span
import io.opentelemetry.api.trace.Tracer

class MainActivity : AppCompatActivity() {
    private lateinit var tracer: Tracer

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(android.R.layout.simple_list_item_1)
        tracer = GlobalOpenTelemetry.getTracer("mobileGen-Android")
        simulateTrace()
    }

    private fun simulateTrace() {
        val span: Span = tracer.spanBuilder("android-launch").startSpan()
        span.end()
    }
}
