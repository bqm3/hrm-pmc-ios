import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

class TextThemeApp {
  static final textTheme = TextTheme(
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      fontFamily: "Roboto",
    ),
    bodyLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.normal,
      fontFamily: "Roboto", 
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      fontFamily: "Roboto",
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      fontFamily: "Roboto",
    ),
    titleSmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      fontFamily: "Roboto",
    ),
    headlineSmall: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.normal,
      fontFamily: "Roboto",
    ),
  );

  static Widget wdgTitle(String title, {isRequired = true}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.blue,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          isRequired == true
              ? Text(
                  " (*)",
                  style: TextStyle(
                    color: Colors.red[700],
                    fontWeight: FontWeight.normal,
                    fontSize: 13.sp,
                  ),
                )
              : const SizedBox(height: 0),
        ],
      ),
    );
  }
}
