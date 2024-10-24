import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class NghiPhepDetailPage extends StatelessWidget {
  final List<Map<String, dynamic>> nghiPhepDetailList;

  const NghiPhepDetailPage(
      {Key? key,
      required this.nghiPhepDetailList,
      required Map<String, dynamic> nghiPhepDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalSoLuong = nghiPhepDetailList.fold(
      0,
      (sum, item) => sum + (item['soLuong'] ?? 0),
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: const TitleAppBarWidget(title: "Nghỉ phép chi tiết")),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: nghiPhepDetailList.length,
          itemBuilder: (context, index) {
            final nghiPhepDetail = nghiPhepDetailList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Ngày:', _formatDate(nghiPhepDetail['ngay'])),
                _buildDetailRow(
                    'Số lượng:', nghiPhepDetail['soLuong']?.toString() ?? ''),
                _buildDetailRow('Ngày đăng ký:',
                    _formatRegisteredDate(nghiPhepDetail['date1'])),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateStr; // Trả về chuỗi gốc nếu có lỗi
    }
  }

  String _formatRegisteredDate(String? dateStr) {
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

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
