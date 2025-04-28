import UIKit
import Embrace
import OpenTelemetryApi
import OpenTelemetrySdk
import OpenTelemetryProtocolExporter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Embrace.start(withKey: "b9cb8c2b9e2d448fa49241eb3c347d22")
        let endpoint = ProcessInfo.processInfo.environment["OTEL_EXPORTER_OTLP_ENDPOINT"] ?? ""
        let headers = ProcessInfo.processInfo.environment["OTEL_EXPORTER_OTLP_HEADERS"] ?? ""
        let exporter = OtlpTraceExporter(endpoint: endpoint, headers: ["Authorization": headers])
        let spanProcessor = SimpleSpanProcessor(spanExporter: exporter)
        let tracerProvider = TracerProviderBuilder()
            .add(spanProcessor: spanProcessor)
            .build()
        OpenTelemetry.registerTracerProvider(tracerProvider)
        simulateTrace()
        return true
    }

    func simulateTrace() {
        let tracer = OpenTelemetry.instance.tracerProvider.get(instrumentationName: "mobileGen-iOS")
        let span = tracer.spanBuilder(spanName: "ios-launch").startSpan()
        span.end()
    }
}
