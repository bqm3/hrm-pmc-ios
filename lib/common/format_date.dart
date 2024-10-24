import 'package:intl/intl.dart';

String formatDate(String? date) {
  if (date == null || date.isEmpty) return '';
  try {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  } catch (e) {
    return date;
  }
}

String formatCurrency(double? amount,
    {String locale = 'vi_VN', String symbol = '₫'}) {
  if (amount == null) return '';
  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: locale, symbol: symbol);
  return currencyFormatter.format(amount);
}

