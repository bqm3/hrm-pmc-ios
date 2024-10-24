import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/date_time_helper.dart';
import 'package:salesoft_hrm/common/period_time.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/detail/filter_date_controller.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';

class FilterTimeWidget extends StatelessWidget {
  const FilterTimeWidget({
    Key? key,
    required this.values,
    required this.valueSelected,
    this.onPress,
  }) : super(key: key);

  final List<EPeriodTime> values;
  final EPeriodTime valueSelected;
  final Function(EPeriodTime)? onPress;

  @override
  Widget build(BuildContext context) {
    final FilterDateController controller = Get.put(FilterDateController());
    List<EPeriodTime> lstPeriod = values
        .where((EPeriodTime elm) => elm != EPeriodTime.customDate)
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
              right: AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
              top: AppConstant.kSpaceHorizontalSmallExtraExtraExtra),
          child: Text(
            'Doanh thu lọc theo',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.grey),
          ),
        ),
        Divider(
          color: AppColors.border,
          height: 25.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: _CheckBoxButtonWidget(
            title: 'Khoảng thời gian',
            onPress: (value) {
              controller.update();
            },
            isChecked: controller.isCustomDateFilter,
          ),
        ),
        controller.obx((state) {
          controller.customFromDate =
              controller.customFromDate ?? valueSelected.timeValue.fromDate;
          controller.customToDate =
              controller.customToDate ?? valueSelected.timeValue.toDate;
          return controller.isCustomDateFilter.value == true
              ? Column(
                  children: [
                    AppConstant.spaceVerticalSmallExtraExtraExtra,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWellWidget(
                            child: _DateInfoWidget(
                              title: 'Từ: ',
                              value: DateTimeHelper.dateToStringFormat(
                                      date: controller.customFromDate) ??
                                  '',
                            ),
                            onPress: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  locale: const Locale("vi", "VN"),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101),
                                  cancelText: 'Bỏ qua',
                                  confirmText: 'Đồng ý',
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: AppColors.blue,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: AppColors.blue,
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              controller.customFromDate = picked;
                              //valueSelected.timeValue.fromDate = controller.customFromDate ?? valueSelected.timeValue.fromDate;
                              controller.update();
                            },
                          ),
                          InkWellWidget(
                            child: _DateInfoWidget(
                              title: "Đến: ",
                              value: DateTimeHelper.dateToStringFormat(
                                      date: controller.customToDate) ??
                                  '',
                            ),
                            onPress: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  locale: const Locale("vi", "VN"),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015, 8),
                                  lastDate: DateTime(2101),
                                  cancelText: 'Bỏ qua',
                                  confirmText: 'Đồng ý',
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: AppColors.blue,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: AppColors.blue,
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              controller.customToDate = picked;
                              //valueSelected.timeValue.toDate = controller.customToDate ?? valueSelected.timeValue.toDate;
                              controller.update();
                            },
                          )
                        ],
                      ),
                    ),
                    AppConstant.spaceVerticalSmallExtraExtraExtra,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.border,
                                  width: 0.5,
                                ),
                                right: BorderSide(
                                  color: AppColors.border,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: TextButton(
                              child: Text(
                                "Hủy",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey300,
                                    fontSize: 13.sp),
                              ),
                              onPressed: () => Get.back(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: AppColors.border,
                                  width: 0.5,
                                ),
                                //left: BorderSide(color: AppColors.grey, width: 0.3),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                EPeriodTime valueTime = EPeriodTime.customDate;
                                if (onPress != null) {
                                  onPress!(valueTime);
                                }
                              },
                              child: Text(
                                'Lọc',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    /*Align(
                alignment: Alignment.centerRight,
                child: InkWellWidget(
                  child: Container(
                      margin: const EdgeInsets.all(15),
                      height: 30.h,
                      width: 100.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        */ /*color: AppColors.blue,*/ /*
                          border: Border.all(
                              color: AppColors.blue,
                              width: 0.75),
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          shape: BoxShape.rectangle),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.filter_list, size: 15.sp, color: AppColors.blue),
                          const SizedBox(width: 10),
                          Text(
                            "Lọc",
                            style: TextStyle(color: AppColors.blue),
                          ),
                        ],
                      )
                  ),
                  onPress: () {
                    EPeriodTime valueTime = EPeriodTime.customDate;
                    if (onPress != null) {
                      onPress!(valueTime);
                    }
                  },
                ),
              )*/
                  ],
                )
              : Column(
                  children: [
                    AppConstant.spaceVerticalSmallExtraExtraExtra,
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _ItemDateDisplayWidget(
                          value: lstPeriod[index],
                          onPress: onPress,
                          valueSelected: valueSelected,
                        );
                      },
                      itemCount: lstPeriod.length,
                      separatorBuilder: (context, index) {
                        return AppConstant.spaceVerticalSmallMedium;
                      },
                    ),
                    AppConstant.spaceVerticalSmallExtraExtraExtra,
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              AppConstant.kSpaceHorizontalSmallExtraExtraExtra),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _DateInfoWidget(
                            title: 'Từ: ',
                            value: DateTimeHelper.dateToStringFormat(
                                    date: valueSelected.timeValue.fromDate) ??
                                '',
                          ),
                          _DateInfoWidget(
                            title: "Đến: ",
                            value: DateTimeHelper.dateToStringFormat(
                                    date: valueSelected.timeValue.toDate) ??
                                '',
                          ),
                        ],
                      ),
                    ),
                    AppConstant.spaceVerticalSmallExtraExtraExtra
                  ],
                );
        })
      ],
    );
  }
}

