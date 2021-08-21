import 'package:flutter/foundation.dart';
import 'package:chart/commons/random.dart';
import 'package:chart/commons/tzdt.dart';
import 'package:chart/components/tvchart/tvchart_types.dart';
import 'package:timezone/timezone.dart';

Historical get historical {
  var instance = Historical._instance;
  if (instance == null) {
    instance = Historical._internal();
    Historical._instance = instance;
  }

  return instance;
}

class Historical {
  static Historical? _instance;
  Historical._internal() {
    // Index
    _data.putIfAbsent(
      'COMPOSITE',
      () => SymbolData(
        code: 'COMPOSITE',
        name: 'IDX Composite',
        description: 'IDX Composite',
        type: SymbolType.Index,
      ),
    );

    _data.putIfAbsent(
      'LQ45',
      () => SymbolData(
        code: 'LQ45',
        name: 'LQ45',
        description: 'LQ45',
        type: SymbolType.Index,
      ),
    );

    // Stock
    _data.putIfAbsent(
      'ADHI',
      () => SymbolData(
        code: 'ADHI',
        name: 'Adhi Karya (Persero) Tbk.',
        description: 'Adhi Karya (Persero) Tbk.',
        type: SymbolType.Stock,
      ),
    );

    _data.putIfAbsent(
      'BBCA',
      () => SymbolData(
        code: 'BBCA',
        name: 'Bank Central Asia Tbk.',
        description: 'Bank Central Asia Tbk.',
        type: SymbolType.Stock,
      ),
    );

    _data.putIfAbsent(
      'BMRI',
      () => SymbolData(
        code: 'BMRI',
        name: 'Bank Mandiri (Persero) Tbk.',
        description: 'Bank Mandiri (Persero) Tbk.',
        type: SymbolType.Stock,
      ),
    );

    _data.putIfAbsent(
      'KLBF',
      () => SymbolData(
        code: 'KLBF',
        name: 'Kalbe Farma Tbk.',
        description: 'Kalbe Farma Tbk.',
        type: SymbolType.Stock,
      ),
    );

    _data.putIfAbsent(
      'PGAS',
      () => SymbolData(
        code: 'PGAS',
        name: 'Perusahaan Gas Negara (Persero) Tbk.',
        description: 'Perusahaan Gas Negara (Persero) Tbk.',
        type: SymbolType.Stock,
      ),
    );
  }

  final Map<String, SymbolData> _data = {};

  List<SearchSymbolResultItem> searchSymbol(
    String userInput,
    String rawSymbolType,
  ) {
    final symbolType = getSymbolFromString(rawSymbolType);
    List<SearchSymbolResultItem> searchResult = [];

    _data.forEach((key, value) {
      final userInputCase = userInput.toUpperCase();
      final codeCase = value.code.toUpperCase();
      final nameCase = value.name.toUpperCase();
      final symbolCase = value.symbolString.toUpperCase();
      final typeMatch = symbolType == null || symbolType == value.type;

      final isMatch = typeMatch &&
          (codeCase.contains(userInputCase) ||
              nameCase.contains(userInputCase) ||
              symbolCase.contains(userInputCase));

      if (isMatch) {
        searchResult.add(value.getSearchSymbolInfo());
      }
    });

    return searchResult;
  }

  SymbolData? getSymbol(String symbol) {
    if (symbol.contains(':')) {
      for (final s in _data.entries) {
        if (symbol == s.value.symbolString) {
          return s.value;
        }
      }
    }
    return _data[symbol];
  }

  Future<List<OHLCData>> getDataRange(
    String code,
    TZDateTime from,
    TZDateTime to,
  ) async {
    var d = _data[code];
    if (d == null) return [];
    return (await d.getDataRange(from, to));
  }
}

class SymbolData {
  final String code;
  String name;
  String description;

  SymbolType type;
  WeekSessions session;
  SymbolExchange exchange;
  SymbolExchange listedExchange;
  Timezone timezone;
  SeriesFormat format;

  double pricescale;
  double minmov;

  List<String> resolutions;
  List<OHLCData> data;

  SymbolData({
    required this.code,
    this.name = '',
    this.description = '',
    this.type = SymbolType.Index,
    WeekSessions? session,
    this.exchange = SymbolExchange.idx,
    this.listedExchange = SymbolExchange.idx,
    this.timezone = Timezone.asiaJakarta,
    this.format = SeriesFormat.price,
    this.pricescale = 100,
    this.minmov = 1,
    List<String>? resolutions,
    List<OHLCData>? data,
  })  : session = session ?? _defaultSession(),
        data = data ?? _buildDummyData(),
        resolutions = resolutions ?? _defaultResolutions();

  String get symbolString => '${exchange.jsValue}:$code';

  LibrarySymbolInfo getLibrarySymbolInfo() {
    return LibrarySymbolInfo(
      name: symbolString,
      ticker: code,
      fullName: name,
      description: description,
      type: type.jsValue,
      session: session.toString(),
      exchange: exchange.jsValue,
      listedExchange: listedExchange.jsValue,
      timezone: timezone,
      format: format,
      pricescale: pricescale,
      minmov: minmov,
      supportedResolutions: List.from(resolutions),
    );
  }

