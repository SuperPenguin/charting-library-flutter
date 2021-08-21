import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tvchart_types.g.dart';

enum ChartTheme {
  @JsonValue('Light')
  light,

  @JsonValue('Dark')
  dark,
}

enum AccessListType {
  @JsonValue('black')
  black,

  @JsonValue('white')
  white,
}

enum Timezone {
  @JsonValue('Etc/UTC')
  utc,

  @JsonValue('Africa/Cairo')
  africaCairo,

  @JsonValue('Africa/Johannesburg')
  africaJohannesburg,

  @JsonValue('Africa/Lagos')
  africaLagos,

  @JsonValue('America/Argentina/Buenos_Aires')
  americaArgentinaBuenosAires,

  @JsonValue('America/Bogota')
  americaBogota,

  @JsonValue('America/Caracas')
  americaCaracas,

  @JsonValue('America/Chicago')
  americaChicago,

  @JsonValue('America/El_Salvador')
  americaElSalvador,

  @JsonValue('America/Juneau')
  americaJuneau,

  @JsonValue('America/Lima')
  americaLima,

  @JsonValue('America/Los_Angeles')
  americaLosAngeles,

  @JsonValue('America/Mexico_City')
  americaMexicoCity,

  @JsonValue('America/New_York')
  americaNewYork,

  @JsonValue('America/Phoenix')
  americaPhoenix,

  @JsonValue('America/Santiago')
  americaSantiago,

  @JsonValue('America/Sao_Paulo')
  americaSaoPaulo,

  @JsonValue('America/Toronto')
  americaToronto,

  @JsonValue('America/Vancouver')
  americaVancouver,

  @JsonValue('Asia/Almaty')
  asiaAlmaty,

  @JsonValue('Asia/Ashkhabad')
  asiaAshkhabad,

  @JsonValue('Asia/Bahrain')
  asiaBahrain,

  @JsonValue('Asia/Bangkok')
  asiaBangkok,

  @JsonValue('Asia/Chongqing')
  asiaChongqing,

  @JsonValue('Asia/Dubai')
  asiaDubai,

  @JsonValue('Asia/Ho_Chi_Minh')
  asiaHoChiMinh,

  @JsonValue('Asia/Hong_Kong')
  asiaHongKong,

  @JsonValue('Asia/Jakarta')
  asiaJakarta,

  @JsonValue('Asia/Jerusalem')
  asiaJerusalem,

  @JsonValue('Asia/Kathmandu')
  asiaKathmandu,

  @JsonValue('Asia/Kolkata')
  asiaKolkata,

  @JsonValue('Asia/Kuwait')
  asiaKuwait,

  @JsonValue('Asia/Muscat')
  asiaMuscat,

  @JsonValue('Asia/Qatar')
  asiaQatar,

  @JsonValue('Asia/Riyadh')
  asiaRiyadh,

  @JsonValue('Asia/Seoul')
  asiaSeoul,

  @JsonValue('Asia/Shanghai')
  asiaShanghai,

  @JsonValue('Asia/Singapore')
  asiaSingapore,

  @JsonValue('Asia/Taipei')
  asiaTaipei,

  @JsonValue('Asia/Tehran')
  asiaTehran,

  @JsonValue('Asia/Tokyo')
  asiaTokyo,

  @JsonValue('Atlantic/Reykjavik')
  atlanticReykjavik,

  @JsonValue('Australia/ACT')
  australiaACT,

  @JsonValue('Australia/Adelaide')
  australiaAdelaide,

  @JsonValue('Australia/Brisbane')
  australiaBrisbane,

  @JsonValue('Australia/Perth')
  australiaPerth,

  @JsonValue('Australia/Sydney')
  australiaSydney,

  @JsonValue('Europe/Amsterdam')
  europeAmsterdam,

  @JsonValue('Europe/Athens')
  europeAthens,

  @JsonValue('Europe/Belgrade')
  europeBelgrade,

  @JsonValue('Europe/Berlin')
  europeBerlin,

  @JsonValue('Europe/Brussels')
  europeBrussels,

  @JsonValue('Europe/Copenhagen')
  europeCopenhagen,

  @JsonValue('Europe/Dublin')
  europeDublin,

  @JsonValue('Europe/Helsinki')
  europeHelsinki,

  @JsonValue('Europe/Istanbul')
  europeIstanbul,

  @JsonValue('Europe/Lisbon')
  europeLisbon,

  @JsonValue('Europe/London')
  europeLondon,

  @JsonValue('Europe/Luxembourg')
  europeLuxembourg,

  @JsonValue('Europe/Madrid')
  europeMadrid,

  @JsonValue('Europe/Malta')
  europeMalta,

