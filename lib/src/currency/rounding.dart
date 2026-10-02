import '../core/decimal_string.dart';

/// Rounds an amount to [fractionDigits] decimal places using half-up rounding.
({BigInt units, bool negative}) roundMoney(
  Object amount, {
  int fractionDigits = 2,
}) {
  if (fractionDigits < 0) {
    throw ArgumentError.value(
      fractionDigits,
      'fractionDigits',
      'must be nonnegative',
    );
  }
  final scale = BigInt.from(10).pow(fractionDigits);
  if (amount is BigInt) {
    return (units: amount.abs() * scale, negative: amount.isNegative);
  }

  late String value;
  late bool negative;
  if (amount is num) {
    if (!amount.isFinite) {
      throw ArgumentError.value(amount, 'amount', 'must be finite');
    }
    negative = amount < 0;
    value = expandScientificNotation(amount.abs().toString());
  } else if (amount is String) {
    value = amount.trim();
    if (!RegExp(
      r'^[+-]?(?:[0-9]+|[0-9]{1,3}(?:,[0-9]{3})+)(?:\.[0-9]+)?$',
    ).hasMatch(value)) {
      throw FormatException('Invalid decimal amount', amount);
    }
    negative = value.startsWith('-');
    if (value.startsWith('-') || value.startsWith('+')) {
      value = value.substring(1);
    }
    value = value.replaceAll(',', '');
  } else {
    throw ArgumentError.value(
      amount,
      'amount',
      'must be num, BigInt, or String',
    );
  }

  final parts = value.split('.');
  final fraction = (parts.length == 2 ? parts[1] : '').padRight(
    fractionDigits + 1,
    '0',
  );
  final minorDigits = fraction.substring(0, fractionDigits);
  final units =
      BigInt.parse(parts[0]) * scale +
      (minorDigits.isEmpty ? BigInt.zero : BigInt.parse(minorDigits)) +
      (fraction.codeUnitAt(fractionDigits) >= 0x35 ? BigInt.one : BigInt.zero);
  return (units: units, negative: negative);
}
