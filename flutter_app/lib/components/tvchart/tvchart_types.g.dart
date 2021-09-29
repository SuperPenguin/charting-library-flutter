// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvchart_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodParams _$PeriodParamsFromJson(Map<String, dynamic> json) => PeriodParams(
      from: json['from'] as int,
      to: json['to'] as int,
      countBack: json['countBack'] as int,
      firstDataRequest: json['firstDataRequest'] as bool,
    );

Map<String, dynamic> _$PeriodParamsToJson(PeriodParams instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'countBack': instance.countBack,
      'firstDataRequest': instance.firstDataRequest,
    };

Bar _$BarFromJson(Map<String, dynamic> json) => Bar(
      time: json['time'] as int,
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: json['volume'] as int?,
    );

Map<String, dynamic> _$BarToJson(Bar instance) {
  final val = <String, dynamic>{
    'time': instance.time,
    'open': instance.open,
    'high': instance.high,
    'low': instance.low,
    'close': instance.close,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('volume', instance.volume);
  return val;
}

Exchange _$ExchangeFromJson(Map<String, dynamic> json) => Exchange(
      value: json['value'] as String,
      name: json['name'] as String,
      desc: json['desc'] as String,
    );

Map<String, dynamic> _$ExchangeToJson(Exchange instance) => <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
      'desc': instance.desc,
    };