  SearchSymbolResultItem getSearchSymbolInfo() {
    return SearchSymbolResultItem(
      symbol: symbolString,
      ticker: code,
      fullName: name,
      type: type.jsValue,
      description: description,
      exchange: exchange.jsValue,
    );
  }

  Future<List<OHLCData>> getDataRange(
    TZDateTime from,
    TZDateTime to,
  ) async {
    // Simulate request delay
    await Future.delayed(const Duration(seconds: 1));

    List<OHLCData> result = [];

    for (int i = 0; i < data.length; i++) {
      final d = data[i];

      if (d.dt.isBefore(from)) {
        continue;
      } else if (d.dt.isAfter(to)) {
        break;
      }

      result.add(d);
    }

    return result;
  }

  static List<String> _defaultResolutions() {
    return ['1D'];
  }

  static WeekSessions _defaultSession() {
    return WeekSessions.weekdayOnly(
      DualSession(
        session1: SingleSession(
          from: tzToday(9, 0),
          to: tzToday(11, 30),
        ),
        session2: SingleSession(
          from: tzToday(13, 30),
          to: tzToday(15, 00),
        ),
      ),
    );
  }

  static List<OHLCData> _buildDummyData() {
    List<OHLCData> dummy = [];

    final today = tzToday(0, 0);
    var time = tzDate(today.year - 1, 1, 1);
    double price = 10000;

    while (time.isBefore(today)) {
      List<double> values = [];
      for (int i = 0; i < 10; i++) {
        values.add(doubleRandomRange(price - 100, price + 100).roundToDouble());
      }

      double open = values.first;
      double close = values.last;
      double high = open;
      double low = open;

      for (final value in values) {
        if (value > high) high = value;
        if (value < low) low = value;
      }

      // 1,000 ~ 1,000,000
      int volume = intRandomRange(10000, 1000000);

      dummy.add(
        OHLCData(
          dt: time,
          open: open,
          high: high,
          low: low,
          close: close,
          volume: volume,
        ),
      );

      price = close;
      time = time.add(const Duration(days: 1));
    }

    return dummy;
  }
}

abstract class Session {
  @override
  String toString();
}

class NoSession extends Session {
  @override
  String toString() => '';
}

class SingleSession extends Session {
  final TZDateTime from;
  final TZDateTime to;

  SingleSession({
    required this.from,
    required this.to,
  });

  @override
  String toString() {
    String fromStr = tzFormat(from, 'HHmm');
    String toStr = tzFormat(to, 'HHmm');
    return '$fromStr-$toStr';
  }
}

class DualSession extends Session {
  final SingleSession session1;
  final SingleSession session2;

  DualSession({
    required this.session1,
    required this.session2,
  });

  @override
  String toString() {
    String s1 = session1.toString();
    String s2 = session2.toString();
    return '$s1,$s2';
  }
}

class WeekSessions {
  final Session monday;
  final Session tuesday;
  final Session wednesday;
  final Session thursday;
  final Session friday;
  final Session saturday;
  final Session sunday;

  WeekSessions({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory WeekSessions.weekdayOnly(Session session) {
    return WeekSessions(
      monday: session,
      tuesday: session,
      wednesday: session,
      thursday: session,
      friday: session,
      saturday: NoSession(),
      sunday: NoSession(),
    );
  }

  @override
  String toString() {
    // 1 = Sunday
    // 2 = Monday
    // ...
    // 7 = Saturday
    List<Session> iterable = [
      sunday,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
    ];

    String result = '';
    for (int i = 0; i < iterable.length; i++) {
      String sString = iterable[i].toString();

      if (sString.isNotEmpty) {
        String dayNumber = (i + 1).toString();

        if (result.isNotEmpty) {
          result += '|$sString:$dayNumber';
        } else {
          result = '$sString:$dayNumber';
        }
      }
    }

    return result;
  }
}

@immutable
class OHLCData {
  final TZDateTime dt;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;

  const OHLCData({
    required this.dt,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}

enum SymbolType {
  // ignore: constant_identifier_names
  Stock,
  // ignore: constant_identifier_names
  Index,
  // ignore: constant_identifier_names
  Forex,
}

SymbolType? getSymbolFromString(String symbolString) {
  switch (symbolString) {
    case 'stock':
      return SymbolType.Stock;

    case 'index':
      return SymbolType.Index;

    case 'forex':
      return SymbolType.Forex;

    default:
      return null;
  }
}

extension on SymbolType {
  String get jsValue {
    switch (this) {
      case SymbolType.Stock:
        return 'stock';

      case SymbolType.Index:
        return 'index';

      case SymbolType.Forex:
        return 'forex';
    }
  }
}

enum SymbolExchange {
  idx,
}

extension on SymbolExchange {
  String get jsValue {
    switch (this) {
      case SymbolExchange.idx:
        return 'IDX';
    }
  }
}
