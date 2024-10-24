import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/date_time_helper.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/detail/filter_date_controller.dart';

enum EPeriodTime {
  thisMonth,
  lastMonth,
  thisQuarter,
  lastQuarter,
  thisYear,
  lastYear,
  customDate
}

extension EPeriodTimeExt on EPeriodTime {
  ///
  /// Tên
  ///
  String get name {
    switch (this) {
      case EPeriodTime.thisMonth:
        return "Tháng này";
      case EPeriodTime.lastMonth:
        return "Tháng trước";
      case EPeriodTime.thisQuarter:
        return "Quý này";
      case EPeriodTime.lastQuarter:
        return "Quý trước";
      case EPeriodTime.thisYear:
        return "Năm này";
      case EPeriodTime.lastYear:
        return "Năm trước";
      case EPeriodTime.customDate:
        return AppConstant.labelFilterCustomDate;
    }
  }

  ///
  /// Thời gian
  ///
  PeriodTimeValue get timeValue {
    final currentDate = DateTime.now();
    switch (this) {
      case EPeriodTime.thisMonth:
        final fromDate = DateTime(currentDate.year, currentDate.month, 1);
        final toDate = DateTime(currentDate.year, currentDate.month + 1, 0);
        return PeriodTimeValue(fromDate: fromDate, toDate: toDate);
      case EPeriodTime.lastMonth:
        final fromDate = DateTime(currentDate.year, currentDate.month - 1, 1);
        final toDate = DateTime(currentDate.year, currentDate.month, 0);
        return PeriodTimeValue(fromDate: fromDate, toDate: toDate);
      case EPeriodTime.thisQuarter:
        return getDayOfYearlyQuarter(currentDate.month);
      case EPeriodTime.lastQuarter:
        if (currentDate.month >= 1 && currentDate.month <= 3) {
          final fromDate = DateTime(currentDate.year - 1, 10, 1);
          final toDate = DateTime(currentDate.year - 1, 12, 31);
          return PeriodTimeValue(fromDate: fromDate, toDate: toDate);
        }
        return getDayOfYearlyQuarter(
            currentDate.month == 1 ? 12 : (currentDate.month - 3));
      case EPeriodTime.thisYear:
        final fromDate = DateTime(currentDate.year, 1, 1);
        final toDate = DateTime(currentDate.year, 12, 31);
        return PeriodTimeValue(fromDate: fromDate, toDate: toDate);
      case EPeriodTime.lastYear:
        final fromDate = DateTime(currentDate.year - 1, 1, 1);
        final toDate = DateTime(currentDate.year - 1, 12, 31);
        return PeriodTimeValue(fromDate: fromDate, toDate: toDate);

      case EPeriodTime.customDate:
        final FilterDateController controller = Get.find();
        DateTime _fromDate = controller.customFromDate ?? currentDate;
        DateTime _toDate = controller.customToDate ?? currentDate;
        final fromDate =
            DateTime(_fromDate.year, _fromDate.month, _fromDate.day);
        final toDate = DateTime(_toDate.year, _toDate.month, _toDate.day);
        return PeriodTimeValue(fromDate: fromDate, toDate: toDate);
    }
  }

  ///
  /// Lấy ngày trong quý của năm
  ///
  PeriodTimeValue getDayOfYearlyQuarter(int month) {
    final year = DateTime.now().year;
    switch (month) {
      case 1:
      case 2:
      case 3:
        return PeriodTimeValue(
          fromDate: DateTime(year, 1, 1),
          toDate: DateTime(year, 3, 31),
        );
      case 4:
      case 5:
      case 6:
        return PeriodTimeValue(
          fromDate: DateTime(year, 4, 1),
          toDate: DateTime(year, 6, 30),
        );
      case 7:
      case 8:
      case 9:
        return PeriodTimeValue(
          fromDate: DateTime(year, 7, 1),
          toDate: DateTime(year, 9, 30),
        );
      case 10:
      case 11:
      case 12:
        return PeriodTimeValue(
          fromDate: DateTime(year, 10, 1),
          toDate: DateTime(year, 12, 31),
        );
      default:
        return PeriodTimeValue(
          fromDate: DateTime.now(),
          toDate: DateTime.now(),
        );
    }
  }
}

class PeriodTimeValue {
  DateTime fromDate;
  DateTime toDate;

  PeriodTimeValue({
    required this.fromDate,
    required this.toDate,
  });

  @override
  String toString() {
    return "${DateTimeHelper.dateToStringFormat(date: fromDate)} - ${DateTimeHelper.dateToStringFormat(date: toDate)}";
  }
}
