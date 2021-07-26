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
  Map<String, SymbolData> _data = {};

  List<SearchSymbolResultItem> searchSymbol(
    String userInput,
    String rawSymbolType,
  ) {
    SymbolType symbolType = getSymbolFromString(rawSymbolType);
    List<SearchSymbolResultItem> searchResult = [];

    _data.forEach((key, value) {
      bool isMatch = symbolType == value.type &&
          (value.code.toUpperCase().contains(userInput.toUpperCase()) ||
              value.name.toUpperCase().contains(userInput.toUpperCase()));

      if (isMatch) {
        searchResult.add(value.getSearchSymbolInfo());
      }
    });

    return searchResult;
  }

  SymbolData? getSymbol(String code) {
    return _data[code];
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
  TradingViewTimezone timezone;
  SymbolFormat format;

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
    this.exchange = SymbolExchange.IDX,
    this.listedExchange = SymbolExchange.IDX,
    this.timezone = TradingViewTimezone.AsiaJakarta,
    this.format = SymbolFormat.Price,
    this.pricescale = 100,
    this.minmov = 1,
    List<String>? resolutions,
    List<OHLCData>? data,
  })  : this.session = session ?? _defaultSession(),
        this.data = data ?? _buildDummyData(),
        this.resolutions = resolutions ?? _defaultResolutions();

  LibrarySymbolInfo getLibrarySymbolInfo() {
    return LibrarySymbolInfo(
      name: code,
      full_name: name,
      description: description,
      type: type.jsValue,
      session: session.toString(),
      exchange: exchange.jsValue,
      listed_exchange: listedExchange.jsValue,
      timezone: timezone.stringValue,
      format: format.jsValue,
      pricescale: pricescale,
      minmov: minmov,
      supported_resolutions: List.from(resolutions),
    );
  }

  SearchSymbolResultItem getSearchSymbolInfo() {
    return SearchSymbolResultItem(
      symbol: code,
      ticker: code,
      full_name: name,
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
    await Future.delayed(Duration(seconds: 1));

    List<OHLCData> result = [];

    for (int i = 0; i < this.data.length; i++) {
      final d = this.data[i];

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
      values.forEach((value) {
        if (value > high) high = value;
        if (value < low) low = value;
      });

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
      time = time.add(Duration(days: 1));
    }

    return dummy;
  }
}

abstract class Session {
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

  OHLCData({
    required this.dt,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });
}

enum SymbolType {
  Stock,
  Index,
  Forex,
}

