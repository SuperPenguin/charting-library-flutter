// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tvchart_types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bar _$BarFromJson(Map<String, dynamic> json) {
  return Bar(
    time: json['time'] as int,
    open: (json['open'] as num).toDouble(),
    high: (json['high'] as num).toDouble(),
    low: (json['low'] as num).toDouble(),
    close: (json['close'] as num).toDouble(),
    volume: json['volume'] as int?,
  );
}

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

Exchange _$ExchangeFromJson(Map<String, dynamic> json) {
  return Exchange(
    value: json['value'] as String,
    name: json['name'] as String,
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$ExchangeToJson(Exchange instance) => <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
      'desc': instance.desc,
    };

DatafeedConfiguration _$DatafeedConfigurationFromJson(
    Map<String, dynamic> json) {
  return DatafeedConfiguration(
    exchanges: (json['exchanges'] as List<dynamic>?)
        ?.map((e) => Exchange.fromJson(e as Map<String, dynamic>))
        .toList(),
    supported_resolutions: (json['supported_resolutions'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    currency_codes: (json['currency_codes'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    supports_marks: json['supports_marks'] as bool?,
    supports_time: json['supports_time'] as bool?,
    supports_timescale_marks: json['supports_timescale_marks'] as bool?,
    symbols_types: (json['symbols_types'] as List<dynamic>?)
        ?.map((e) => DatafeedSymbolType.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DatafeedConfigurationToJson(
    DatafeedConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('exchanges', instance.exchanges);
  writeNotNull('supported_resolutions', instance.supported_resolutions);
  writeNotNull('currency_codes', instance.currency_codes);
  writeNotNull('supports_marks', instance.supports_marks);
  writeNotNull('supports_time', instance.supports_time);
  writeNotNull('supports_timescale_marks', instance.supports_timescale_marks);
  writeNotNull('symbols_types', instance.symbols_types);
  return val;
}

DatafeedSymbolType _$DatafeedSymbolTypeFromJson(Map<String, dynamic> json) {
  return DatafeedSymbolType(
    name: json['name'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$DatafeedSymbolTypeToJson(DatafeedSymbolType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

SearchSymbolResultItem _$SearchSymbolResultItemFromJson(
    Map<String, dynamic> json) {
  return SearchSymbolResultItem(
    symbol: json['symbol'] as String,
    full_name: json['full_name'] as String,
    description: json['description'] as String,
    exchange: json['exchange'] as String,
    ticker: json['ticker'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$SearchSymbolResultItemToJson(
        SearchSymbolResultItem instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'full_name': instance.full_name,
      'description': instance.description,
      'exchange': instance.exchange,
      'ticker': instance.ticker,
      'type': instance.type,
    };

LibrarySymbolInfo _$LibrarySymbolInfoFromJson(Map<String, dynamic> json) {
  return LibrarySymbolInfo(
    name: json['name'] as String,
    full_name: json['full_name'] as String,
    base_name:
        (json['base_name'] as List<dynamic>?)?.map((e) => e as String).toList(),
    ticker: json['ticker'] as String?,
    description: json['description'] as String,
    type: json['type'] as String,
    session: json['session'] as String,
    session_display: json['session_display'] as String?,
    holidays: json['holidays'] as String?,
    corrections: json['corrections'] as String?,
    exchange: json['exchange'] as String,
    listed_exchange: json['listed_exchange'] as String,
    timezone: json['timezone'] as String,
    format: json['format'] as String,
    pricescale: (json['pricescale'] as num).toDouble(),
    minmov: (json['minmov'] as num).toDouble(),
    fractional: json['fractional'] as bool?,
    minmove2: (json['minmove2'] as num?)?.toDouble(),
    has_intraday: json['has_intraday'] as bool?,
    supported_resolutions: (json['supported_resolutions'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
    intraday_multipliers: (json['intraday_multipliers'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    has_seconds: json['has_seconds'] as bool?,
    seconds_multipliers: (json['seconds_multipliers'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    has_daily: json['has_daily'] as bool?,
    has_weekly_and_monthly: json['has_weekly_and_monthly'] as bool?,
    has_empty_bars: json['has_empty_bars'] as bool?,
    force_session_rebuild: json['force_session_rebuild'] as bool?,
    has_no_volume: json['has_no_volume'] as bool?,
    volume_precision: (json['volume_precision'] as num?)?.toDouble(),
    data_status: json['data_status'] as String?,
    expired: json['expired'] as bool?,
    expiration_date: json['expiration_date'] as int?,
    sector: json['sector'] as String?,
    industry: json['industry'] as String?,
    currency_code: json['currency_code'] as String?,
    original_currency_code: json['original_currency_code'] as String?,
  );
}

Map<String, dynamic> _$LibrarySymbolInfoToJson(LibrarySymbolInfo instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'full_name': instance.full_name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('base_name', instance.base_name);
  writeNotNull('ticker', instance.ticker);
  val['description'] = instance.description;
  val['type'] = instance.type;
  val['session'] = instance.session;
  writeNotNull('session_display', instance.session_display);
  writeNotNull('holidays', instance.holidays);
  writeNotNull('corrections', instance.corrections);
  val['exchange'] = instance.exchange;
  val['listed_exchange'] = instance.listed_exchange;
  val['timezone'] = instance.timezone;
  val['format'] = instance.format;
  val['pricescale'] = instance.pricescale;
  val['minmov'] = instance.minmov;
  writeNotNull('fractional', instance.fractional);
  writeNotNull('minmove2', instance.minmove2);
  writeNotNull('has_intraday', instance.has_intraday);
  val['supported_resolutions'] = instance.supported_resolutions;
  writeNotNull('intraday_multipliers', instance.intraday_multipliers);
  writeNotNull('has_seconds', instance.has_seconds);
  writeNotNull('seconds_multipliers', instance.seconds_multipliers);
  writeNotNull('has_daily', instance.has_daily);
  writeNotNull('has_weekly_and_monthly', instance.has_weekly_and_monthly);
  writeNotNull('has_empty_bars', instance.has_empty_bars);
  writeNotNull('force_session_rebuild', instance.force_session_rebuild);
  writeNotNull('has_no_volume', instance.has_no_volume);
  writeNotNull('volume_precision', instance.volume_precision);
  writeNotNull('data_status', instance.data_status);
  writeNotNull('expired', instance.expired);
  writeNotNull('expiration_date', instance.expiration_date);
  writeNotNull('sector', instance.sector);
  writeNotNull('industry', instance.industry);
  writeNotNull('currency_code', instance.currency_code);
  writeNotNull('original_currency_code', instance.original_currency_code);
  return val;
}

ChartingLibraryWidgetOptions _$ChartingLibraryWidgetOptionsFromJson(
    Map<String, dynamic> json) {
  return ChartingLibraryWidgetOptions(
    interval: json['interval'] as String,
    symbol: json['symbol'] as String?,
    auto_save_delay: json['auto_save_delay'] as int?,
    autosize: json['autosize'] as bool?,
    debug: json['debug'] as bool?,
    disabled_features: (json['disabled_features'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    drawings_access: json['drawings_access'] == null
        ? null
        : AccessList.fromJson(json['drawings_access'] as Map<String, dynamic>),
    enabled_features: (json['enabled_features'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    fullscreen: json['fullscreen'] as bool?,
    height: json['height'] as int?,
    locale: json['locale'] as String,
    numeric_formatting: json['numeric_formatting'] == null
        ? null
        : NumericFormattingParams.fromJson(
            json['numeric_formatting'] as Map<String, dynamic>),
    saved_data: json['saved_data'] as Map<String, dynamic>?,
    saved_data_meta_info: json['saved_data_meta_info'] == null
        ? null
        : SavedStateMetaInfo.fromJson(
            json['saved_data_meta_info'] as Map<String, dynamic>),
    studies_access: json['studies_access'] == null
        ? null
        : AccessList.fromJson(json['studies_access'] as Map<String, dynamic>),
    study_count_limit: json['study_count_limit'] as int?,
    symbol_search_request_delay: json['symbol_search_request_delay'] as int?,
    timeframe: json['timeframe'] as String?,
    timezone: json['timezone'] as String?,
    toolbar_bg: json['toolbar_bg'] as String?,
    width: json['width'] as int?,
    charts_storage_url: json['charts_storage_url'] as String?,
    charts_storage_api_version: json['charts_storage_api_version'] as String?,
    client_id: json['client_id'] as String?,
    user_id: json['user_id'] as String?,
    load_last_chart: json['load_last_chart'] as bool?,
    studies_overrides: json['studies_overrides'] as Map<String, dynamic>?,
    overrides: json['overrides'] as Map<String, dynamic>?,
    snapshot_url: json['snapshot_url'] as String?,
    preset: json['preset'] as String?,
    time_frames: json['time_frames'] == null
        ? null
        : TimeFrameItem.fromJson(json['time_frames'] as Map<String, dynamic>),
    custom_css_url: json['custom_css_url'] as String?,
    favorites: json['favorites'] == null
        ? null
        : Favorites.fromJson(json['favorites'] as Map<String, dynamic>),
    loading_screen: json['loading_screen'] == null
        ? null
        : LoadingScreenOptions.fromJson(
            json['loading_screen'] as Map<String, dynamic>),
    theme: json['theme'] as String?,
    compare_symbols: (json['compare_symbols'] as List<dynamic>?)
        ?.map((e) => CompareSymbol.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

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
  writeNotNull('auto_save_delay', instance.auto_save_delay);
  writeNotNull('autosize', instance.autosize);
  writeNotNull('debug', instance.debug);
  writeNotNull('disabled_features', instance.disabled_features);
  writeNotNull('drawings_access', instance.drawings_access);
  writeNotNull('enabled_features', instance.enabled_features);
  writeNotNull('fullscreen', instance.fullscreen);
  writeNotNull('height', instance.height);
  val['locale'] = instance.locale;
  writeNotNull('numeric_formatting', instance.numeric_formatting);
  writeNotNull('saved_data', instance.saved_data);
  writeNotNull('saved_data_meta_info', instance.saved_data_meta_info);
  writeNotNull('studies_access', instance.studies_access);
  writeNotNull('study_count_limit', instance.study_count_limit);
  writeNotNull(
      'symbol_search_request_delay', instance.symbol_search_request_delay);
  writeNotNull('timeframe', instance.timeframe);
  writeNotNull('timezone', instance.timezone);
  writeNotNull('toolbar_bg', instance.toolbar_bg);
  writeNotNull('width', instance.width);
  writeNotNull('charts_storage_url', instance.charts_storage_url);
  writeNotNull(
      'charts_storage_api_version', instance.charts_storage_api_version);
  writeNotNull('client_id', instance.client_id);
  writeNotNull('user_id', instance.user_id);
  writeNotNull('load_last_chart', instance.load_last_chart);
  writeNotNull('studies_overrides', instance.studies_overrides);
  writeNotNull('overrides', instance.overrides);
  writeNotNull('snapshot_url', instance.snapshot_url);
  writeNotNull('preset', instance.preset);
  writeNotNull('time_frames', instance.time_frames);
  writeNotNull('custom_css_url', instance.custom_css_url);
  writeNotNull('favorites', instance.favorites);
  writeNotNull('loading_screen', instance.loading_screen);
  writeNotNull('theme', instance.theme);
  writeNotNull('compare_symbols', instance.compare_symbols);
  return val;
}

SavedStateMetaInfo _$SavedStateMetaInfoFromJson(Map<String, dynamic> json) {
  return SavedStateMetaInfo(
    uid: json['uid'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$SavedStateMetaInfoToJson(SavedStateMetaInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
    };

CompareSymbol _$CompareSymbolFromJson(Map<String, dynamic> json) {
  return CompareSymbol(
    symbol: json['symbol'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$CompareSymbolToJson(CompareSymbol instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'title': instance.title,
    };

LoadingScreenOptions _$LoadingScreenOptionsFromJson(Map<String, dynamic> json) {
  return LoadingScreenOptions(
    foregroundColor: json['foregroundColor'] as String?,
    backgroundColor: json['backgroundColor'] as String?,
  );
}

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

Favorites _$FavoritesFromJson(Map<String, dynamic> json) {
  return Favorites(
    intervals:
        (json['intervals'] as List<dynamic>).map((e) => e as String).toList(),
    chartTypes:
        (json['chartTypes'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$FavoritesToJson(Favorites instance) => <String, dynamic>{
      'intervals': instance.intervals,
      'chartTypes': instance.chartTypes,
    };

TimeFrameItem _$TimeFrameItemFromJson(Map<String, dynamic> json) {
  return TimeFrameItem(
    text: json['text'] as String,
    resolution: json['resolution'] as String,
    description: json['description'] as String?,
    title: json['title'] as String?,
  );
}

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
    Map<String, dynamic> json) {
  return NumericFormattingParams(
    decimal_sign: json['decimal_sign'] as String,
  );
}

Map<String, dynamic> _$NumericFormattingParamsToJson(
        NumericFormattingParams instance) =>
    <String, dynamic>{
      'decimal_sign': instance.decimal_sign,
    };

AccessList _$AccessListFromJson(Map<String, dynamic> json) {
  return AccessList(
    type: json['type'] as String,
    tools: (json['tools'] as List<dynamic>)
        .map((e) => AccessListItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AccessListToJson(AccessList instance) =>
    <String, dynamic>{
      'type': instance.type,
      'tools': instance.tools,
    };

AccessListItem _$AccessListItemFromJson(Map<String, dynamic> json) {
  return AccessListItem(
    name: json['name'] as String,
    grayed: json['grayed'] as bool?,
  );
}

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
