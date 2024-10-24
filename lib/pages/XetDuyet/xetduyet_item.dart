import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/pages/XetDuyet/put_xetduyet.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class XetDuyetItemView extends StatefulWidget {
  final String? loai;
  final int? id;
  final String? ngay;
  final String? dieuKien;
  final String? noiDung;
  final String? capDuyet;
  bool? tinhTrang;

  XetDuyetItemView({
    Key? key,
    this.loai,
    this.ngay,
    this.id,
    this.dieuKien,
    this.tinhTrang,
    this.noiDung,
    this.capDuyet,
  }) : super(key: key);

  @override
  _XetDuyetItemViewState createState() => _XetDuyetItemViewState();
}

class _XetDuyetItemViewState extends State<XetDuyetItemView> {
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

  void _showConfirmDialog(BuildContext context, String action) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
              action == 'duyệt' ? 'Xác nhận duyệt ' : 'Xác nhận không duyệt'),
          content: Text('Bạn có chắc chắn muốn $action không?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Xác nhận'),
              onPressed: () {
                Navigator.of(context).pop();
                if (action == 'duyệt') {
                  confirmDuyet(widget.id!);
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
      case 0:
        tinhTrangColor = Colors.grey;
        tinhTrangText = 'Chờ duyệt';
        break;
      case 1:
        tinhTrangColor = Colors.green;
        tinhTrangText = 'Đã duyệt';
        break;
      case 2:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không duyệt';
        break;
      default:
        tinhTrangColor = Colors.red;
        tinhTrangText = 'Không xác định';
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
                SizedBox(width: 8.w),
                Text(
                  'Cấp duyệt: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Arimo',
                    fontSize: 14.sp,
                    height: 1.4,
                  ),
                ),
                Text(
                  widget.capDuyet ?? '',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Arimo',
                    fontSize: 14.sp,
                    height: 1.4,
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
                  formatDate(widget.ngay) ?? '',
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
                    fontFamily: 'Arimo',
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 24.w),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _showInputDialog(context, widget.id!);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 183, 183, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Không Duyệt',
                          style: TextStyle(
                            color: const Color.fromRGBO(230, 98, 107, 1),
                            fontSize: 12.sp,
                            fontFamily: 'Arimo',
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      _showConfirmDialog(context, 'duyệt');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(173, 236, 193, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Duyệt',
                          style: TextStyle(
                            color: const Color.fromRGBO(62, 199, 97, 1.0),
                            fontSize: 12.sp,
                            fontFamily: 'Arimo',
                            height: 1.4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24.w),
              ],
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}

void _showInputDialog(BuildContext context, int id) {
  TextEditingController _noiDungController = TextEditingController();

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('Nhập lý do từ chối'),
        content: Column(
          children: [
            SizedBox(height: 16.h),
            CupertinoTextField(
              controller: _noiDungController,
              placeholder: 'Nhập lý do...',
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Xác nhận'),
            onPressed: () {
              String noiDung = _noiDungController.text.trim();
              Navigator.of(context).pop();
              if (noiDung.isNotEmpty) {
                confirmKhongDuyet(id, noiDung);
              } else {
                Get.dialog(thongBaoDialog2(text: 'Lý do không được để trống.'));
              }
            },
          ),
        ],
      );
    },
  );
}
