import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/filter_widget.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/Qtluong_controller.dart';

class _HeaderFilterTimeWidget extends StatelessWidget {
  const _HeaderFilterTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QtLuongController controller = Get.find();

    String? formattedDateRange;
    if (controller.tuNgay.value != null && controller.denNgay.value != null) {
      formattedDateRange =
          "${DateFormat('dd/MM/yyyy').format(controller.tuNgay.value!)} - ${DateFormat('dd/MM/yyyy').format(controller.denNgay.value!)}";
    }

    return FilterWidget(
      textColor: Colors.black,
      title: "Chọn ngày",
      imageAssetName: AppResource.icCalendar,
      onPress: () async {
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          initialDateRange: DateTimeRange(
            start: controller.tuNgay.value ?? DateTime.now(),
            end: controller.denNgay.value ?? DateTime.now(),
          ),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (picked != null) {
          controller.setTimePeriod(picked.start, picked.end);
        }
      },
      value: formattedDateRange ?? "", 
    );
  }
}
