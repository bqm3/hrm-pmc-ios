import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showSuccessToast(String message) {
  Get.snackbar(
    "Thông báo",
    message,
    backgroundColor: Colors.green,
    duration: const Duration(seconds: 3),
    colorText: Colors.white,
    icon: const Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 30.0,
    ),
  );
}

void showErrorToast(String message, {int? second}) {
  Get.snackbar(
    "Báo lỗi",
    message,
    backgroundColor: AppColors.red,
    duration: Duration(seconds: second ?? 3),
    colorText: Colors.white,
    icon: const Icon(
      Icons.highlight_off,
      color: Colors.white,
      size: 30.0,
    ),
  );
}

void showWarningToast(String message) {
  Get.snackbar(
    "Cảnh báo",
    message,
    backgroundColor: Colors.orange,
    duration: const Duration(seconds: 3),
    colorText: Colors.white,
    icon: const Icon(
      Icons.info_outlined,
      color: Colors.white,
      size: 30.0,
    ),
  );
}