  @JsonValue('Europe/Moscow')
  europeMoscow,

  @JsonValue('Europe/Oslo')
  europeOslo,

  @JsonValue('Europe/Paris')
  europeParis,

  @JsonValue('Europe/Riga')
  europeRiga,

  @JsonValue('Europe/Rome')
  europeRome,

  @JsonValue('Europe/Stockholm')
  europeStockholm,

  @JsonValue('Europe/Tallinn')
  europeTallinn,

  @JsonValue('Europe/Vilnius')
  europeVilnius,

  @JsonValue('Europe/Warsaw')
  europeWarsaw,

  @JsonValue('Europe/Zurich')
  europeZurich,

  @JsonValue('Pacific/Auckland')
  pacificAuckland,

  @JsonValue('Pacific/Chatham')
  pacificChatham,

  @JsonValue('Pacific/Fakaofo')
  pacificFakaofo,

  @JsonValue('Pacific/Honolulu')
  pacificHonolulu,

  @JsonValue('Pacific/Norfolk')
  pacificNorfolk,

  @JsonValue('US/Mountain')
  usMountain,

  /// Only use this when the parameters/function actually could accept timezone `exchange`
  @JsonValue('exchange')
  exchange,
}

enum SeriesFormat {
  @JsonValue('price')
  price,

  @JsonValue('volume')
  volume,
}

enum DataStatus {
  @JsonValue('streaming')
  streaming,

  @JsonValue('endofday')
  endOfDay,

  @JsonValue('pulsed')
  pulsed,

  @JsonValue('delayed_streaming')
  delayedStreaming,
}

@immutable
@JsonSerializable(includeIfNull: false)
class PeriodParams {
  final int from;

  final int to;

  final int countBack;

  final bool firstDataRequest;

  const PeriodParams({
    required this.from,
    required this.to,
    required this.countBack,
    required this.firstDataRequest,
  });

