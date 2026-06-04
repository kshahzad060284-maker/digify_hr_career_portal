import 'package:flutter/services.dart';

abstract final class FieldFormat {
  static const int phoneMaxLength = 15;

  static List<TextInputFormatter> get phoneFormatters => [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(phoneMaxLength),
  ];
}
