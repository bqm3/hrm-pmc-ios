import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/ChamCong/list_chamcong_controller.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class ListChamCongItemView extends StatefulWidget {
  final String? caLamViec;
  final String? diaDiem;
  final bool? checkIn;
  final String? thoiGian;
  final String? lyDo;
  final int? id;

  const ListChamCongItemView({
    Key? key,
    this.caLamViec,
    this.diaDiem,
    this.checkIn,
    this.thoiGian,
    this.lyDo,
    this.id,
  }) : super(key: key);

  @override
  _ListChamCongItemViewState createState() => _ListChamCongItemViewState();
}

class _ListChamCongItemViewState extends State<ListChamCongItemView> {
  final ListChamCongController controller = Get.put(ListChamCongController());

  bool _isExpanded = false;
  double _offset = 0.0;

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('HH:mm:ss dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return date;
    }
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn hủy chấm công không?'),
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
                await _cancelChamCong();
                setState(() {
                  _offset = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _cancelChamCong() async {
    final String url = 'https://apihrm.pmcweb.vn/api/ChamCong/Delete';
    final response = await http.post(
      Uri.parse('$url?Id=${widget.id}&ThoiGian=${widget.thoiGian}'),
    );

    if (response.statusCode == 200) {
      Get.dialog(
        thongBaoDialog(
          text: 'Đã huỷ chấm công thành công',
        ),
      );
      print('Hủy chấm công thành công');
      controller.removeChamCong(widget.id!);
      controller.fetchListContent();
    } else {
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['message'] ?? 'Có lỗi xảy ra';

      Get.dialog(
        thongBaoDialog2(
          text: errorMessage,
        ),
      );
      setState(() {
        _offset = 0;
      });
      print('Hủy chấm công thất bại: ${response.statusCode} - $errorMessage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _offset += details.delta.dx;
          if (_offset < -100) {
            _offset = -100;
          }
        });
      },
      onHorizontalDragEnd: (details) {
        if (_offset < -1) {
          _showCancelDialog();
        } else {
          setState(() {
            _offset = 0;
          });
        }
      },
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
                                      'Ca làm việc: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.caLamViec ?? '',
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
                                      'Địa điểm: ',
                                      style: TextStyle(
                                        fontFamily: 'Arimo',
                                        color: Colors.black,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.diaDiem ?? '',
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
                                Text(
                                  widget.checkIn == true
                                      ? 'Chấm vào'
                                      : 'Chấm ra',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                ),
                                Text(
                                  _formatDate(widget.thoiGian),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
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
