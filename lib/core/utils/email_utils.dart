abstract final class EmailUtils {
  static final RegExp _pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  static String normalize(String email) => email.trim();

  static bool isValid(String email) {
    final normalized = normalize(email);
    if (normalized.isEmpty) return false;
    return _pattern.hasMatch(normalized);
  }

  static bool isEmpty(String email) => normalize(email).isEmpty;
}
