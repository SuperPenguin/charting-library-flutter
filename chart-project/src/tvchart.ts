import * as TradingView from "./charting_library/charting_library";

declare global {
  interface Window {
    flutter_inappwebview: {
      callHandler: (handlerName: string, ...args: any) => Promise<any>;
    };
    toggleDarkTheme: () => void;
    toggleLightTheme: () => void;
    callOnTick: (payload: string) => void;
  }
}

const onTickMap: Map<String, TradingView.SubscribeBarsCallback> = new Map();

const datafeed: TradingView.IBasicDataFeed = {
  onReady: (callback: TradingView.OnReadyCallback) => {
    window.flutter_inappwebview.callHandler("onReady").then((result) => {
      callback(result);
    });
  },
  searchSymbols: (
    userInput: string,
    exchange: string,
    symbolType: string,
    onResult: TradingView.SearchSymbolsCallback
  ) => {
    window.flutter_inappwebview
      .callHandler("searchSymbols", userInput, exchange, symbolType)
      .then((value) => {
        if (Array.isArray(value)) {
          onResult(value);
        } else {
          onResult([]);
        }
      })
      .catch((reason) => {
        onResult([]);
      });
  },
  resolveSymbol: (
    symbolName: string,
    onResolve: TradingView.ResolveCallback,
    onError: TradingView.ErrorCallback,
    extension: TradingView.SymbolResolveExtension
  ) => {
    window.flutter_inappwebview
      .callHandler("resolveSymbol", symbolName)
      .then((value) => {
        if (value !== null && typeof value === "object") {
          onResolve(value as TradingView.LibrarySymbolInfo);
        } else if (typeof value === "string") {
          onError(value);
        } else {
          onError("Unexpected resolveSymbol return type");
        }
      })
      .catch((reason) => {
        onError("Unexpected error on resolveSymbol");
      });
  },
  getBars: (
    symbolInfo: TradingView.LibrarySymbolInfo,
    resolution: TradingView.ResolutionString,
    periodParams: TradingView.PeriodParams,
    onResult: TradingView.HistoryCallback,
    onError: TradingView.ErrorCallback
  ) => {
    window.flutter_inappwebview
      .callHandler("getBars", symbolInfo, resolution, periodParams)
      .then((value) => {
        if (value !== null && typeof value === "object") {
          onResult(value.bars, value.meta);
        } else if (typeof value === "string") {
          onError(value);
        } else {
          onError("Unexpected getBars return type");
        }
      })
      .catch((reason) => {
        onError("Unexpected error on getBars");
      });
  },
  subscribeBars: (
    symbolInfo: TradingView.LibrarySymbolInfo,
    resolution: TradingView.ResolutionString,
    onTick: TradingView.SubscribeBarsCallback,
    listenerGuid: string,
    onResetCacheNeededCallback: () => void
  ) => {
    onTickMap.set(listenerGuid, onTick);

    window.flutter_inappwebview.callHandler(
      "subscribeBars",
      symbolInfo,
      resolution,
      listenerGuid
    );
  },
  unsubscribeBars: (listenerGuid: string) => {
    onTickMap.delete(listenerGuid);

    window.flutter_inappwebview.callHandler("unsubscribeBars", listenerGuid);
  }
};

let chart: TradingView.IChartingLibraryWidget | undefined;

function toggleLightTheme() {
  if (chart != undefined) {
    chart.changeTheme("Light");
  }
}
window.toggleLightTheme = toggleLightTheme;

function toggleDarkTheme() {
  if (chart != undefined) {
    chart.changeTheme("Dark");
  }
}
window.toggleDarkTheme = toggleDarkTheme;

function callOnTick(payload: string) {
  const payloadObject: Record<string, any> = JSON.parse(payload);
  const listenerGuid: string | undefined = payloadObject["listenerGuid"];
  const bar: TradingView.Bar | undefined = payloadObject["bar"];

  if (listenerGuid == undefined || bar == undefined) return;

  if (onTickMap.has(listenerGuid)) {
    const onTick = onTickMap.get(listenerGuid);
    onTick(bar);
  }
}
window.callOnTick = callOnTick;

window.addEventListener("flutterInAppWebViewPlatformReady", (event) => {
  window.flutter_inappwebview
    .callHandler("start")
    .then((options: TradingView.ChartingLibraryWidgetOptions) => {
      options.container = "tvchart";
      options.library_path = "public/";
      options.datafeed = datafeed;

      if (chart == undefined) {
        console.log(TradingView.version());
        chart = new TradingView.widget(options);
        chart.onChartReady(() => {
          chart.subscribe("onAutoSaveNeeded", () => {
            chart.save((state) => {
              window.flutter_inappwebview.callHandler("saveData", state);
            });
          });
        });
      }
    });
});
