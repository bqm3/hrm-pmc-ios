import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/provider/nghiphep_detail_provider.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_controller.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_detail_page.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class ListNghiPhepItemView extends StatefulWidget {
  final String? loaiNghi;
  final int? tinhTrang;
  final String? soLuong;
  final String? tuNgay;
  final int? filterTinhTrang;
  final int? id;
  final String? denNgay;

  const ListNghiPhepItemView({
    Key? key,
    this.loaiNghi,
    this.tinhTrang,
    this.soLuong,
    this.tuNgay,
    this.filterTinhTrang,
    this.denNgay,
    this.id,
  }) : super(key: key);

  @override
  _ListNghiPhepItemViewState createState() => _ListNghiPhepItemViewState();
}

class _ListNghiPhepItemViewState extends State<ListNghiPhepItemView> {
  bool _isExpanded = false;
  bool _isDismissed = false;
  double _offset = 0.0;
  final controller = Get.put(NghiPhepController());
  Map<String, dynamic>? _detailNghiPhep;

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

  String formatSoLuong(String? soLuong) {
    if (soLuong == null || soLuong.isEmpty) {
      return '';
    }
    try {
      final double value = double.parse(soLuong);
      if (value == value.toInt()) {
        return value.toInt().toString();
      }
      return value.toString();
    } catch (e) {
      return soLuong;
    }
  }

  Future<void> _deleteNghiPhep(int id) async {
    final response = await http.delete(
      Uri.parse('https://apihrm.pmcweb.vn/api/NghiPhep/HuyNghiPhep?Id=$id'),
      headers: {'accept': '*/*'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      Future.delayed(Duration(milliseconds: 100), () {
        Get.dialog(
          thongBaoDialog(
            text: jsonResponse['message'],
          ),
        );
      });
    } else if (response.statusCode == 400) {
      var jsonResponse = json.decode(response.body);
      Future.delayed(Duration(milliseconds: 100), () {
        Get.dialog(
          thongBaoDialog2(
            text: jsonResponse['message'],
          ),
        );
      });
    } else {
      Future.delayed(Duration(milliseconds: 100), () {
        Get.dialog(
          thongBaoDialog2(text: 'Lỗi kết nối đến server'),
        );
      });
    }
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn hủy ngày nghỉ này không?'),
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
                await _deleteNghiPhep(widget.id!);
                setState(() {
                  _offset = 0;
                });
                controller.fetchListContent();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchNghiPhepDetail(int id) async {
    try {
      final detailProvider = NghiPhepDetailProviderAPI();
      final detail = await detailProvider.getNghiPhepDetail(
        id: id,
        thang: controller.thang,
        nam: controller.nam,
      );

      if (detail is List && detail.isNotEmpty) {
        setState(() {
          _detailNghiPhep = detail.first;
          _isExpanded = true;
        });
        Get.to(() => NghiPhepDetailPage(
              nghiPhepDetailList: detail.cast<Map<String, dynamic>>(),
              nghiPhepDetail: {},
            ));
      } else if (detail is Map<String, dynamic>) {
        setState(() {
          _detailNghiPhep = detail;
          _isExpanded = true;
        });
        Get.to(() => NghiPhepDetailPage(
              nghiPhepDetailList: [detail],
              nghiPhepDetail: {},
            ));
      } else {
        Get.dialog(
          thongBaoDialog2(text: 'Dữ liệu không hợp lệ'),
        );
      }
    } catch (error) {
      print(error);

      Get.dialog(
        thongBaoDialog2(text: 'Lỗi kết nối đến server'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.filterTinhTrang != null &&
        widget.filterTinhTrang != widget.tinhTrang) {
      return Container();
    }
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
      onTap: () {
        if (_isExpanded) {
          setState(() {
            _isExpanded = false;
            _detailNghiPhep = null;
          });
        } else {
          _fetchNghiPhepDetail(widget.id!);
        }
      },
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
                                Row(
                                  children: [
                                    Text(
                                      'Loại nghỉ: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.loaiNghi ?? '',
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
                                      'Số lượng: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        formatSoLuong(widget.soLuong) + ' ngày',
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
                                      formatDate(widget.tuNgay),
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(' - '),
                                    Text(
                                      formatDate(widget.denNgay),
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
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
                          child: Container(
                            margin: EdgeInsets.only(top: 13.0.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: tinhTrangColor.withOpacity(0.1),
                                    border: Border.all(
                                      color: tinhTrangColor,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0.r),
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
                              ],
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
                )),
          ),
        ],
      ),
    );
  }
}
