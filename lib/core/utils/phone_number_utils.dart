abstract final class PhoneNumberUtils {
  static const String defaultDialCode = '+965';

  static const Map<String, String> _dialCodeToCountryCode = {
    '+965': 'KW',
    '+971': 'AE',
    '+966': 'SA',
    '+974': 'QA',
    '+973': 'BH',
    '+968': 'OM',
    '+1': 'US',
    '+44': 'GB',
    '+91': 'IN',
    '+20': 'EG',
    '+962': 'JO',
    '+961': 'LB',
  };

  static const List<String> gccFavoriteDialCodes = [
    '+965',
    '+971',
    '+966',
    '+974',
    '+973',
    '+968',
  ];

  static String initialSelectionForPicker(String? dialCode) {
    if (dialCode == null || dialCode.isEmpty) {
      return _dialCodeToCountryCode[defaultDialCode]!;
    }
    final normalized = dialCode.startsWith('+') ? dialCode : '+$dialCode';
    return _dialCodeToCountryCode[normalized] ??
        _dialCodeToCountryCode[defaultDialCode]!;
  }

  static String normalizeDialCode(String? dialCode) {
    if (dialCode == null || dialCode.trim().isEmpty) return defaultDialCode;
    final trimmed = dialCode.trim();
    return trimmed.startsWith('+') ? trimmed : '+$trimmed';
  }

  static String? fullPhoneNumber({
    required String? dialCode,
    required String? localNumber,
  }) {
    final number = localNumber?.trim();
    if (number == null || number.isEmpty) return null;
    return '${normalizeDialCode(dialCode)}$number';
  }
}
