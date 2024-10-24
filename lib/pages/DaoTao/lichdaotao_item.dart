import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/pages/DaoTao/lichdaotao_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class LichDaoTaoItemView extends StatefulWidget {
  final String? ma;
  final int? id;
  final String? ten;
  final String? donVi;
  final String? phongBan;
  final String? toCongTac;
  final String? chucDanh;
  final String? tendv;
  final String? tencd;
  final String? tenpb;
  final String? tentct;
  final String? ngay;
  final String? denNgay;
  final String? mact;
  final String? tenct;
  final String? madv;
  final String? tennd;
  final int? sotv;
  final String? tenTinhTrang;
  final String? idtb;
  final int? tinhTrang;

  LichDaoTaoItemView({
    Key? key,
    this.id,
    this.ma,
    this.ten,
    this.donVi,
    this.phongBan,
    this.toCongTac,
    this.chucDanh,
    this.tendv,
    this.tencd,
    this.tenpb,
    this.tentct,
    this.ngay,
    this.tennd,
    this.denNgay,
    this.mact,
    this.tenct,
    this.madv,
    this.sotv,
    this.tenTinhTrang,
    this.tinhTrang,
    this.idtb,
  }) : super(key: key);

  @override
  _LichDaoTaoItemViewState createState() => _LichDaoTaoItemViewState();
}

class _LichDaoTaoItemViewState extends State<LichDaoTaoItemView> {
  double _offset = 0.0;
  bool isChecked = true;
  final controller2 = Get.put(LichDaoTaoController());

  String formatDate(String? dateStr) {
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
    final response = await http.post(
      Uri.parse('https://apihrm.pmcweb.vn/api/DaoTao/Delete?Id=$id'),
      headers: {'accept': '*/*'},
    );
    if (response.statusCode == 200) {
      return {
        'success': true,
        'message': 'Đã tạo đề nghị huỷ đăng ký lớp học',
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
    print(widget.id);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn hủy đăng ký đào tạo không?'),
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
                  controller2.fetchListContent();
                  Get.dialog(
                    thongBaoDialog(
                      text: result['message'],
                    ),
                  );
                  setState(() {
                    _offset = 0;
                  });
                } else {
                  Get.dialog(
                    thongBaoDialog2(
                      text: result['message'],
                    ),
                  );
                  setState(() {
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

    switch (widget.tinhTrang) {
      case 1:
        tinhTrangColor = Colors.grey;
        tinhTrangText = 'Mới đăng ký';
        break;
      case 2:
        tinhTrangColor = Colors.green;
        tinhTrangText = 'Đã xếp lớp';
        break;
      case 3:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không duyệt';
        break;
      case 4:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Đã huỷ';
      case 5:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Chờ xử lý';
        break;
      default:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không xác định';
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
      child: Stack(children: [
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
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 8.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0.r),
            ),
            elevation: 1.5,
            child: InkWell(
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      SizedBox(width: 7.w),
                      Text(
                        widget.ten ?? '',
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Colors.red,
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
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
                              fontSize: 11.sp,
                              fontFamily: 'Arimo',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Đơn vị: ',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.tendv ?? '',
                                      // '${formatDate(widget.tuNgay)} - ${formatDate(widget.denNgay)}',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              Row(
                                children: [
                                  Text(
                                    'Phòng ban: ',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.tenpb ?? '',
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
                                      widget.tennd ?? '',
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
                                    'Thời gian: ',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${formatDate(widget.ngay)}',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
