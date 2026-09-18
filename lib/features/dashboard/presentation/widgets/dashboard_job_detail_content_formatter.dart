List<String> mergeDashboardJobContentFragments(List<String> raw) {
  final cleaned = raw
      .map((item) => item.replaceFirst(RegExp(r'^[\s•\-*•●◦]+'), '').trim())
      .where((item) => item.isNotEmpty)
      .toList();
  if (cleaned.isEmpty) return cleaned;

  final result = <String>[];
  String buffer = '';

  for (final item in cleaned) {
    final wordCount = item.split(RegExp(r'\s+')).length;
    final endsWithPunctuation = RegExp(r'[.!?:;]$').hasMatch(item.trim());

    if (buffer.isNotEmpty) {
      buffer = '$buffer $item';
      if (wordCount >= 4 || endsWithPunctuation) {
        result.add(buffer.trim());
        buffer = '';
      }
    } else if (wordCount < 4 && !endsWithPunctuation) {
      buffer = item;
    } else {
      result.add(item);
    }
  }

  if (buffer.isNotEmpty) result.add(buffer.trim());
  return result;
}
