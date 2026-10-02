/// Expands the scientific notation emitted by [num.toString] to plain digits.
String expandScientificNotation(String value) {
  final match = RegExp(
    r'^([0-9]+)(?:\.([0-9]+))?[eE]([+-]?[0-9]+)$',
  ).firstMatch(value);
  if (match == null) return value;

  final whole = match[1]!;
  final digits = whole + (match[2] ?? '');
  final point = whole.length + int.parse(match[3]!);
  if (point <= 0) return '0.${''.padLeft(-point, '0')}$digits';
  if (point >= digits.length) {
    return '$digits${''.padLeft(point - digits.length, '0')}';
  }
  return '${digits.substring(0, point)}.${digits.substring(point)}';
}
