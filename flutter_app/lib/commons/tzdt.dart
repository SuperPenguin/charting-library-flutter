import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

late Location tzLocation;

void setupTZLocation() {
  tzLocation = getLocation('Asia/Jakarta');
  setLocalLocation(tzLocation);
}

TZDateTime tzNow() {
  return TZDateTime.now(tzLocation);
}

TZDateTime tzSecond(int second) {
  return tzMillisecond(second * 1000);
}

TZDateTime tzMillisecond(int millisecond) {
  return TZDateTime.fromMillisecondsSinceEpoch(tzLocation, millisecond);
}

TZDateTime tzToday([
  int hour = 0,
  int minute = 0,
  int second = 0,
  int millisecond = 0,
  int microsecond = 0,
]) {
  var now = tzNow();

  return TZDateTime(
    tzLocation,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
    second,
    millisecond,
    microsecond,
  );
}

TZDateTime tzDate(
  int year, [
  int month = 1,
  int day = 1,
  int hour = 0,
  int minute = 0,
  int second = 0,
  int millisecond = 0,
  int microsecond = 0,
]) {
  return TZDateTime(
    tzLocation,
    year,
    month,
    day,
    hour,
    minute,
    second,
    millisecond,
    microsecond,
  );
}

// Reuse formatter
Map<String, Map<String, DateFormat>> _fmts = {};

String tzFormat(
  TZDateTime tzdt,
  String format, {
  String locale = 'en_US',
}) {
  final locFmts = _fmts.putIfAbsent(locale, () => {});
  final fmt = locFmts.putIfAbsent(format, () => DateFormat(format, locale));
  return fmt.format(tzdt);
}
