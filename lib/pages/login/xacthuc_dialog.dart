import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/login/mkmoi_dialog.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class XacThucDialog extends StatefulWidget {
  final String maNhanSu;

  final Map<String, dynamic> data;
  XacThucDialog({required this.data, required this.maNhanSu});

  @override
  _XacThucDialogState createState() => _XacThucDialogState();
}

class _XacThucDialogState extends State<XacThucDialog> {
  final TextEditingController _sodtController = TextEditingController();
  final TextEditingController _cmtController = TextEditingController();
  final TextEditingController _phongbanController = TextEditingController();
  final TextEditingController _donviController = TextEditingController();

  bool _sodtError = false;
  bool _cmtError = false;
  bool _phongbanError = false;
  bool _donviError = false;
  void _onConfirm() {
    if (_sodtController.text == widget.data['dienThoai'] &&
        _cmtController.text == widget.data['cmt']) {
      Navigator.of(context).pop();

      _showFormDialog();
    } else {
      Get.dialog(
        thongBaoDialog2(text:'Thông tin không hợp lệ'),
      );
    }
  }

  void _clearTextFields() {
    _sodtController.clear();
    _cmtController.clear();
    _phongbanController.clear();
    _donviController.clear();
  }

  Future<void> _showFormDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MKMoiDialog(maNhanSu: widget.maNhanSu);
      },
    );
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
              Text(
                'Xác thực nhân sự',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Số điện thoại',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _sodtError ? Colors.red : Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _sodtController,
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập số điện thoại...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Arimo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  if (_sodtError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Vui lòng nhập số điện thoại.',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'CCCD/CMND',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _cmtError ? Colors.red : Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _cmtController,
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập CCCD/CMND...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Arimo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  if (_cmtError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Vui lòng nhập CCCD/CMND.',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 0.7),
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: CupertinoButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0.r),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Quay lại',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: CupertinoButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: AppColors.blueVNPT,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () async {
                        _onConfirm();
                      },
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
