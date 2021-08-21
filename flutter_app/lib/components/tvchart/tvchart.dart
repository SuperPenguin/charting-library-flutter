import 'dart:convert';

import 'package:chart/commons/localhost.dart';
import 'package:chart/commons/tzdt.dart';
import 'package:chart/components/tvchart/tvchart_types.dart';
import 'package:chart/data/historical.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const _assetsPath = '/assets/tvchart/tvchart.html';

class TVChart extends StatefulWidget {
  const TVChart({Key? key}) : super(key: key);

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
  final Map<String, _OnTickInfo> _onTickMap = {};

  bool get _chartLoaded {
    return _controller != null && !_isLoading && !_isError;
  }

  // ignore: unused_element
  void _callOnTick(String listenerGuid, Bar bar) {
    if (_chartLoaded) {
      final controller = _controller!;
      final Map<String, dynamic> payload = {
        'listenerGuid': listenerGuid,
        'bar': bar,
      };

      controller.evaluateJavascript(
        source: 'window.callOnTick(`${jsonEncode(payload)}`);',
      );
    }
  }

  void _attachHandler() {
    final controller = _controller;
    if (controller == null) return;

    controller.addJavaScriptHandler(
      handlerName: 'start',
      callback: (arguments) {
        return ChartingLibraryWidgetOptions(
          debug: false,
          locale: 'en',
          symbol: 'IDX:COMPOSITE',
          fullscreen: false,
          interval: '1D',
          timezone: Timezone.asiaJakarta,
          autosize: true,
          autoSaveDelay: 1,
          theme: Theme.of(context).brightness == Brightness.light
              ? ChartTheme.light
              : ChartTheme.dark,
          savedData: _savedData,
          disabledFeatures: const [
            'header_fullscreen_button',
            'header_screenshot',
            'use_localstorage_for_settings',
            'timezone_menu',
            'go_to_date',
            'timeframes_toolbar',
          ],
          enabledFeatures: const ['hide_left_toolbar_by_default'],
        );
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onReady',
      callback: (arguments) {
        return const DatafeedConfiguration(
          exchanges: [
            // Exchange(
            //   name: 'IDX',
            //   value: 'IDX',
            //   desc: 'Indonesia Stock Exchange',
            // ),
          ],
          supportedResolutions: ['1D'],
          currencyCodes: ['IDR'],
          supportsMarks: false,
          supportsTime: true,
          supportsTimescaleMarks: true,
          symbolsTypes: [
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
        final String userInput = arguments[0];
        // Only 1 exchange on example, not needed
        // final String exchange = arguments[1];
        final String symbolType = arguments[2];

        final List<SearchSymbolResultItem> result =
            historical.searchSymbol(userInput, symbolType);
        return result;
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'resolveSymbol',
      callback: (arguments) {
        final String symbolName = arguments[0];
        final SymbolData? result = historical.getSymbol(symbolName);

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
        final LibrarySymbolInfo symbolInfo =
            LibrarySymbolInfo.fromJson(arguments[0]);
        // Only 1 resolution on example, not needed
        // final String resolution = arguments[1];
        final PeriodParams periodParams = PeriodParams.fromJson(arguments[2]);

        var symbol = historical.getSymbol(symbolInfo.name);
        if (symbol == null) {
          return 'Symbol not found';
        } else {
          var result = await symbol.getDataRange(
            tzMillisecond(periodParams.from * 1000),
            tzMillisecond(periodParams.to * 1000),
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
        final LibrarySymbolInfo symbolInfo =
            LibrarySymbolInfo.fromJson(arguments[0]);
        final String resolution = arguments[1];
        final String listenerGuid = arguments[2];

        if (_onTickMap.containsKey(listenerGuid)) {
          // Dispose existing onTick with same ID
        }

        _onTickMap[listenerGuid] = _OnTickInfo(
          symbolInfo: symbolInfo,
          resolution: resolution,
        );

        // Do request for realtime data
        // Use _callOnTick for returning realtime bar data
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'unsubscribeBars',
      callback: (arguments) {
        final String listenerGuid = arguments[0];

        if (_onTickMap.containsKey(listenerGuid)) {
          // Dispose existing onTick
        }
        _onTickMap.remove(listenerGuid);
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
    _onTickMap.forEach((key, value) {
      // Dispose all onTick request/stream
    });

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
                : const SizedBox(),
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
                gestureRecognizers: {
                  Factory(() => EagerGestureRecognizer()),
                },
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
                  if (kDebugMode) {
                    final level = consoleMessage.messageLevel.toString();
                    final message = consoleMessage.message;
                    // ignore: avoid_print
                    print('Webview Console $level: $message');
                  }
                },
              ),
            ),
          ],
        ),
      );
    }

    if (_isLoading) {
      stackContent.add(const CircularProgressIndicator.adaptive());
    }

    if (_isError) {
      stackContent.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error),
            Text(_isErrorMessage),
          ],
        ),
      );
    }

    // ignore: avoid_unnecessary_containers
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: stackContent,
      ),
    );
  }
}

Map<String, dynamic>? _savedData;

@immutable
class _OnTickInfo {
  final LibrarySymbolInfo symbolInfo;
  final String resolution;

  const _OnTickInfo({
    required this.symbolInfo,
    required this.resolution,
  });
}
