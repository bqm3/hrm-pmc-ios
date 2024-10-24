import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

class DaDuyetItemView extends StatefulWidget {
  final String? loai;
  final int? id;
  final String? ngay;
  final String? dieuKien;
  final String? noiDung;
  final String? capDuyet;
  final String? nguoiDuyet;
  final bool? tinhTrang;

  DaDuyetItemView({
    Key? key,
    this.loai,
    this.ngay,
    this.id,
    this.dieuKien,
    this.tinhTrang,
    this.nguoiDuyet,
    this.noiDung,
    this.capDuyet,
  }) : super(key: key);

  @override
  _DaDuyetItemViewState createState() => _DaDuyetItemViewState();
}

class _DaDuyetItemViewState extends State<DaDuyetItemView> {
  bool _isExpanded = false;

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

  @override
  Widget build(BuildContext context) {
    Color tinhTrangColor;
    String tinhTrangText;

    if (widget.tinhTrang == null) {
      tinhTrangColor = Colors.red;
      tinhTrangText = 'Không xác định';
    } else if (widget.tinhTrang!) {
      tinhTrangColor = Colors.green;
      tinhTrangText = 'Đã duyệt';
    } else {
      tinhTrangColor = Colors.red;
      tinhTrangText = 'Không duyệt';
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        child: Column(
          children: [
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 8.w),
                          Text(
                            'Cấp duyệt: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: 'Arimo',
                              height: 1.4,
                            ),
                          ),
                          Text(
                            widget.capDuyet ?? '',
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 14.sp,
                              fontFamily: 'Arimo',
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 8.w),
                          Text(
                            'Người duyệt: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontFamily: 'Arimo',
                              height: 1.4,
                            ),
                          ),
                          Text(
                            widget.nguoiDuyet ?? '',
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 12.sp,
                              fontFamily: 'Arimo',
                              height: 1.4,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    child: Center(
                      child: Text(
                        tinhTrangText,
                        style: TextStyle(
                          color: tinhTrangColor,
                          fontFamily: 'Arimo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
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
                SizedBox(width: 8.w),
                Text(
                  widget.loai ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Arimo',
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
                const Spacer(),
                Text(
                  formatDate(widget.ngay),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Arimo',
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.noiDung ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                    height: 1.4,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
