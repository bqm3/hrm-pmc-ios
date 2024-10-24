import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';

void showViewDialog(BuildContext context, Widget child) {
  Dialog dialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    insetPadding: EdgeInsets.symmetric(
      horizontal: AppConstant.kSpaceHorizontalSmallExtraExtraExtra,
    ),
    child: child,
  );
  showDialog(context: context, builder: (context) => dialog);
}
