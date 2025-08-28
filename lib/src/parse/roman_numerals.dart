/// Roman numeral parsing utilities.
library;

/// Supports standard symbols I,V,X,L,C,D,M with subtractive notation (IV, IX, XL, XC, CD, CM).
/// Also supports an optional overline (combining overline \u0305) to multiply a symbol by 1000
/// e.g., M\u0305 = 1,000,000 (M with overline). If overline usage is not present, standard values apply.

const Map<String, int> _romanBase = {
  'I': 1,
  'V': 5,
  'X': 10,
  'L': 50,
  'C': 100,
  'D': 500,
  'M': 1000,
};

/// Parse a Roman numeral string to integer ([BigInt]).
///
/// Supports subtractive notation (e.g., `IV`, `IX`, `XL`, `XC`, `CD`, `CM`).
/// Also understands combining overline (U+0305) immediately following a symbol
/// to multiply that symbol's value by 1,000. For example, `M\u0305` yields
/// 1,000,000.
///
/// Throws a [FormatException] if the input is empty or contains invalid symbols.
BigInt parseRoman(String roman) {
  if (roman.isEmpty) throw FormatException('Empty roman numeral');

  // Normalize: uppercase and strip spaces
  final s = roman.toUpperCase().replaceAll(RegExp(r'\s+'), '');
  // Tokenize with optional combining overline (\u0305) after a symbol
  final tokens = <_RomanToken>[];
  final chars = s.split('');
  for (var i = 0; i < chars.length; i++) {
    final ch = chars[i];
    if (!_romanBase.containsKey(ch)) {
      throw FormatException('Invalid roman symbol: $ch');
    }
    var value = _romanBase[ch]!;
    // Check combining overline following this character
    if (i + 1 < chars.length && chars[i + 1] == '\u0305') {
      value *= 1000;
      i += 1; // consume overline
    }
    tokens.add(_RomanToken(value));
  }

  // Apply subtractive notation left-to-right
  var total = BigInt.zero;
  for (var i = 0; i < tokens.length; i++) {
    final cur = tokens[i].value;
    final next = (i + 1 < tokens.length) ? tokens[i + 1].value : 0;
    if (cur < next) {
      total -= BigInt.from(cur);
    } else {
      total += BigInt.from(cur);
    }
  }
  return total;
}

class _RomanToken {
  final int value;
  _RomanToken(this.value);
}
