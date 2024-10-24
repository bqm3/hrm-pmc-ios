import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/model/calamviec2_model.dart';
import 'package:salesoft_hrm/pages/DoiCa/doica_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class DoiCaItemView extends StatefulWidget {
  final String? caCu;
  final String? thoiGian;
  final String? caMoi;
  final String? tenCaCu;
  final String? tenCaMoi;
  final int? tinhtrang;
  final int? id;
  final Function(int)? onDismissed;
  final Function? onReload;

  const DoiCaItemView({
    Key? key,
    this.caCu,
    this.thoiGian,
    this.caMoi,
    this.tenCaCu,
    this.tenCaMoi,
    this.tinhtrang,
    this.id,
    this.onDismissed,
    this.onReload,
  }) : super(key: key);

  @override
  _DoiCaItemViewState createState() => _DoiCaItemViewState();
}

class _DoiCaItemViewState extends State<DoiCaItemView> {
  final DoiCaController controller = Get.put(DoiCaController());
  bool _isDismissed = false;
  double _offset = 0.0;

  TextEditingController dateController = TextEditingController();
  TextEditingController oldShiftController = TextEditingController();
  TextEditingController newShiftController = TextEditingController();

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return date ?? '';
    }
  }

  Future<Map<String, dynamic>> _cancelDoiCa(int id) async {
    final response = await http.delete(
      Uri.parse('https://apihrm.pmcweb.vn/api/DoiCa?Id=$id'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Huỷ đổi ca thành công.',
      };
    } else {
      final errorMessage =
          json.decode(response.body)['message'] ?? 'Có lỗi từ server.';
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn hủy đăng ký đổi ca không?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Hủy'),
              onPressed: () {
                setState(() {
                  _offset = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Xác nhận'),
              onPressed: () async {
                Navigator.of(context).pop();
                final result = await _cancelDoiCa(widget.id!);
                if (result['success']) {
                  Get.dialog(
                    thongBaoDialog(
                      text: result['message'],
                    ),
                  );
                  setState(() {
                    _isDismissed = true;
                    _offset = 0;
                  });
                  widget.onDismissed?.call(widget.id!);
                  widget.onReload?.call();
                } else {
                  Get.dialog(
                    thongBaoDialog2(
                      text: result['message'],
                    ),
                  );
                  setState(() {
                    _isDismissed = true;
                    _offset = 0;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showFormDialog() {
    oldShiftController.text = widget.tenCaMoi ?? '';
    newShiftController.text = widget.tenCaMoi ?? '';
    dateController.text = _formatDate(widget.thoiGian);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          dateController: dateController,
          oldShiftController: oldShiftController,
          newShiftController: newShiftController,
          newShiftOptions: controller.newShiftOptions,
          thoiGian: widget.thoiGian,
          caMoi: widget.caMoi ?? '',
          id: widget.id ?? 0,
          onReload: widget.onReload,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color tinhTrangColor;
    String tinhTrangText;
    bool isClick;
    switch (widget.tinhtrang) {
      case 0:
        tinhTrangColor = Colors.grey;
        tinhTrangText = 'Mới tạo';
        isClick = true;
        break;
      case 1:
        tinhTrangColor = Colors.green;
        tinhTrangText = 'Đã duyệt';
        isClick = false;
        break;
      case 2:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không duyệt';
        isClick = false;
        break;
      default:
        tinhTrangColor = Colors.red;
        isClick = false;
        tinhTrangText = 'Không xác định';
    }
    void _handleTap() {
      if (isClick) {
        _showFormDialog();
      } else {
        Get.dialog(
          thongBaoDialog2(
            text: 'Không thể xoá/sửa ca $tinhTrangText',
          ),
        );
      }
    }

    return GestureDetector(
      onTap: _handleTap,
      onHorizontalDragUpdate: isClick
          ? (details) {
              setState(() {
                _offset += details.delta.dx;
                if (_offset < -100) {
                  _offset = -100;
                }
              });
            }
          : null,
      onHorizontalDragEnd: isClick
          ? (details) {
              if (_offset < -1) {
                _showCancelDialog();
              } else {
                setState(() {
                  _offset = 0;
                });
              }
            }
          : null,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: _offset < -100 ? Colors.red : Colors.transparent,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.red),
            ),
          ),
          Transform.translate(
            offset: Offset(_offset, 0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 16.w),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Thời gian:',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      _formatDate(
                                        widget.thoiGian,
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 16.w),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Ca cũ:',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.tenCaCu ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 16.w),
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      'Ca mới:',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                const Spacer(),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.tenCaMoi ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: tinhTrangColor.withOpacity(0.1),
                            border: Border.all(
                              color: tinhTrangColor,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              tinhTrangText,
                              style: TextStyle(
                                color: tinhTrangColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                fontFamily: 'Arimo',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  final TextEditingController dateController;
  final TextEditingController oldShiftController;
  final TextEditingController newShiftController;
  final String caMoi;
  final int id;
  final List<CaLamViec2> newShiftOptions;
  final String? thoiGian;
  final Function? onReload;

  CustomDialog({
    required this.dateController,
    required this.oldShiftController,
    required this.newShiftController,
    required this.newShiftOptions,
    required this.caMoi,
    required this.thoiGian,
    required this.id,
    this.onReload,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  CaLamViec2? selectedNewShift;

  @override
  void initState() {
    super.initState();
    selectedNewShift =
        widget.newShiftOptions.isNotEmpty ? widget.newShiftOptions.first : null;
    widget.dateController.text = _formatDate(widget.thoiGian!);
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('yyyy/MM/dd').format(dateTime);
    } catch (e) {
      return date ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.h),
              const Text(
                'Ngày đăng ký',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 14,
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextField(
                        controller: widget.dateController,
                        style: const TextStyle(
                          fontFamily: 'Arimo',
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: FaIcon(FontAwesomeIcons.calendar),
                        onPressed: () async {
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
                            widget.dateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              const Text(
                'Ca cũ',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 14,
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
                  controller: widget.oldShiftController,
                  style: const TextStyle(
                    fontFamily: 'Arimo',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              const Text(
                'Ca mới',
                style: TextStyle(
                  fontFamily: 'Arimo',
                  fontSize: 14,
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
                child: DropdownButton<CaLamViec2>(
                  value: selectedNewShift,
                  isExpanded: true,
                  underline: Container(),
                  onChanged: (CaLamViec2? newValue) {
                    setState(() {
                      selectedNewShift = newValue;
                    });
                  },
                  items: widget.newShiftOptions
                      .map<DropdownMenuItem<CaLamViec2>>((CaLamViec2 value) {
                    return DropdownMenuItem<CaLamViec2>(
                      value: value,
                      child: Text(value.ten),
                    );
                  }).toList(),
                ),
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: CupertinoButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Quay lại',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
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
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      color: AppColors.blueVNPT,
                      borderRadius: BorderRadius.circular(10.0),
                      onPressed: () async {
                        int id = widget.id;
                        final authService = Get.find<AuthService>();
                        String ma = await authService.ma ?? '';
                        String ngay = widget.dateController.text;
                        String caCu = widget.caMoi;
                        String caMoi = selectedNewShift?.ma ?? '';
                        final response = await http.put(
                          Uri.parse(
                              'https://apihrm.pmcweb.vn/api/DoiCa?Id=$id&Ma=$ma&Ngay=$ngay&CaCu=$caCu&CaMoi=$caMoi'),
                          headers: {'accept': '*/*'},
                        );

                        if (response.statusCode == 200) {
                          final data = jsonDecode(response.body);
                          Get.dialog(
                            thongBaoDialog(
                              text: 'Cập nhật đổi ca thành công',
                            ),
                          );
                          widget.onReload?.call();

                          Navigator.of(context).pop();
                        } else {
                          final errorResponse = jsonDecode(response.body);
                          String errorMessage =
                              errorResponse['message'] ?? 'Có lỗi từ server.';
                          Get.dialog(
                            thongBaoDialog2(
                              text: errorMessage,
                            ),
                          );
                        }
                      },
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