  factory PeriodParams.fromJson(Map<String, dynamic> json) =>
      _$PeriodParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodParamsToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class Bar {
  final int time;

  final double open;

  final double high;

  final double low;

  final double close;

  final int? volume;

  const Bar({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    this.volume,
  });

  factory Bar.fromJson(Map<String, dynamic> json) => _$BarFromJson(json);

  Map<String, dynamic> toJson() => _$BarToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class Exchange {
  final String value;

  final String name;

  final String desc;

  const Exchange({
    required this.value,
    required this.name,
    required this.desc,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) =>
      _$ExchangeFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class DatafeedConfiguration {
  final List<Exchange>? exchanges;

  @JsonKey(name: 'supported_resolutions')
  final List<String>? supportedResolutions;

  @JsonKey(name: 'currency_codes')
  final List<String>? currencyCodes;

  @JsonKey(name: 'supports_marks')
  final bool? supportsMarks;

  @JsonKey(name: 'supports_time')
  final bool? supportsTime;

  @JsonKey(name: 'supports_timescale_marks')
  final bool? supportsTimescaleMarks;

  @JsonKey(name: 'symbols_types')
  final List<DatafeedSymbolType>? symbolsTypes;

  const DatafeedConfiguration({
    this.exchanges,
    this.supportedResolutions,
    this.currencyCodes,
    this.supportsMarks,
    this.supportsTime,
    this.supportsTimescaleMarks,
    this.symbolsTypes,
  });

  factory DatafeedConfiguration.fromJson(Map<String, dynamic> json) =>
      _$DatafeedConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$DatafeedConfigurationToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class DatafeedSymbolType {
  final String name;

  final String value;

  const DatafeedSymbolType({
    required this.name,
    required this.value,
  });

  factory DatafeedSymbolType.fromJson(Map<String, dynamic> json) =>
      _$DatafeedSymbolTypeFromJson(json);

  Map<String, dynamic> toJson() => _$DatafeedSymbolTypeToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class SearchSymbolResultItem {
  final String symbol;

  @JsonKey(name: 'full_name')
  final String fullName;

  final String description;

  final String exchange;

  final String ticker;

  final String type;

  const SearchSymbolResultItem({
    required this.symbol,
    required this.fullName,
    required this.description,
    required this.exchange,
    required this.ticker,
    required this.type,
  });

  factory SearchSymbolResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchSymbolResultItemFromJson(json);

  Map<String, dynamic> toJson() => _$SearchSymbolResultItemToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class LibrarySymbolInfo {
  final String name;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'base_name')
  final List<String>? baseName;

  final String? ticker;

  final String description;

  final String type;

  final String session;

  @JsonKey(name: 'session_display')
  final String? sessionDisplay;

  final String? holidays;

  final String? corrections;

  final String exchange;

  @JsonKey(name: 'listed_exchange')
  final String listedExchange;

  final Timezone timezone;

  final SeriesFormat format;

  final double pricescale;

  final double minmov;

  final bool? fractional;

  final double? minmove2;

  @JsonKey(name: 'has_intraday')
  final bool? hasIntraday;

  @JsonKey(name: 'supported_resolutions')
  final List<String> supportedResolutions;

  @JsonKey(name: 'intraday_multipliers')
  final List<String>? intradayMultipliers;

  @JsonKey(name: 'has_seconds')
  final bool? hasSeconds;

  @JsonKey(name: 'has_ticks')
  final bool? hasTicks;

  @JsonKey(name: 'seconds_multipliers')
  final List<String>? secondsMultipliers;

  @JsonKey(name: 'has_daily')
  final bool? hasDaily;

  @JsonKey(name: 'has_weekly_and_monthly')
  final bool? hasWeeklyAndMonthly;

  @JsonKey(name: 'has_empty_bars')
  final bool? hasEmptyBars;

  @JsonKey(name: 'has_no_volume')
  final bool? hasNoVolume;

  @JsonKey(name: 'volume_precision')
  final double? volumePrecision;

  @JsonKey(name: 'data_status')
  final String? dataStatus;

  final bool? expired;

  @JsonKey(name: 'expiration_date')
  final int? expirationDate;

  final String? sector;

  final String? industry;

  @JsonKey(name: 'currency_code')
  final String? currencyCode;

  @JsonKey(name: 'original_currency_code')
  final String? originalCurrencyCode;

  const LibrarySymbolInfo({
    required this.name,
    required this.fullName,
    this.baseName,
    this.ticker,
    required this.description,
    required this.type,
    required this.session,
    this.sessionDisplay,
    this.holidays,
    this.corrections,
    required this.exchange,
    required this.listedExchange,
    required this.timezone,
    required this.format,
    required this.pricescale,
    required this.minmov,
    this.fractional,
    this.minmove2,
    this.hasIntraday,
    required this.supportedResolutions,
    this.intradayMultipliers,
    this.hasSeconds,
    this.hasTicks,
    this.secondsMultipliers,
    this.hasDaily,
    this.hasWeeklyAndMonthly,
    this.hasEmptyBars,
    this.hasNoVolume,
    this.volumePrecision,
    this.dataStatus,
    this.expired,
    this.expirationDate,
    this.sector,
    this.industry,
    this.currencyCode,
    this.originalCurrencyCode,
  });

  factory LibrarySymbolInfo.fromJson(Map<String, dynamic> json) =>
      _$LibrarySymbolInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LibrarySymbolInfoToJson(this);
}

/// Some property is not here and you should add it on JS side if needed:
/// ```md
/// required on JS side
/// - container
/// - datafeed
/// ```
@immutable
@JsonSerializable(includeIfNull: false)
class ChartingLibraryWidgetOptions {
  final String interval;

  final String? symbol;

  @JsonKey(name: 'auto_save_delay')
  final int? autoSaveDelay;

  final bool? autosize;

  final bool? debug;

  @JsonKey(name: 'disabled_features')
  final List<String>? disabledFeatures;

  @JsonKey(name: 'drawings_access')
  final AccessList? drawingsAccess;

  @JsonKey(name: 'enabled_features')
  final List<String>? enabledFeatures;

  final bool? fullscreen;

  final int? height;

  final String locale;

  @JsonKey(name: 'numeric_formatting')
  final NumericFormattingParams? numericFormatting;

  @JsonKey(name: 'saved_data')
  final Map<String, dynamic>? savedData;

  @JsonKey(name: 'saved_data_meta_info')
  final SavedStateMetaInfo? savedDataMetaInfo;

  @JsonKey(name: 'studies_access')
  final AccessList? studiesAccess;

  @JsonKey(name: 'study_count_limit')
  final int? studyCountLimit;

  @JsonKey(name: 'symbol_search_request_delay')
  final int? symbolSearchRequestDelay;

  final String? timeframe;

  final Timezone? timezone;

  @JsonKey(name: 'toolbar_bg')
  final String? toolbarBg;

  final int? width;

  @JsonKey(name: 'charts_storage_url')
  final String? chartsStorageUrl;

  @JsonKey(name: 'charts_storage_api_version')
  final String? chartsStorageApiVersion;

  @JsonKey(name: 'client_id')
  final String? clientId;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'load_last_chart')
  final bool? loadLastChart;

  // TODO: Use custom class that handle Map<String, String | num | bool>
  @JsonKey(name: 'studies_overrides')
  final Map<String, dynamic>? studiesOverrides;

  // TODO: Use custom class that handle Map<String, String | num | bool>
  final Map<String, dynamic>? overrides;

  @JsonKey(name: 'snapshot_url')
  final String? snapshotUrl;

  final String? preset;

  @JsonKey(name: 'time_frames')
  final TimeFrameItem? timeFrames;

  @JsonKey(name: 'custom_css_url')
  final String? customCssUrl;

  final Favorites? favorites;

  @JsonKey(name: 'loading_screen')
  final LoadingScreenOptions? loadingScreen;

  final ChartTheme? theme;

  @JsonKey(name: 'compare_symbols')
  final List<CompareSymbol>? compareSymbols;

  const ChartingLibraryWidgetOptions({
    required this.interval,
    this.symbol,
    this.autoSaveDelay,
    this.autosize,
    this.debug,
    this.disabledFeatures,
    this.drawingsAccess,
    this.enabledFeatures,
    this.fullscreen,
    this.height,
    required this.locale,
    this.numericFormatting,
    this.savedData,
    this.savedDataMetaInfo,
    this.studiesAccess,
    this.studyCountLimit,
    this.symbolSearchRequestDelay,
    this.timeframe,
    this.timezone,
    this.toolbarBg,
    this.width,
    this.chartsStorageUrl,
    this.chartsStorageApiVersion,
    this.clientId,
    this.userId,
    this.loadLastChart,
    this.studiesOverrides,
    this.overrides,
    this.snapshotUrl,
    this.preset,
    this.timeFrames,
    this.customCssUrl,
    this.favorites,
    this.loadingScreen,
    this.theme,
    this.compareSymbols,
  });

  factory ChartingLibraryWidgetOptions.fromJson(Map<String, dynamic> json) =>
      _$ChartingLibraryWidgetOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$ChartingLibraryWidgetOptionsToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class SavedStateMetaInfo {
  final int uid;
  final String name;
  final String description;

  const SavedStateMetaInfo({
    required this.uid,
    required this.name,
    required this.description,
  });

  factory SavedStateMetaInfo.fromJson(Map<String, dynamic> json) =>
      _$SavedStateMetaInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SavedStateMetaInfoToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class CompareSymbol {
  final String symbol;
  final String title;

  const CompareSymbol({
    required this.symbol,
    required this.title,
  });

  factory CompareSymbol.fromJson(Map<String, dynamic> json) =>
      _$CompareSymbolFromJson(json);

  Map<String, dynamic> toJson() => _$CompareSymbolToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class LoadingScreenOptions {
  final String? foregroundColor;
  final String? backgroundColor;

  const LoadingScreenOptions({
    this.foregroundColor,
    this.backgroundColor,
  });

  factory LoadingScreenOptions.fromJson(Map<String, dynamic> json) =>
      _$LoadingScreenOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$LoadingScreenOptionsToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class Favorites {
  final List<String> intervals;
  final List<String> chartTypes;

  const Favorites({
    required this.intervals,
    required this.chartTypes,
  });

  factory Favorites.fromJson(Map<String, dynamic> json) =>
      _$FavoritesFromJson(json);

  Map<String, dynamic> toJson() => _$FavoritesToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class TimeFrameItem {
  final String text;
  final String resolution;
  final String? description;
  final String? title;

  const TimeFrameItem({
    required this.text,
    required this.resolution,
    this.description,
    this.title,
  });

  factory TimeFrameItem.fromJson(Map<String, dynamic> json) =>
      _$TimeFrameItemFromJson(json);

  Map<String, dynamic> toJson() => _$TimeFrameItemToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class NumericFormattingParams {
  @JsonKey(name: 'decimal_sign')
  final String decimalSign;

  const NumericFormattingParams({
    required this.decimalSign,
  });

  factory NumericFormattingParams.fromJson(Map<String, dynamic> json) =>
      _$NumericFormattingParamsFromJson(json);

  Map<String, dynamic> toJson() => _$NumericFormattingParamsToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class AccessList {
  final AccessListType type;
  final List<AccessListItem> tools;

  const AccessList({
    required this.type,
    required this.tools,
  });

  factory AccessList.fromJson(Map<String, dynamic> json) =>
      _$AccessListFromJson(json);

  Map<String, dynamic> toJson() => _$AccessListToJson(this);
}

@immutable
@JsonSerializable(includeIfNull: false)
class AccessListItem {
  final String name;
  final bool? grayed;

  const AccessListItem({
    required this.name,
    this.grayed,
  });

  factory AccessListItem.fromJson(Map<String, dynamic> json) =>
      _$AccessListItemFromJson(json);

  Map<String, dynamic> toJson() => _$AccessListItemToJson(this);
}