class _CheckBoxButtonWidget extends StatelessWidget {
  const _CheckBoxButtonWidget({
    Key? key,
    required this.title,
    required this.isChecked,
    this.onPress,
  }) : super(key: key);

  final String title;
  final RxBool isChecked;
  final Function(bool value)? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onPress: () {
        isChecked.value = !isChecked.value;
        if (onPress != null) {
          onPress!(isChecked.value);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppConstant.kSpaceHorizontalSmallExtra),
        child: Row(
          children: [
            Obx(() {
              return Icon(
                isChecked.value
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank,
                color: AppColors.blue,
              );
            }),
            AppConstant.spaceHorizontalSmallExtra,
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _ItemDateDisplayWidget extends StatelessWidget {
  const _ItemDateDisplayWidget({
    Key? key,
    required this.value,
    this.onPress,
    required this.valueSelected,
  }) : super(key: key);

  final EPeriodTime value;
  final EPeriodTime valueSelected;
  final Function(EPeriodTime)? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(
        horizontal: AppConstant.kSpaceVerticalSmallExtraExtra,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstant.kSpaceHorizontalSmallExtraExtra,
        vertical: AppConstant.kSpaceVerticalSmallExtra,
      ),
      decoration: BoxDecoration(
          color: value == valueSelected ? AppColors.blue150 : AppColors.blue50,
          border: Border.all(
            width: value == valueSelected ? 1 : 0,
            color: AppColors.blue200,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(4.0),
          ),
          shape: BoxShape.rectangle),
      child: InkWellWidget(
        onPress: () {
          if (onPress != null) {
            onPress!(value);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value.name,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.grey),
            ),
            _CheckBoxWidget(
              value: value,
              valueSelected: valueSelected,
            )
          ],
        ),
      ),
    );
  }
}

class _CheckBoxWidget extends StatelessWidget {
  const _CheckBoxWidget({
    Key? key,
    required this.value,
    required this.valueSelected,
  }) : super(key: key);

  final EPeriodTime value;
  final EPeriodTime valueSelected;

  @override
  Widget build(BuildContext context) {
    if (value == valueSelected) {
      return const Icon(
        Icons.check,
        color: AppColors.blue,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _DateInfoWidget extends StatelessWidget {
  const _DateInfoWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColors.grey),
        ),
        AppConstant.spaceHorizontalSmall,
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstant.kSpaceHorizontalSmallExtraExtra,
            vertical: AppConstant.kSpaceVerticalSmallExtra,
          ),
          decoration: const BoxDecoration(
            color: AppColors.blue50,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            children: [
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.grey),
              ),
              AppConstant.spaceHorizontalSmall,
              Image.asset(AppResource.icCalendar)
            ],
          ),
        )
      ],
    );
  }
}
