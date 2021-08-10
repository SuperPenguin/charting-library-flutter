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
  LocalhostManager._internal();

  InAppLocalhostServer? _localhostServer;

  bool get isRunning => _localhostServer?.isRunning() ?? false;

  final _uri = Uri(
    scheme: 'http',
    host: 'localhost',
    port: port,
  );

  Uri get uri => _uri.replace();
  Uri getUriWith({String? path}) => _uri.replace(path: path);

  Future<void> startServer() async {
    if (!isRunning) {
      final server = InAppLocalhostServer(port: port);
      _localhostServer = server;
      await server.start();
    }
  }

  Future<void> stopServer() async {
    if (isRunning) {
      final server = _localhostServer!;
      await server.close();
      _localhostServer = null;
    }
  }
}
