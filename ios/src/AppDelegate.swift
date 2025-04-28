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
        // Initialize Embrace SDK with key from environment
        guard let key = ProcessInfo.processInfo.environment["EMBRACE_API_KEY"], !key.isEmpty else {
            fatalError("EMBRACE_API_KEY not set in environment")
        }
        Embrace.start(withKey: key)
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
