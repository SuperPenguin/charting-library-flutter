import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

LocalhostManager get localhostManager {
  var instance = LocalhostManager._instance;
  if (instance == null) {
    instance = LocalhostManager._internal();
    LocalhostManager._instance = instance;
  }

  return instance;
}

class LocalhostManager {
  static const int port = 8080;
  static LocalhostManager? _instance;
  LocalhostManager._internal() {
    _localhostServer = InAppLocalhostServer(
      port: port,
    );
  }

  late InAppLocalhostServer _localhostServer;

  bool get isRunning => _localhostServer.isRunning();

  Uri _uri = Uri(
    scheme: 'http',
    host: 'localhost',
    port: port,
  );

  Uri get uri => _uri.replace();
  Uri getUriWith({
    // String? query,
    // Map<String, dynamic>? queryParameters,
    String? path,
    // Iterable<String>? pathSegments,
  }) =>
      _uri.replace(
        // query: query,
        // queryParameters: queryParameters,
        path: path,
        // pathSegments: pathSegments,
      );

  Future<void> startServer() async {
    if (!_localhostServer.isRunning()) {
      await _localhostServer.start();
    }
  }
}
