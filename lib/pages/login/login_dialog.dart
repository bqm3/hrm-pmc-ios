import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/pages/login/xacthuc_dialog.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class QuenMKDialog extends StatefulWidget {
  QuenMKDialog();

  @override
  _QuenMKDialogState createState() => _QuenMKDialogState();
}

class _QuenMKDialogState extends State<QuenMKDialog> {
  final TextEditingController ma = TextEditingController();

  bool _noiDungError = false;
  Future<void> _callApi() async {
    // Declare data here
    Map<String, dynamic>? data;

    final response = await http.get(
      Uri.parse(
          'https://apihrm.pmcweb.vn/api/NhanSu/GetInfoByCode?Ma=${ma.text}'),
      headers: {'accept': 'text/plain'},
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      Navigator.of(context).pop();

      _showFormDialog(data!);

      // Get.to(() => XacThucDialog(
      //       data: data!,
      //     ));
    } else if (response.statusCode == 204) {
      Get.dialog(
        thongBaoDialog2(text: 'Mã nhân sự không tồn tại'),
      );
    } else {
      Get.dialog(
        thongBaoDialog2(text: 'Lỗi kết nối đến server'),
      );
    }
  }

  Future<void> _showFormDialog(Map<String, dynamic> data) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return XacThucDialog(
          data: data,
          maNhanSu: ma.text,
        );
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
          padding: const EdgeInsets.all(16.0),
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
                'Nhập mã nhân sự',
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
                        color: _noiDungError ? Colors.red : Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: ma,
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập mã nhân sự...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Arimo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  if (_noiDungError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Vui lòng nhập mã nhân sự.',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 20.h),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0.r),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Quay lại',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            color: Colors.black,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: AppColors.blueVNPT,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () async {
                        if (ma.text.isEmpty) {
                          setState(() {
                            _noiDungError = true;
                          });
                        } else {
                          setState(() {
                            _noiDungError = false;
                          });
                          await _callApi();
                        }
                      },
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontFamily: 'Arimo',
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
