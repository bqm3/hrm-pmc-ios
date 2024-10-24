import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
class thongBaoDialog extends StatefulWidget {
  final String text; 

  thongBaoDialog({required this.text}); 

  @override
  _thongBaoDialogState createState() => _thongBaoDialogState();
}

class _thongBaoDialogState extends State<thongBaoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,  
          mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,  
              children: [
                Container(
                  width: 55.w,
                  height: 55.w,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.asset(
                    AppResource.icCheckOne,
                    width: 50.w,
                    height: 50.w,
                  ),
                ),
                SizedBox(width: 10.w), 
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      Text(
                        'Thông báo',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ), 
                      ),
                      SizedBox(height: 8.h), 
                      Text(
                        widget.text,
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                color: AppColors.blueVNPT,
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
