import React, { useEffect } from 'react';
import { View, Text, Button, StyleSheet } from 'react-native';
import { Embrace } from 'embrace-react-native';
import Config from 'react-native-config';
import { Resource } from '@opentelemetry/resources';
import { NodeTracerProvider } from '@opentelemetry/sdk-trace-base';
import { OTLPTraceExporter } from '@opentelemetry/exporter-otlp-http';
import { SimpleSpanProcessor } from '@opentelemetry/sdk-trace-base';

const provider = new NodeTracerProvider({
  resource: new Resource({
    'service.name': 'mobileGen-react-native'
  })
});

const exporter = new OTLPTraceExporter({
  url: Config.OTEL_EXPORTER_OTLP_ENDPOINT,
  headers: { 'Authorization': Config.OTEL_EXPORTER_OTLP_HEADERS }
});

provider.addSpanProcessor(new SimpleSpanProcessor(exporter));
provider.register();

const tracer = provider.getTracer('mobileGen-react-native');

const App = () => {
  useEffect(() => {
    // Initialize Embrace with key from .env via react-native-config
    Embrace.start(Config.EMBRACE_API_KEY);
    generateTrace();
  }, []);

  const generateTrace = () => {
    const span = tracer.startSpan('react-native-launch');
    span.end();
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>mobileGen React Native</Text>
      <Button title="Generate Trace" onPress={generateTrace} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  title: {
    fontSize: 24,
    marginBottom: 20
  }
});

export default App;
