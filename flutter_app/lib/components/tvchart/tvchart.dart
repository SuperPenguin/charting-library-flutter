import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chart/commons/localhost.dart';
import 'package:chart/commons/tzdt.dart';
import 'package:chart/components/tvchart/tvchart_types.dart';
import 'package:chart/data/historical.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const _assetsPath = '/assets/tvchart/tvchart.html';

class TVChart extends StatefulWidget {
  @override
  _TVChartState createState() => _TVChartState();
}

class _TVChartState extends State<TVChart> with WidgetsBindingObserver {
  InAppWebViewController? _controller;
  bool _isServerRunning = false;
  bool _isLoading = false;
  bool _isError = false;
  String _isErrorMessage = '';
  bool _showBack = false;

  bool get _chartLoaded {
    return _controller != null && !_isLoading && !_isError;
  }

  void _attachHandler() {
    var controller = _controller;
    if (controller == null) return;

    controller.addJavaScriptHandler(
      handlerName: 'start',
      callback: (arguments) {
        return ChartingLibraryWidgetOptions(
          debug: false,
          locale: 'en',
          symbol: 'COMPOSITE',
          fullscreen: false,
          interval: '1D',
          timezone: 'Asia/Jakarta',
          autosize: true,
          auto_save_delay: 1,
          theme: Theme.of(context).brightness == Brightness.light
              ? 'Light'
              : 'Dark',
          saved_data: _savedData,
          disabled_features: [
            'header_fullscreen_button',
            'header_screenshot',
            'use_localstorage_for_settings',
            'timezone_menu',
            'go_to_date',
            'timeframes_toolbar',
          ],
          enabled_features: ['hide_left_toolbar_by_default'],
        );
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onReady',
      callback: (arguments) {
        return DatafeedConfiguration(
          exchanges: [
            Exchange(
              name: 'IDX',
              value: 'IDX',
              desc: 'Indonesia Stock Exchange',
            ),
          ],
          supported_resolutions: ['D'],
          currency_codes: ['IDR'],
          supports_marks: false,
          supports_time: true,
          supports_timescale_marks: true,
          symbols_types: [
            DatafeedSymbolType(
              name: 'Index',
              value: 'index',
            ),
            DatafeedSymbolType(
              name: 'Stock',
              value: 'stock',
            ),
          ],
        );
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'searchSymbols',
      callback: (arguments) {
        String userInput = arguments[0];
        // Only 1 exchange on example, not needed
        // String exchange = arguments[1];
        String symbolType = arguments[2];

        final result = historical.searchSymbol(userInput, symbolType);
        return result;
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'resolveSymbol',
      callback: (arguments) {
        String symbolName = arguments[0];
        var result = historical.getSymbol(symbolName);

        if (result != null) {
          return result.getLibrarySymbolInfo();
        } else {
          return 'Symbol not found!';
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'getBars',
      callback: (arguments) async {
        LibrarySymbolInfo symbolInfo = LibrarySymbolInfo.fromJson(arguments[0]);
        // Only 1 resolution on example, not needed
        // String resolution = arguments[1];
        int rangeStartDate = arguments[2]; // In seconds not milliseconds
        int rangeEndDate = arguments[3]; // In seconds not milliseconds
        // bool isFirstCall = arguments[4];

        var symbol = historical.getSymbol(symbolInfo.name);
        if (symbol == null) {
          return 'Symbol not found';
        } else {
          var result = await symbol.getDataRange(
            tzMillisecond(rangeStartDate * 1000),
            tzMillisecond(rangeEndDate * 1000),
          );

          return {
            'bars': result
                .map(
                  (e) => Bar(
                    time: e.dt.millisecondsSinceEpoch,
                    open: e.open,
                    high: e.high,
                    low: e.low,
                    close: e.close,
                    volume: e.volume,
                  ),
                )
                .toList(),
            'meta': {
              'noData': result.isEmpty,
            },
          };
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'subscribeBars',
      callback: (arguments) {
        // LibrarySymbolInfo symbolInfo = LibrarySymbolInfo.fromJson(arguments[0]);
        // String resolution = arguments[1];
        // String listenerGuid = arguments[2];
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'unsubscribeBars',
      callback: (arguments) {
        // String listenerGuid = arguments[0];
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'saveData',
      callback: (arguments) {
        if (arguments[0] is Map<String, dynamic>) {
          _savedData = arguments[0];
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _isError = false;
    _isServerRunning = localhostManager.isRunning;
    if (!_isServerRunning) {
      localhostManager.startServer().then((_) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          if (mounted) {
            setState(() {
              _isServerRunning = true;
            });
          }
        });
      });
    }

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    _controller = null;
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (_chartLoaded) {
      _controller!.evaluateJavascript(
        source: WidgetsBinding.instance!.window.platformBrightness ==
                Brightness.dark
            ? 'window.toggleDarkTheme();'
            : 'window.toggleLightTheme();',
      );
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackContent = [];

    if (_isServerRunning) {
      stackContent.add(
        Column(
          children: [
            _showBack
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.adaptive.arrow_back),
                        onPressed: () async {
                          var controller = _controller;
                          if (controller != null) {
                            // Somehow the chart is gone when you press back quick enough ?
                            // See Webview Console output
                            if (await controller.canGoBack()) {
                              await controller.goBack();
                            }

                            setState(() {
                              _showBack = false;
                            });
                          }
                        },
                      ),
                      Text(
                        'Return to Chart',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )
                : SizedBox(),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: localhostManager.getUriWith(
                    path: _assetsPath,
                  ),
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    clearCache: true,
                    supportZoom: false,
                    transparentBackground: true,
                  ),
                ),
                // Pass all gesture to Webview
                gestureRecognizers: [
                  Factory(() => EagerGestureRecognizer()),
                ].toSet(),
                onWebViewCreated: (controller) {
                  _controller = controller;
                  _attachHandler();
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    _isLoading = true;
                    _isError = false;
                    _isErrorMessage = '';
                  });
                },
                onLoadStop: (controller, url) {
                  setState(() {
                    _isLoading = false;
                    _isError = false;
                    // In case host not localhost (ex: got redirected to www.tradingview.com)
                    // Give user UI to call back on Webview
                    _showBack =
                        url != null && url.host != localhostManager.uri.host;
                  });
                },
                onLoadError: (controller, url, code, message) {
                  setState(() {
                    _isLoading = false;
                    _isError = false;
                    _isErrorMessage = '$code - $message';
                    _showBack =
                        url != null && url.host != localhostManager.uri.host;
                  });
                },
                onLoadHttpError: (controller, url, statusCode, description) {
                  setState(() {
                    _isLoading = false;
                    _isError = false;
                    _isErrorMessage = 'HTTP $statusCode - $description';
                    _showBack =
                        url != null && url.host != localhostManager.uri.host;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  final level = consoleMessage.messageLevel.toString();
                  final message = consoleMessage.message;

                  print('Webview Console $level: $message');
                },
              ),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      stackContent.add(CircularProgressIndicator.adaptive());
    }

    if (_isError) {
      stackContent.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error),
            Text(_isErrorMessage),
          ],
        ),
      );
    }

    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: stackContent,
      ),
    );
  }
}

Map<String, dynamic>? _savedData;
