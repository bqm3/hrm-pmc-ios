import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  final Color? color;
  const BackButtonWidget({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_outlined,
        color: color ?? Color.fromRGBO(76, 158, 235, 1.0),
        size: 15.sp,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}
