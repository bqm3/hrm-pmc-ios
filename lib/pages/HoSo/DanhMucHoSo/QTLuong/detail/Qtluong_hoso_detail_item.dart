import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class QtluongItemView2 extends StatelessWidget {
  final String? soQd;
  final String? ngayQd;
  final String? loaiQd;
  final String? nhanSu;
  final String? tuNgay;
  final String? denNgay;
  final String? ngachCc;
  final double? bacCc;
  final double? hsl;
  final double? luongCoBan;
  final String? noiDung;
  final String? soHd;
  final String? hdld;
  final String? phuLucHopDong;
  final double? pcTrachNhiem;
  final double? pcLuong;
  final double? pcKhac;
  final String? bhxh;
  final int? lanKy;
  final String? ghiChu;

  const QtluongItemView2(
      {Key? key,
      this.soQd,
      this.ngayQd,
      this.loaiQd,
      this.nhanSu,
      this.tuNgay,
      this.denNgay,
      this.ngachCc,
      this.bacCc,
      this.hsl,
      this.luongCoBan,
      this.noiDung,
      this.soHd,
      this.hdld,
      this.phuLucHopDong,
      this.pcTrachNhiem,
      this.pcLuong,
      this.pcKhac,
      this.bhxh,
      this.lanKy,
      this.ghiChu})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Mã nhân sự', text2: nhanSu ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Chuyên ngành', text2: ngachCc ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Số QĐ', text2: soQd ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Ngày QĐ', text2: formatDate(ngayQd) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Loại QĐ', text2: loaiQd ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Từ ngày', text2: formatDate(tuNgay) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Đến ngày', text2: formatDate(denNgay) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Hệ số lương', text2: formatDate(hsl.toString()) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(
            text1: 'Lương cơ bản', text2: formatCurrency(luongCoBan) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(
            text1: 'Bậc công chức',
            text2: (bacCc != null) ? bacCc.toString() : ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Nội dung', text2: noiDung ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'Số HĐ', text2: soHd ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'HĐLĐ', text2: hdld ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(
            text1: 'PC Trách nhiệm', text2: formatCurrency(pcTrachNhiem) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'PC Lương', text2: formatCurrency(pcLuong) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'PC Khác', text2: formatCurrency(pcKhac) ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(text1: 'BHXH', text2: bhxh ?? ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
        RowHoSo2(
            text1: 'Lần ký', text2: (lanKy != null) ? lanKy.toString() : ''),
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.01,
        ),
      ],
    );
  }
}
