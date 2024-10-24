import 'package:intl/intl.dart';

class DateTimeHelper {
  static const String k_DD_MM_YYYY = "dd/MM/yyyy";
  static const String k_DD_MM_YYYY2 = "dd-MM-yyyy";

  ///
  /// Convert Date to String
  ///
  static String? dateToStringFormat(
      {String parten = k_DD_MM_YYYY, DateTime? date}) {
    if (date != null) {
      return DateFormat(parten).format(date);
    } else {
      return null;
    }
  }

  ///
  /// Convert Date to String for filter
  ///
  static String? dateToStringFormat4Filter(
      {String parten = k_DD_MM_YYYY2, DateTime? date}) {
    if (date != null) {
      return DateFormat(parten).format(date);
    } else {
      return null;
    }
  }

  ///
  /// Convert String to Date
  ///
  static DateTime? stringToDate(
      {String parten = k_DD_MM_YYYY, required String dateStr}) {
    if (dateStr.isNotEmpty) {
      try {
        return DateFormat(parten).parse(dateStr);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  static DateTime? stringToDate2(
      {String parten = k_DD_MM_YYYY, required String dateStr}) {
    if (dateStr.isNotEmpty) {
      try {
        DateTime myDate = DateTime.parse(dateStr);
        return DateTime(myDate.year, myDate.month, myDate.day);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }
}