DatafeedConfiguration _$DatafeedConfigurationFromJson(
        Map<String, dynamic> json) =>
    DatafeedConfiguration(
      exchanges: (json['exchanges'] as List<dynamic>?)
          ?.map((e) => Exchange.fromJson(e as Map<String, dynamic>))
          .toList(),
      supportedResolutions: (json['supported_resolutions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      currencyCodes: (json['currency_codes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      supportsMarks: json['supports_marks'] as bool?,
      supportsTime: json['supports_time'] as bool?,
      supportsTimescaleMarks: json['supports_timescale_marks'] as bool?,
      symbolsTypes: (json['symbols_types'] as List<dynamic>?)
          ?.map((e) => DatafeedSymbolType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DatafeedConfigurationToJson(
    DatafeedConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('exchanges', instance.exchanges);
  writeNotNull('supported_resolutions', instance.supportedResolutions);
  writeNotNull('currency_codes', instance.currencyCodes);
  writeNotNull('supports_marks', instance.supportsMarks);
  writeNotNull('supports_time', instance.supportsTime);
  writeNotNull('supports_timescale_marks', instance.supportsTimescaleMarks);
  writeNotNull('symbols_types', instance.symbolsTypes);
  return val;
}

DatafeedSymbolType _$DatafeedSymbolTypeFromJson(Map<String, dynamic> json) =>
    DatafeedSymbolType(
      name: json['name'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$DatafeedSymbolTypeToJson(DatafeedSymbolType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

SearchSymbolResultItem _$SearchSymbolResultItemFromJson(
        Map<String, dynamic> json) =>
    SearchSymbolResultItem(
      symbol: json['symbol'] as String,
      fullName: json['full_name'] as String,
      description: json['description'] as String,
      exchange: json['exchange'] as String,
      ticker: json['ticker'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SearchSymbolResultItemToJson(
        SearchSymbolResultItem instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'full_name': instance.fullName,
      'description': instance.description,
      'exchange': instance.exchange,
      'ticker': instance.ticker,
      'type': instance.type,
    };

LibrarySymbolInfo _$LibrarySymbolInfoFromJson(Map<String, dynamic> json) =>
    LibrarySymbolInfo(
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      baseName: (json['base_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ticker: json['ticker'] as String?,
      description: json['description'] as String,
      type: json['type'] as String,
      session: json['session'] as String,
      sessionDisplay: json['session_display'] as String?,
      holidays: json['holidays'] as String?,
      corrections: json['corrections'] as String?,
      exchange: json['exchange'] as String,
      listedExchange: json['listed_exchange'] as String,
      timezone: _$enumDecode(_$TimezoneEnumMap, json['timezone']),
      format: _$enumDecode(_$SeriesFormatEnumMap, json['format']),
      pricescale: (json['pricescale'] as num).toDouble(),
      minmov: (json['minmov'] as num).toDouble(),
      fractional: json['fractional'] as bool?,
      minmove2: (json['minmove2'] as num?)?.toDouble(),
      hasIntraday: json['has_intraday'] as bool?,
      supportedResolutions: (json['supported_resolutions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      intradayMultipliers: (json['intraday_multipliers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hasSeconds: json['has_seconds'] as bool?,
      hasTicks: json['has_ticks'] as bool?,
      secondsMultipliers: (json['seconds_multipliers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hasDaily: json['has_daily'] as bool?,
      hasWeeklyAndMonthly: json['has_weekly_and_monthly'] as bool?,
      hasEmptyBars: json['has_empty_bars'] as bool?,
      hasNoVolume: json['has_no_volume'] as bool?,
      volumePrecision: (json['volume_precision'] as num?)?.toDouble(),
      dataStatus: json['data_status'] as String?,
      expired: json['expired'] as bool?,
      expirationDate: json['expiration_date'] as int?,
      sector: json['sector'] as String?,
      industry: json['industry'] as String?,
      currencyCode: json['currency_code'] as String?,
      originalCurrencyCode: json['original_currency_code'] as String?,
    );

Map<String, dynamic> _$LibrarySymbolInfoToJson(LibrarySymbolInfo instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'full_name': instance.fullName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('base_name', instance.baseName);
  writeNotNull('ticker', instance.ticker);
  val['description'] = instance.description;
  val['type'] = instance.type;
  val['session'] = instance.session;
  writeNotNull('session_display', instance.sessionDisplay);
  writeNotNull('holidays', instance.holidays);
  writeNotNull('corrections', instance.corrections);
  val['exchange'] = instance.exchange;
  val['listed_exchange'] = instance.listedExchange;
  val['timezone'] = _$TimezoneEnumMap[instance.timezone];
  val['format'] = _$SeriesFormatEnumMap[instance.format];
  val['pricescale'] = instance.pricescale;
  val['minmov'] = instance.minmov;
  writeNotNull('fractional', instance.fractional);
  writeNotNull('minmove2', instance.minmove2);
  writeNotNull('has_intraday', instance.hasIntraday);
  val['supported_resolutions'] = instance.supportedResolutions;
  writeNotNull('intraday_multipliers', instance.intradayMultipliers);
  writeNotNull('has_seconds', instance.hasSeconds);
  writeNotNull('has_ticks', instance.hasTicks);
  writeNotNull('seconds_multipliers', instance.secondsMultipliers);
  writeNotNull('has_daily', instance.hasDaily);
  writeNotNull('has_weekly_and_monthly', instance.hasWeeklyAndMonthly);
  writeNotNull('has_empty_bars', instance.hasEmptyBars);
  writeNotNull('has_no_volume', instance.hasNoVolume);
  writeNotNull('volume_precision', instance.volumePrecision);
  writeNotNull('data_status', instance.dataStatus);
  writeNotNull('expired', instance.expired);
  writeNotNull('expiration_date', instance.expirationDate);
  writeNotNull('sector', instance.sector);
  writeNotNull('industry', instance.industry);
  writeNotNull('currency_code', instance.currencyCode);
  writeNotNull('original_currency_code', instance.originalCurrencyCode);
  return val;
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TimezoneEnumMap = {
  Timezone.utc: 'Etc/UTC',
  Timezone.africaCairo: 'Africa/Cairo',
  Timezone.africaJohannesburg: 'Africa/Johannesburg',
  Timezone.africaLagos: 'Africa/Lagos',
  Timezone.americaArgentinaBuenosAires: 'America/Argentina/Buenos_Aires',
  Timezone.americaBogota: 'America/Bogota',
  Timezone.americaCaracas: 'America/Caracas',
  Timezone.americaChicago: 'America/Chicago',
  Timezone.americaElSalvador: 'America/El_Salvador',
  Timezone.americaJuneau: 'America/Juneau',
  Timezone.americaLima: 'America/Lima',
  Timezone.americaLosAngeles: 'America/Los_Angeles',
  Timezone.americaMexicoCity: 'America/Mexico_City',
  Timezone.americaNewYork: 'America/New_York',
  Timezone.americaPhoenix: 'America/Phoenix',
  Timezone.americaSantiago: 'America/Santiago',
  Timezone.americaSaoPaulo: 'America/Sao_Paulo',
  Timezone.americaToronto: 'America/Toronto',
  Timezone.americaVancouver: 'America/Vancouver',
  Timezone.asiaAlmaty: 'Asia/Almaty',
  Timezone.asiaAshkhabad: 'Asia/Ashkhabad',
  Timezone.asiaBahrain: 'Asia/Bahrain',
  Timezone.asiaBangkok: 'Asia/Bangkok',
  Timezone.asiaChongqing: 'Asia/Chongqing',
  Timezone.asiaDubai: 'Asia/Dubai',
  Timezone.asiaHoChiMinh: 'Asia/Ho_Chi_Minh',
  Timezone.asiaHongKong: 'Asia/Hong_Kong',
  Timezone.asiaJakarta: 'Asia/Jakarta',
  Timezone.asiaJerusalem: 'Asia/Jerusalem',
  Timezone.asiaKathmandu: 'Asia/Kathmandu',
  Timezone.asiaKolkata: 'Asia/Kolkata',
  Timezone.asiaKuwait: 'Asia/Kuwait',
  Timezone.asiaMuscat: 'Asia/Muscat',
  Timezone.asiaQatar: 'Asia/Qatar',
  Timezone.asiaRiyadh: 'Asia/Riyadh',
  Timezone.asiaSeoul: 'Asia/Seoul',
  Timezone.asiaShanghai: 'Asia/Shanghai',
  Timezone.asiaSingapore: 'Asia/Singapore',
  Timezone.asiaTaipei: 'Asia/Taipei',
  Timezone.asiaTehran: 'Asia/Tehran',
  Timezone.asiaTokyo: 'Asia/Tokyo',
  Timezone.atlanticReykjavik: 'Atlantic/Reykjavik',
  Timezone.australiaACT: 'Australia/ACT',
  Timezone.australiaAdelaide: 'Australia/Adelaide',
  Timezone.australiaBrisbane: 'Australia/Brisbane',
  Timezone.australiaPerth: 'Australia/Perth',
  Timezone.australiaSydney: 'Australia/Sydney',
  Timezone.europeAmsterdam: 'Europe/Amsterdam',
  Timezone.europeAthens: 'Europe/Athens',
  Timezone.europeBelgrade: 'Europe/Belgrade',
  Timezone.europeBerlin: 'Europe/Berlin',
  Timezone.europeBrussels: 'Europe/Brussels',
  Timezone.europeCopenhagen: 'Europe/Copenhagen',
  Timezone.europeDublin: 'Europe/Dublin',
  Timezone.europeHelsinki: 'Europe/Helsinki',
  Timezone.europeIstanbul: 'Europe/Istanbul',
  Timezone.europeLisbon: 'Europe/Lisbon',
  Timezone.europeLondon: 'Europe/London',
  Timezone.europeLuxembourg: 'Europe/Luxembourg',
  Timezone.europeMadrid: 'Europe/Madrid',
  Timezone.europeMalta: 'Europe/Malta',
  Timezone.europeMoscow: 'Europe/Moscow',
  Timezone.europeOslo: 'Europe/Oslo',
  Timezone.europeParis: 'Europe/Paris',
  Timezone.europeRiga: 'Europe/Riga',
  Timezone.europeRome: 'Europe/Rome',
  Timezone.europeStockholm: 'Europe/Stockholm',
  Timezone.europeTallinn: 'Europe/Tallinn',
  Timezone.europeVilnius: 'Europe/Vilnius',
  Timezone.europeWarsaw: 'Europe/Warsaw',
  Timezone.europeZurich: 'Europe/Zurich',
  Timezone.pacificAuckland: 'Pacific/Auckland',
  Timezone.pacificChatham: 'Pacific/Chatham',
  Timezone.pacificFakaofo: 'Pacific/Fakaofo',
  Timezone.pacificHonolulu: 'Pacific/Honolulu',
  Timezone.pacificNorfolk: 'Pacific/Norfolk',
  Timezone.usMountain: 'US/Mountain',
  Timezone.exchange: 'exchange',
};

const _$SeriesFormatEnumMap = {
  SeriesFormat.price: 'price',
  SeriesFormat.volume: 'volume',
};

ChartingLibraryWidgetOptions _$ChartingLibraryWidgetOptionsFromJson(
        Map<String, dynamic> json) =>
    ChartingLibraryWidgetOptions(
      interval: json['interval'] as String,
      symbol: json['symbol'] as String?,
      autoSaveDelay: json['auto_save_delay'] as int?,
      autosize: json['autosize'] as bool?,
      debug: json['debug'] as bool?,
      disabledFeatures: (json['disabled_features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      drawingsAccess: json['drawings_access'] == null
          ? null
          : AccessList.fromJson(
              json['drawings_access'] as Map<String, dynamic>),
      enabledFeatures: (json['enabled_features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fullscreen: json['fullscreen'] as bool?,
      height: json['height'] as int?,
      locale: json['locale'] as String,
      numericFormatting: json['numeric_formatting'] == null
          ? null
          : NumericFormattingParams.fromJson(
              json['numeric_formatting'] as Map<String, dynamic>),
      savedData: json['saved_data'] as Map<String, dynamic>?,
      savedDataMetaInfo: json['saved_data_meta_info'] == null
          ? null
          : SavedStateMetaInfo.fromJson(
              json['saved_data_meta_info'] as Map<String, dynamic>),
      studiesAccess: json['studies_access'] == null
          ? null
          : AccessList.fromJson(json['studies_access'] as Map<String, dynamic>),
      studyCountLimit: json['study_count_limit'] as int?,
      symbolSearchRequestDelay: json['symbol_search_request_delay'] as int?,
      timeframe: json['timeframe'] as String?,
      timezone: _$enumDecodeNullable(_$TimezoneEnumMap, json['timezone']),
      toolbarBg: json['toolbar_bg'] as String?,
      width: json['width'] as int?,
      chartsStorageUrl: json['charts_storage_url'] as String?,
      chartsStorageApiVersion: json['charts_storage_api_version'] as String?,
      clientId: json['client_id'] as String?,
      userId: json['user_id'] as String?,
      loadLastChart: json['load_last_chart'] as bool?,
      studiesOverrides: json['studies_overrides'] as Map<String, dynamic>?,
      overrides: json['overrides'] as Map<String, dynamic>?,
      snapshotUrl: json['snapshot_url'] as String?,
      preset: json['preset'] as String?,
      timeFrames: json['time_frames'] == null
          ? null
          : TimeFrameItem.fromJson(json['time_frames'] as Map<String, dynamic>),
      customCssUrl: json['custom_css_url'] as String?,
      favorites: json['favorites'] == null
          ? null
          : Favorites.fromJson(json['favorites'] as Map<String, dynamic>),
      loadingScreen: json['loading_screen'] == null
          ? null
          : LoadingScreenOptions.fromJson(
              json['loading_screen'] as Map<String, dynamic>),
      theme: _$enumDecodeNullable(_$ChartThemeEnumMap, json['theme']),
      compareSymbols: (json['compare_symbols'] as List<dynamic>?)
          ?.map((e) => CompareSymbol.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChartingLibraryWidgetOptionsToJson(
    ChartingLibraryWidgetOptions instance) {
  final val = <String, dynamic>{
    'interval': instance.interval,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('symbol', instance.symbol);
  writeNotNull('auto_save_delay', instance.autoSaveDelay);
  writeNotNull('autosize', instance.autosize);
  writeNotNull('debug', instance.debug);
  writeNotNull('disabled_features', instance.disabledFeatures);
  writeNotNull('drawings_access', instance.drawingsAccess);
  writeNotNull('enabled_features', instance.enabledFeatures);
  writeNotNull('fullscreen', instance.fullscreen);
  writeNotNull('height', instance.height);
  val['locale'] = instance.locale;
  writeNotNull('numeric_formatting', instance.numericFormatting);
  writeNotNull('saved_data', instance.savedData);
  writeNotNull('saved_data_meta_info', instance.savedDataMetaInfo);
  writeNotNull('studies_access', instance.studiesAccess);
  writeNotNull('study_count_limit', instance.studyCountLimit);
  writeNotNull(
      'symbol_search_request_delay', instance.symbolSearchRequestDelay);
  writeNotNull('timeframe', instance.timeframe);
  writeNotNull('timezone', _$TimezoneEnumMap[instance.timezone]);
  writeNotNull('toolbar_bg', instance.toolbarBg);
  writeNotNull('width', instance.width);
  writeNotNull('charts_storage_url', instance.chartsStorageUrl);
  writeNotNull('charts_storage_api_version', instance.chartsStorageApiVersion);
  writeNotNull('client_id', instance.clientId);
  writeNotNull('user_id', instance.userId);
  writeNotNull('load_last_chart', instance.loadLastChart);
  writeNotNull('studies_overrides', instance.studiesOverrides);
  writeNotNull('overrides', instance.overrides);
  writeNotNull('snapshot_url', instance.snapshotUrl);
  writeNotNull('preset', instance.preset);
  writeNotNull('time_frames', instance.timeFrames);
  writeNotNull('custom_css_url', instance.customCssUrl);
  writeNotNull('favorites', instance.favorites);
  writeNotNull('loading_screen', instance.loadingScreen);
  writeNotNull('theme', _$ChartThemeEnumMap[instance.theme]);
  writeNotNull('compare_symbols', instance.compareSymbols);
  return val;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ChartThemeEnumMap = {
  ChartTheme.light: 'Light',
  ChartTheme.dark: 'Dark',
};

SavedStateMetaInfo _$SavedStateMetaInfoFromJson(Map<String, dynamic> json) =>
    SavedStateMetaInfo(
      uid: json['uid'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$SavedStateMetaInfoToJson(SavedStateMetaInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
    };

CompareSymbol _$CompareSymbolFromJson(Map<String, dynamic> json) =>
    CompareSymbol(
      symbol: json['symbol'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$CompareSymbolToJson(CompareSymbol instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'title': instance.title,
    };

LoadingScreenOptions _$LoadingScreenOptionsFromJson(
        Map<String, dynamic> json) =>
    LoadingScreenOptions(
      foregroundColor: json['foregroundColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
    );

Map<String, dynamic> _$LoadingScreenOptionsToJson(
    LoadingScreenOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('foregroundColor', instance.foregroundColor);
  writeNotNull('backgroundColor', instance.backgroundColor);
  return val;
}

Favorites _$FavoritesFromJson(Map<String, dynamic> json) => Favorites(
      intervals:
          (json['intervals'] as List<dynamic>).map((e) => e as String).toList(),
      chartTypes: (json['chartTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FavoritesToJson(Favorites instance) => <String, dynamic>{
      'intervals': instance.intervals,
      'chartTypes': instance.chartTypes,
    };

TimeFrameItem _$TimeFrameItemFromJson(Map<String, dynamic> json) =>
    TimeFrameItem(
      text: json['text'] as String,
      resolution: json['resolution'] as String,
      description: json['description'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$TimeFrameItemToJson(TimeFrameItem instance) {
  final val = <String, dynamic>{
    'text': instance.text,
    'resolution': instance.resolution,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('title', instance.title);
  return val;
}

NumericFormattingParams _$NumericFormattingParamsFromJson(
        Map<String, dynamic> json) =>
    NumericFormattingParams(
      decimalSign: json['decimal_sign'] as String,
    );

Map<String, dynamic> _$NumericFormattingParamsToJson(
        NumericFormattingParams instance) =>
    <String, dynamic>{
      'decimal_sign': instance.decimalSign,
    };

AccessList _$AccessListFromJson(Map<String, dynamic> json) => AccessList(
      type: _$enumDecode(_$AccessListTypeEnumMap, json['type']),
      tools: (json['tools'] as List<dynamic>)
          .map((e) => AccessListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccessListToJson(AccessList instance) =>
    <String, dynamic>{
      'type': _$AccessListTypeEnumMap[instance.type],
      'tools': instance.tools,
    };

const _$AccessListTypeEnumMap = {
  AccessListType.black: 'black',
  AccessListType.white: 'white',
};

AccessListItem _$AccessListItemFromJson(Map<String, dynamic> json) =>
    AccessListItem(
      name: json['name'] as String,
      grayed: json['grayed'] as bool?,
    );

Map<String, dynamic> _$AccessListItemToJson(AccessListItem instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('grayed', instance.grayed);
  return val;
}
