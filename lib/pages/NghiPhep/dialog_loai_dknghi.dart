import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/model/calamviec2_model.dart';
import 'package:salesoft_hrm/pages/NghiPhep/dk_nghikhongluong_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/dknghiphep_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghicoluong_page.dart';

class LoaiDKNghiDialog extends StatefulWidget {
  @override
  _LoaiDKDialogState createState() => _LoaiDKDialogState();
}

class _LoaiDKDialogState extends State<LoaiDKNghiDialog> {
  TextEditingController tuNgayController = TextEditingController();
  TextEditingController denNgayController = TextEditingController();
  TextEditingController oldShiftController = TextEditingController();

  CaLamViec3? selectedOldShift;
  late List<CaLamViec3> oldShiftOptions;

  @override
  void initState() {
    super.initState();
    oldShiftOptions = [];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  tuNgayController.clear();
                  denNgayController.clear();
      Navigator.of(Get.context!).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ManyDayDialog(
                        tuNgayController: tuNgayController,
                        denNgayController: denNgayController,
                        oldShiftController: oldShiftController,
                        selectedOldShift: selectedOldShift,
                        oldShiftOptions: oldShiftOptions,
                      );
                    },
                  );
                },
                child: Container(
                    height: 40.h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FaIcon(FontAwesomeIcons.calendarDays,
                              color: Colors.blue, size: 16.sp),
                        ),
                        Expanded(
                            flex: 8,
                            child: Text('Nghỉ phép',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)))
                      ],
                    )),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  tuNgayController.clear();
                  denNgayController.clear();
      Navigator.of(Get.context!).pop();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ManyDayDialog3(
                        tuNgayController: tuNgayController,
                        denNgayController: denNgayController,
                        oldShiftController: oldShiftController,
                        selectedOldShift: selectedOldShift,
                        oldShiftOptions: oldShiftOptions,
                      );
                    },
                  );
                },
                child: Container(
                    height: 40.h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FaIcon(FontAwesomeIcons.calendarDays,
                              color: Colors.blue, size: 16.sp),
                        ),
                        Expanded(
                            flex: 8,
                            child: Text('Nghỉ có lương',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)))
                      ],
                    )),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  tuNgayController.clear();
                  denNgayController.clear();
      Navigator.of(Get.context!).pop();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ManyDayDialog2(
                        tuNgayController: tuNgayController,
                        denNgayController: denNgayController,
                        oldShiftController: oldShiftController,
                        selectedOldShift: selectedOldShift,
                        oldShiftOptions: oldShiftOptions,
                      );
                    },
                  );
                },
                child: Container(
                    height: 40.h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FaIcon(FontAwesomeIcons.calendarDays,
                              color: Colors.blue, size: 16.sp),
                        ),
                        Expanded(
                            flex: 8,
                            child: Text('Nghỉ không lương',
                                style: TextStyle(
                                    fontFamily: 'Arimo',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold)))
                      ],
                    )),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
