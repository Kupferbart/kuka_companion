import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'environment_configuration.g.dart';

@riverpod
EnvironmentConfiguration environmentConfiguration(
    EnvironmentConfigurationRef ref) {
  //if (const String.fromEnvironment('ENVIRONMENT') == 'custom') {
  if (true) {
    return const EnvironmentConfiguration(
      devPanel: DevPanelConfiguration(
        enabled: true,
      ),
      matrix: MatrixConfiguration(
        repository: MatrixRepositoryConfiguration(
          websocketUrl: 'wss://ws.postman-echo.com/raw',
          //websocketUrl: 'ws://10.200.87.54:8001',

          logIncomingMessages: true,
          logOutgoingMessages: true,
          logDebugMessages: true,
        ),
      ),
    );
  }
  return const EnvironmentConfiguration();
}

class EnvironmentConfiguration {
  final DevPanelConfiguration devPanel;
  final MatrixConfiguration matrix;

  const EnvironmentConfiguration({
    this.devPanel = const DevPanelConfiguration(),
    this.matrix = const MatrixConfiguration(),
  });
}

class DevPanelConfiguration {
  final bool enabled;

  const DevPanelConfiguration({
    this.enabled = false,
  });
}

class MatrixConfiguration {
  final MatrixRepositoryConfiguration repository;

  const MatrixConfiguration({
    this.repository = const MatrixRepositoryConfiguration(),
  });
}

class MatrixRepositoryConfiguration {
  final String websocketUrl;
  final bool logIncomingMessages;
  final bool logOutgoingMessages;
  final bool logDebugMessages;

  const MatrixRepositoryConfiguration({
    this.websocketUrl = 'wss://ws.postman-echo.com/raw',
    this.logIncomingMessages = false,
    this.logOutgoingMessages = false,
    this.logDebugMessages = false,
  });
}
