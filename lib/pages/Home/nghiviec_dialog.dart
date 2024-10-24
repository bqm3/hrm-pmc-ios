import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class NghiViecDialog extends StatefulWidget {
  final TextEditingController dateController;

  NghiViecDialog({
    required this.dateController,
  });

  @override
  _NghiViecDialogState createState() => _NghiViecDialogState();
}

class _NghiViecDialogState extends State<NghiViecDialog> {
  final TextEditingController _moTaController = TextEditingController();
  final TextEditingController _lyDoController = TextEditingController();
  final TextEditingController _thoiGianController = TextEditingController();
  bool _thoiGianError = false;
  bool _lyDoError = false;

  @override
  void dispose() {
    _lyDoController.dispose();
    _moTaController.dispose();
    super.dispose();
  }

  Future<void> sendRequest() async {
    String ma = await AuthService().ma ?? '';
    String thoiGian = widget.dateController.text;
    String lyDo = _lyDoController.text;
    String moTa = _moTaController.text;
    String ngayNghi = DateFormat('yyyy/MM/dd').format(DateTime.now());
    setState(() {
      _thoiGianError = thoiGian.isEmpty;
      _lyDoError = lyDo.isEmpty;
    });

    if (_thoiGianError || _lyDoError) {
      return;
    }

    final url = Uri.parse(
        'https://apihrm.pmcweb.vn/api/NhanSuNV/Create?Ma=$ma&NgayNghi=$ngayNghi&NgayXinNghi=$thoiGian&LyDo=$lyDo&MoTa=$moTa');

    final response = await http.post(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Navigator.of(context).pop();
      Get.dialog(
        thongBaoDialog(
          text: responseData['message'] ?? 'Đăng ký nghỉ việc thành công',
        ),
      );
    } else {
      final responseData = json.decode(response.body);

      Get.dialog(
        thongBaoDialog2(
          text: responseData['message'] ?? 'Lỗi kết nối đến server.',
        ),
      );
      print(responseData['message']);
    }
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
                'Từ ngày',
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
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light(),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy/MM/dd').format(pickedDate);
                        setState(() {
                          widget.dateController.text = formattedDate;
                          _thoiGianError = false;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _thoiGianError ? Colors.red : Colors.grey,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: TextField(
                              controller: widget.dateController,
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              enabled: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: 'Arimo',
                                ),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: FaIcon(FontAwesomeIcons.calendar),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_thoiGianError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Vui lòng nhập thời gian.',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Lý do',
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
                        color: _lyDoError ? Colors.red : Colors.grey,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _lyDoController,
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập lý do...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Arimo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  if (_lyDoError)
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Vui lòng nhập lý do.',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Mô tả',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0.r),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _moTaController,
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập mô tả...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Arimo',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
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
                        await sendRequest();
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
