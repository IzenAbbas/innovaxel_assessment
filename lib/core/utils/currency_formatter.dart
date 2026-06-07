class CurrencyFormatter {
  static String formatPKR(double amount, {bool showSign = false}) {
    final absAmount = amount.abs();
    final parts = absAmount.toStringAsFixed(2).split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    final buffer = StringBuffer();
    int count = 0;
    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
      count++;
    }

    final formattedInteger = buffer.toString().split('').reversed.join('');
    final formattedAmount = '$formattedInteger.$decimalPart';

    if (amount < 0) {
      return '-$formattedAmount PKR';
    } else if (amount > 0 && showSign) {
      return '+$formattedAmount PKR';
    }
    return '$formattedAmount PKR';
  }
}
