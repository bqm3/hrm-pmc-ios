import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';

class EmptyDataWidget extends StatelessWidget {
  final Function() onReloadData;
  final String? msg;

  const EmptyDataWidget({
    Key? key,
    required this.onReloadData,
    this.msg = 'Không có dữ liệu',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onPress: onReloadData,
      child: Align(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppResource.icNoTranc,
              width: 50,
              height: 50,
            ),
            AppConstant.spaceVerticalSmallExtra,
            Text(
              msg ?? 'Không có dữ liệu',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.grey300,
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
