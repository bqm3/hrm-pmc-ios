import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

class DaoTaoItemView extends StatefulWidget {
  final String? lopDt;
  final int? id;
  final String? ngay;
  final String? thoiGian;
  final String? moTa;
  final String? taiLieu;
  final String? mact;
  final String? tenct;
  final String? madv;
  final String? tendv;
  final int? tinhTrang;

  DaoTaoItemView({
    Key? key,
    this.lopDt,
    this.ngay,
    this.id,
    this.thoiGian,
    this.moTa,
    this.taiLieu,
    this.mact,
    this.tenct,
    this.madv,
    this.tendv,
    this.tinhTrang,
  }) : super(key: key);

  @override
  _DaoTaoItemViewState createState() => _DaoTaoItemViewState();
}

class _DaoTaoItemViewState extends State<DaoTaoItemView> {
  bool _isExpanded = false;

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

  @override
  Widget build(BuildContext context) {
    Color tinhTrangColor;
    String tinhTrangText;

    switch (widget.tinhTrang) {
      case 0:
        tinhTrangColor = Colors.grey;
        tinhTrangText = 'Chưa hoàn thành';
        break;
      case 1:
        tinhTrangColor = Colors.green;
        tinhTrangText = 'Đã hoàn thành';
        break;
      case 2:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không hoàn thành';
        break;
      default:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không xác định';
    }
    return Card(
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
                Expanded(
                  flex: 6,
                  child: Text(
                    widget.tenct ?? '',
                    style: TextStyle(
                      fontFamily: 'Arimo',
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 4,
                  child: Container(
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
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                widget.thoiGian ?? '',
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Mô tả: ',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.moTa ?? '',
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Tài liệu: ',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.taiLieu ?? '',
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
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        formatDate(widget.ngay),
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
