import 'package:career_portal/core/extensions/number_formatting_extensions.dart';
import 'package:flutter/services.dart';

abstract final class FieldFormat {
  static const int phoneMaxLength = 15;

  static List<TextInputFormatter> get phoneFormatters => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(phoneMaxLength),
  ];

  static List<TextInputFormatter> get commaSeparatedNumberFormatters => [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
    const CommaSeparatedNumberFormatter(),
  ];
}

/// Formats whole numbers with thousand separators while typing.
class CommaSeparatedNumberFormatter extends TextInputFormatter {
  const CommaSeparatedNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.withoutCommas.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final number = int.tryParse(digits);
    if (number == null) return oldValue;

    final formatted = number.toCommaSeparated();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
