extension StringTitleCaseExtension on String {
  String toTitleCase() {
    final trimmed = trim();
    if (trimmed.isEmpty) return trimmed;

    return trimmed
        .split(RegExp(r'[\s_]+'))
        .where((word) => word.isNotEmpty)
        .map(
          (word) =>
              '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
