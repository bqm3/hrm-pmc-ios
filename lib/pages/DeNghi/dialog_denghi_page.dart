import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/provider/loaidenghi_provider.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/loaidenghi_model.dart';
import 'package:salesoft_hrm/pages/DeNghi/denghi_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class DeNghiDialog extends StatefulWidget {
  final TextEditingController dateController;

  DeNghiDialog({
    required this.dateController,
  });

  @override
  _DeNghiDialogState createState() => _DeNghiDialogState();
}

class _DeNghiDialogState extends State<DeNghiDialog> {
  final TextEditingController _noiDungController = TextEditingController();
  final TextEditingController _soTienController = TextEditingController();
  final TextEditingController _lyDoController = TextEditingController();
  final TextEditingController _thoiGianController = TextEditingController();
  LoaiDeNghi? _selectedLoai;
  List<LoaiDeNghi> _loaiOptions = [];
  bool _thoiGianError = false;
  bool _noiDungError = false;

  @override
  void initState() {
    super.initState();
    _loadLoaiOptions();
  }

  Future<void> _loadLoaiOptions() async {
    try {
      List<LoaiDeNghi> loaiDeNghiList = await fetchLoaiDeNghi();
      setState(() {
        _loaiOptions.clear();
        _loaiOptions.addAll(loaiDeNghiList);
        if (_loaiOptions.isNotEmpty) {
          _selectedLoai = _loaiOptions[0];
        }
      });
    } catch (e) {
      print('Error loading LoaiDeNghi: $e');
    }
  }

  @override
  void dispose() {
    _lyDoController.dispose();
    super.dispose();
  }

  Future<void> sendRequest() async {
    String xetDuyet = _selectedLoai?.ma ?? '';
    String ma = await AuthService().ma ?? '';
    String thoiGian = widget.dateController.text;
    String lyDo = _lyDoController.text;
    String noiDung = _noiDungController.text;
    String soTien = _soTienController.text;

    setState(() {
      _thoiGianError = thoiGian.isEmpty;
      _noiDungError = noiDung.isEmpty;
    });

    if (_thoiGianError || _noiDungError) {
      return;
    }

    final url = Uri.parse(
        'https://apihrm.pmcweb.vn/api/NhanSuDN/Create?XetDuyet=$xetDuyet&Ma=$ma&NoiDung=$noiDung&SoTien=$soTien&ThoiGian=$thoiGian&LyDo=$lyDo');

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
          text: responseData['message'] ?? 'Thêm mới thành công',
        ),
      );
      Get.find<DeNghiController>().fetchListContent();
    } else {
      final responseData = json.decode(response.body);
      Get.dialog(
        thongBaoDialog2(
          text: responseData['message'] ?? 'Thêm mới thành công',
        ),
      );
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
                'Loại đề nghị',
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
                child: DropdownButton<LoaiDeNghi>(
                  value: _selectedLoai,
                  isExpanded: true,
                  underline: Container(),
                  items: _loaiOptions
                      .map((loai) => DropdownMenuItem<LoaiDeNghi>(
                            value: loai,
                            child: Text(
                              loai.ten ?? '',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (LoaiDeNghi? newValue) {
                    setState(() {
                      _selectedLoai = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Nội dung',
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
                      controller: _noiDungController,
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nhập nội dung...',
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
                        'Vui lòng nhập nội dung.',
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
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
              SizedBox(height: 12.sp),
              Text(
                'Thời gian',
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
                        firstDate: DateTime(2000),
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