SymbolType getSymbolFromString(String symbolString) {
  switch (symbolString) {
    case 'stock':
      return SymbolType.Stock;

    case 'index':
      return SymbolType.Index;

    case 'forex':
      return SymbolType.Forex;

    default:
      throw Exception('Trying parse unknown SymbolType');
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

enum SymbolFormat {
  Price,
  Volume,
}

extension on SymbolFormat {
  String get jsValue {
    switch (this) {
      case SymbolFormat.Price:
        return 'price';

      case SymbolFormat.Volume:
        return 'volume';
    }
  }
}

enum SymbolExchange {
  IDX,
}

extension on SymbolExchange {
  String get jsValue {
    switch (this) {
      case SymbolExchange.IDX:
        return 'IDX';
    }
  }
}

enum TradingViewTimezone {
  UTC,
  AfricaCairo,
  AfricaJohannesburg,
  AfricaLagos,
  AmericaArgentinaBuenosAires,
  AmericaBogota,
  AmericaCaracas,
  AmericaChicago,
  AmericaElSalvador,
  AmericaJuneau,
  AmericaLima,
  AmericaLosAngeles,
  AmericaMexicoCity,
  AmericaNewYork,
  AmericaPhoenix,
  AmericaSantiago,
  AmericaSaoPaulo,
  AmericaToronto,
  AmericaVancouver,
  AsiaAlmaty,
  AsiaAshkhabad,
  AsiaBahrain,
  AsiaBangkok,
  AsiaChongqing,
  AsiaDubai,
  AsiaHoChiMinh,
  AsiaHongKong,
  AsiaJakarta,
  AsiaJerusalem,
  AsiaKathmandu,
  AsiaKolkata,
  AsiaKuwait,
  AsiaMuscat,
  AsiaQatar,
  AsiaRiyadh,
  AsiaSeoul,
  AsiaShanghai,
  AsiaSingapore,
  AsiaTaipei,
  AsiaTehran,
  AsiaTokyo,
  AtlanticReykjavik,
  AustraliaACT,
  AustraliaAdelaide,
  AustraliaBrisbane,
  AustraliaPerth,
  AustraliaSydney,
  EuropeAthens,
  EuropeBelgrade,
  EuropeBerlin,
  EuropeCopenhagen,
  EuropeHelsinki,
  EuropeIstanbul,
  EuropeLondon,
  EuropeLuxembourg,
  EuropeMadrid,
  EuropeMoscow,
  EuropeOslo,
  EuropeParis,
  EuropeRiga,
  EuropeRome,
  EuropeStockholm,
  EuropeTallinn,
  EuropeVilnius,
  EuropeWarsaw,
  EuropeZurich,
  PacificAuckland,
  PacificChatham,
  PacificFakaofo,
  PacificHonolulu,
  PacificNorfolk,
  USMountain,
}

extension on TradingViewTimezone {
  String get stringValue {
    switch (this) {
      case TradingViewTimezone.UTC:
        return 'Etc/UTC';

      case TradingViewTimezone.AfricaCairo:
        return 'Africa/Cairo';

      case TradingViewTimezone.AfricaJohannesburg:
        return 'Africa/Johannesburg';

      case TradingViewTimezone.AfricaLagos:
        return 'Africa/Lagos';

      case TradingViewTimezone.AmericaArgentinaBuenosAires:
        return 'America/Argentina/Buenos_Aires';

      case TradingViewTimezone.AmericaBogota:
        return 'America/Bogota';

      case TradingViewTimezone.AmericaCaracas:
        return 'America/Caracas';

      case TradingViewTimezone.AmericaChicago:
        return 'America/Chicago';

      case TradingViewTimezone.AmericaElSalvador:
        return 'America/El_Salvador';

      case TradingViewTimezone.AmericaJuneau:
        return 'America/Juneau';

      case TradingViewTimezone.AmericaLima:
        return 'America/Lima';

      case TradingViewTimezone.AmericaLosAngeles:
        return 'America/Los_Angeles';

      case TradingViewTimezone.AmericaMexicoCity:
        return 'America/Mexico_City';

      case TradingViewTimezone.AmericaNewYork:
        return 'America/New_York';

      case TradingViewTimezone.AmericaPhoenix:
        return 'America/Phoenix';

      case TradingViewTimezone.AmericaSantiago:
        return 'America/Santiago';

      case TradingViewTimezone.AmericaSaoPaulo:
        return 'America/Sao_Paulo';

      case TradingViewTimezone.AmericaToronto:
        return 'America/Toronto';

      case TradingViewTimezone.AmericaVancouver:
        return 'America/Vancouver';

      case TradingViewTimezone.AsiaAlmaty:
        return 'Asia/Almaty';

      case TradingViewTimezone.AsiaAshkhabad:
        return 'Asia/Ashkhabad';

      case TradingViewTimezone.AsiaBahrain:
        return 'Asia/Bahrain';

      case TradingViewTimezone.AsiaBangkok:
        return 'Asia/Bangkok';

      case TradingViewTimezone.AsiaChongqing:
        return 'Asia/Chongqing';

      case TradingViewTimezone.AsiaDubai:
        return 'Asia/Dubai';

      case TradingViewTimezone.AsiaHoChiMinh:
        return 'Asia/Ho_Chi_Minh';

      case TradingViewTimezone.AsiaHongKong:
        return 'Asia/Hong_Kong';

      case TradingViewTimezone.AsiaJakarta:
        return 'Asia/Jakarta';

      case TradingViewTimezone.AsiaJerusalem:
        return 'Asia/Jerusalem';

      case TradingViewTimezone.AsiaKathmandu:
        return 'Asia/Kathmandu';

      case TradingViewTimezone.AsiaKolkata:
        return 'Asia/Kolkata';

      case TradingViewTimezone.AsiaKuwait:
        return 'Asia/Kuwait';

      case TradingViewTimezone.AsiaMuscat:
        return 'Asia/Muscat';

      case TradingViewTimezone.AsiaQatar:
        return 'Asia/Qatar';

      case TradingViewTimezone.AsiaRiyadh:
        return 'Asia/Riyadh';

      case TradingViewTimezone.AsiaSeoul:
        return 'Asia/Seoul';

      case TradingViewTimezone.AsiaShanghai:
        return 'Asia/Shanghai';

      case TradingViewTimezone.AsiaSingapore:
        return 'Asia/Singapore';

      case TradingViewTimezone.AsiaTaipei:
        return 'Asia/Taipei';

      case TradingViewTimezone.AsiaTehran:
        return 'Asia/Tehran';

      case TradingViewTimezone.AsiaTokyo:
        return 'Asia/Tokyo';

      case TradingViewTimezone.AtlanticReykjavik:
        return 'Atlantic/Reykjavik';

      case TradingViewTimezone.AustraliaACT:
        return 'Australia/ACT';

      case TradingViewTimezone.AustraliaAdelaide:
        return 'Australia/Adelaide';

      case TradingViewTimezone.AustraliaBrisbane:
        return 'Australia/Brisbane';

      case TradingViewTimezone.AustraliaPerth:
        return 'Australia/Perth';

      case TradingViewTimezone.AustraliaSydney:
        return 'Australia/Sydney';

      case TradingViewTimezone.EuropeAthens:
        return 'Europe/Athens';

      case TradingViewTimezone.EuropeBelgrade:
        return 'Europe/Belgrade';

      case TradingViewTimezone.EuropeBerlin:
        return 'Europe/Berlin';

      case TradingViewTimezone.EuropeCopenhagen:
        return 'Europe/Copenhagen';

      case TradingViewTimezone.EuropeHelsinki:
        return 'Europe/Helsinki';

      case TradingViewTimezone.EuropeIstanbul:
        return 'Europe/Istanbul';

      case TradingViewTimezone.EuropeLondon:
        return 'Europe/London';

      case TradingViewTimezone.EuropeLuxembourg:
        return 'Europe/Luxembourg';

      case TradingViewTimezone.EuropeMadrid:
        return 'Europe/Madrid';

      case TradingViewTimezone.EuropeMoscow:
        return 'Europe/Moscow';

      case TradingViewTimezone.EuropeOslo:
        return 'Europe/Oslo';

      case TradingViewTimezone.EuropeParis:
        return 'Europe/Paris';

      case TradingViewTimezone.EuropeRiga:
        return 'Europe/Riga';

      case TradingViewTimezone.EuropeRome:
        return 'Europe/Rome';

      case TradingViewTimezone.EuropeStockholm:
        return 'Europe/Stockholm';

      case TradingViewTimezone.EuropeTallinn:
        return 'Europe/Tallinn';

      case TradingViewTimezone.EuropeVilnius:
        return 'Europe/Vilnius';

      case TradingViewTimezone.EuropeWarsaw:
        return 'Europe/Warsaw';

      case TradingViewTimezone.EuropeZurich:
        return 'Europe/Zurich';

      case TradingViewTimezone.PacificAuckland:
        return 'Pacific/Auckland';

      case TradingViewTimezone.PacificChatham:
        return 'Pacific/Chatham';

      case TradingViewTimezone.PacificFakaofo:
        return 'Pacific/Fakaofo';

      case TradingViewTimezone.PacificHonolulu:
        return 'Pacific/Honolulu';

      case TradingViewTimezone.PacificNorfolk:
        return 'Pacific/Norfolk';

      case TradingViewTimezone.USMountain:
        return 'US/Mountain';
    }
  }
}
