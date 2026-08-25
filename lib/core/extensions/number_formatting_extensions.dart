import 'package:intl/intl.dart';

extension NumberFormatting on num {
  String toCommaSeparated({int decimalPlaces = 0, bool trimZeros = false}) {
    if (trimZeros && this == roundToDouble()) {
      return NumberFormat('#,##0').format(this);
    }
    final decimals = decimalPlaces > 0 ? '.${'0' * decimalPlaces}' : '';
    return NumberFormat('#,##0$decimals').format(this);
  }
}

extension NullableNumberFormatting on num? {
  String toCommaSeparated({
    int decimalPlaces = 0,
    bool trimZeros = false,
    String fallback = '-',
  }) {
    final value = this;
    if (value == null) return fallback;
    return value.toCommaSeparated(
      decimalPlaces: decimalPlaces,
      trimZeros: trimZeros,
    );
  }
}

extension CommaSeparatedParsing on String {
  String get withoutCommas => replaceAll(',', '');

  double? parseCommaSeparated() => double.tryParse(withoutCommas);

  int? parseCommaSeparatedInt() => int.tryParse(withoutCommas);
}
