import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/API/provider/loainghi_provider.dart';
import 'package:salesoft_hrm/API/repository/loainghi_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/calamviec2_model.dart';
import 'package:salesoft_hrm/model/loainghi_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class ManyDayDialog extends StatefulWidget {
  final TextEditingController tuNgayController;
  final TextEditingController denNgayController;
  final TextEditingController oldShiftController;
  final CaLamViec3? selectedOldShift;
  final List<CaLamViec3> oldShiftOptions;

  ManyDayDialog({
    required this.tuNgayController,
    required this.denNgayController,
    required this.oldShiftController,
    required this.selectedOldShift,
    required this.oldShiftOptions,
  });

  @override
  _ManyDayDialogState createState() => _ManyDayDialogState();
}

class _ManyDayDialogState extends State<ManyDayDialog> {
  List<LoaiNghi> _loaiNghiList = [];
  List<String> _daysList = [];
  LoaiNghi? _selectedLoaiNghi;
  CaLamViec3? selectedOldShift;
  TextEditingController _lyDoController = TextEditingController();
  double _tongSoNgayPhep = 0.0;
  double _soNgayConLai = 0.0;
  bool _isExpanded = false;
  List<double> _selectedValues = [];
  String? selectedValue;
  double phepNamTruoc = 0.0;
  double phepThamNien = 0.0;
  double phepDaNghi = 0.0;
  double phepDuocNghi = 0.0;
  bool _obscureText = true;

