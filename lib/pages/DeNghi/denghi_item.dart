import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class DeNghiItemView extends StatefulWidget {
  final String? ngay;
  final String? noiDung;
  final double? soTien;
  final String? thoiGian;
  final String? lyDo;
  final String? tenTinhTrang;
  final String? tenNs;
  final String? tenDv;
  final String? tenPb;
  final String? ten;
  final int? id;
  final int? tinhTrang;
  final Function(int)? onDismissed;
  final Function? onReload;

  const DeNghiItemView({
    Key? key,
    this.ngay,
    this.lyDo,
    this.id,
    this.tinhTrang,
    this.noiDung,
    this.soTien,
    this.thoiGian,
    this.tenTinhTrang,
    this.tenNs,
    this.tenDv,
    this.tenPb,
    this.ten,
    this.onDismissed,
    this.onReload,
  }) : super(key: key);

  @override
  _DeNghiItemViewState createState() => _DeNghiItemViewState();
}

class _DeNghiItemViewState extends State<DeNghiItemView> {
  bool _isExpanded = false;
  bool _isDismissed = false;
  double _offset = 0.0;
  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String formatDate2(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('HH:mm dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  Future<Map<String, dynamic>> _cancelDeNghi(int id) async {
    final response = await http.delete(
      Uri.parse('https://apihrm.pmcweb.vn/api/NhanSuDN/Delete?Id=$id'),
      headers: {'accept': '*/*'},
    );
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Huỷ đề nghị thành công.',
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
          content: Text('Bạn có chắc chắn muốn hủy đề nghị không?'),
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
                final result = await _cancelDeNghi(widget.id!);
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

  @override
  Widget build(BuildContext context) {
    Color tinhTrangColor;
    String tinhTrangText;
    bool isChecked;

    switch (widget.tinhTrang) {
      case 0:
        tinhTrangColor = Colors.grey;
        tinhTrangText = 'Chờ duyệt';
        isChecked = true;
        break;
      case 1:
        tinhTrangColor = Colors.green;
        tinhTrangText = 'Đã duyệt';
        isChecked = false;
        break;
      case 2:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không duyệt';
        isChecked = false;
        break;
      default:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không xác định';
        isChecked = false;
    }

    return GestureDetector(
      onHorizontalDragUpdate: isChecked
          ? (details) {
              setState(() {
                _offset += details.delta.dx;
                if (_offset < -100) {
                  _offset = -100;
                }
              });
            }
          : null,
      onHorizontalDragEnd: isChecked
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.ten ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
                                    color: AppColors.approved,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Text(
                                      'Nội dung: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.noiDung ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Text(
                                      'Lý do: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.lyDo ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Row(
                                  children: [
                                    Text(
                                      'Ngày: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        formatDate(widget.thoiGian),
                                        style: TextStyle(
                                          fontFamily: 'Arimo',
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Text(
                                  formatDate2(widget.ngay),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontSize: 12,
                                        height: 1.4,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