  Future<void> fetchSoNgayPhep() async {
    String ma = await AuthService().ma ?? '';
    final url =
        Uri.parse('https://apihrm.pmcweb.vn/api/NghiPhep/TinhNghiPhep?Ma=$ma');

    try {
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Response data: $data');

        double phepNamTruoc = (data['phepNamTruoc'] as num).toDouble();
        double phepThamNien = (data['phepThamNien'] as num).toDouble();
        double phepDuocNghi = (data['phepDuocNghi'] as num).toDouble();
        double phepDaNghi = (data['phepDaNghi'] as num).toDouble();

        print('phepNamTruoc: $phepNamTruoc');
        print('phepThamNien: $phepThamNien');
        print('phepDuocNghi: $phepDuocNghi');
        print('phepDaNghi: $phepDaNghi');

        setState(() {
          this.phepNamTruoc = (data['phepNamTruoc'] as num).toDouble();
          this.phepThamNien = (data['phepThamNien'] as num).toDouble();
          this.phepDuocNghi = (data['phepDuocNghi'] as num).toDouble();
          this.phepDaNghi = (data['phepDaNghi'] as num).toDouble();
          _tongSoNgayPhep = phepNamTruoc + phepThamNien + phepDuocNghi;
          _soNgayConLai = _tongSoNgayPhep - phepDaNghi;

          if (_soNgayConLai < 0) {
            _soNgayConLai = 0;
          }
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');

        Get.dialog(
          thongBaoDialog2(
              text:
                  'Lấy thông tin số ngày phép thất bại. Mã lỗi: ${response.statusCode}'),
        );
      }
    } catch (e) {
      print('Exception: $e');

      Get.dialog(
        thongBaoDialog2(text: 'Lỗi kết nối đến server'),
      );
    }
  }

  void updateDaysList() {
    DateTime startDate =
        DateFormat('yyyy/MM/dd').parse(widget.tuNgayController.text);
    DateTime endDate =
        DateFormat('yyyy/MM/dd').parse(widget.denNgayController.text);
    _daysList = List.generate(
        endDate.difference(startDate).inDays + 1,
        (index) => DateFormat('yyyy/MM/dd')
            .format(startDate.add(Duration(days: index))));

    _selectedValues = List.filled(_daysList.length, 1.0);
  }

  @override
  void initState() {
    super.initState();
    fetchSoNgayPhep();
    if (widget.oldShiftOptions.isNotEmpty) {
      selectedOldShift = widget.oldShiftOptions.first;
      widget.oldShiftController.text = selectedOldShift?.ten ?? '';
    }
    _selectedValues = List.filled(_daysList.length, 1.0);
  }

  @override
  void dispose() {
    _lyDoController.dispose();
    super.dispose();
  }

  Future<void> sendRequest() async {
    List<double> dropdownValues = [];
    for (var value in _selectedValues) {
      dropdownValues.add(value);
    }
    String loaiNghi = _selectedLoaiNghi?.ma ?? '';
    String ma = await AuthService().ma ?? '';
    String ngayDangKy = DateFormat('yyyy/MM/dd').format(DateTime.now());
    String tuNgay = widget.tuNgayController.text;
    String denNgay = widget.denNgayController.text;
    DateFormat('yyyy/MM/dd').parse(tuNgay);
    DateFormat('yyyy/MM/dd').parse(denNgay);
    double soLuong = dropdownValues.reduce((a, b) => a + b);
    print("Tổng dropdownValues: $soLuong");

    String lyDo = _lyDoController.text;
    int soLuongCaLamViec = (selectedOldShift?.soLuong ?? 0).toInt();

    List<double> bodyValues = dropdownValues;

    final url = Uri.parse(
        'https://apihrm.pmcweb.vn/api/NghiPhep/DangKyNghi?LoaiNghi=AL&Ma=$ma&NgayDangKy=$ngayDangKy&TuNgay=$tuNgay&DenNgay=$denNgay&SoLuong=$soLuong&LyDo=$lyDo');

    final response = await http.post(
      url,
      headers: {
        'Accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: json.encode(bodyValues),
    );

    print("Thông tin nhập vào:");
    print(bodyValues);
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      await fetchSoNgayPhep();

      String errorMessage2 = response.body.isNotEmpty
          ? json.decode(response.body)['message']
          : 'Đăng ký nghỉ phép thành công.';

      Future.delayed(Duration(milliseconds: 100), () {
        Get.dialog(
          thongBaoDialog(text: errorMessage2),
        );
      });

      Get.find<NghiPhepController>().fetchListContent();
    } else if (response.statusCode == 400) {
      String errorMessage = response.body.isNotEmpty
          ? json.decode(response.body)['message']
          : 'Đăng ký nghỉ phép thất bại.';

      Future.delayed(Duration(milliseconds: 100), () {
        Get.dialog(
          thongBaoDialog2(text: errorMessage),
        );
      });
    } else {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      Future.delayed(Duration(milliseconds: 100), () {
        Get.dialog(
          thongBaoDialog2(text: 'Lỗi kết nối đến server'),
        );
      });
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
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Số ngày phép còn lại: ',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _soNgayConLai.toStringAsFixed(1),
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    FaIcon(
                        _isExpanded
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Colors.red,
                        size: 12.sp),
                  ],
                ),
              ),
              if (_isExpanded) ...[
                SizedBox(height: 10.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phép năm trước: ${phepNamTruoc.toStringAsFixed(1)}',
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 12.sp)),
                    Text('Phép thâm niên: ${phepThamNien.toStringAsFixed(1)}',
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 12.sp)),
                    Text('Phép được nghỉ: ${phepDuocNghi.toStringAsFixed(1)}',
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 12.sp)),
                    Text('Phép đã nghỉ: ${phepDaNghi.toStringAsFixed(1)}',
                        style: TextStyle(fontFamily: 'Arimo', fontSize: 12.sp)),
                  ],
                ),
              ],
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Từ ngày',
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
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
                                widget.tuNgayController.text = formattedDate;
                                if (widget.denNgayController.text.isNotEmpty) {
                                  DateTime denNgay = DateFormat('yyyy/MM/dd')
                                      .parse(widget.denNgayController.text);
                                  if (pickedDate.isAfter(denNgay)) {
                                    widget.denNgayController.clear();
                                  }
                                }
                              });
                            }
                            if (widget.tuNgayController.text.isNotEmpty &&
                                widget.denNgayController.text.isNotEmpty) {
                              updateDaysList();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0.w, vertical: 1.0.h),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: TextField(
                                    controller: widget.tuNgayController,
                                    style: const TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
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
                                  flex: 2,
                                  child: FaIcon(FontAwesomeIcons.calendar),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Đến ngày',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.h),
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
                                  widget.denNgayController.text = formattedDate;
                                  if (widget.tuNgayController.text.isNotEmpty) {
                                    DateTime tuNgay = DateFormat('yyyy/MM/dd')
                                        .parse(widget.tuNgayController.text);
                                    if (pickedDate.isBefore(tuNgay)) {
                                      widget.tuNgayController.clear();
                                    }
                                  }
                                });
                              }
                              if (widget.tuNgayController.text.isNotEmpty &&
                                  widget.denNgayController.text.isNotEmpty) {
                                updateDaysList();
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w, vertical: 1.0.h),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: TextField(
                                      controller: widget.denNgayController,
                                      style: const TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
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
                                    flex: 2,
                                    child: FaIcon(FontAwesomeIcons.calendar),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              SizedBox(height: 12.h),
              if (_daysList.isNotEmpty && _selectedValues.isNotEmpty)
                Column(
                  children: _daysList
                      .asMap()
                      .map((index, day) {
                        return MapEntry(
                          index,
                          Row(
                            children: [
                              Text(day),
                              SizedBox(width: 20.w),
                              DropdownButton<double>(
                                value: _selectedValues[index],
                                items: const [
                                  DropdownMenuItem(
                                    value: 1.0,
                                    child: Text('1.0'),
                                  ),
                                  DropdownMenuItem(
                                    value: 0.5,
                                    child: Text('0.5'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValues[index] = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
              Text(
                'Lý do',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 1.0.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _lyDoController,
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập lý do...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Arimo',
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 9.h),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.w, vertical: 9.h),
                      color: AppColors.blueVNPT,
                      borderRadius: BorderRadius.circular(10.0.r),
                      onPressed: () async {
                        await sendRequest();
                        Navigator.of(context).pop();
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
