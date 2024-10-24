import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class QtluongItemView extends StatelessWidget {
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

  const QtluongItemView(
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstant.getScreenSizeWidth(context) * 0.03,
        ),
        Container(
          width: AppConstant.getScreenSizeWidth(context) * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Bậc lương',
                  text2: (bacCc != null) ? bacCc.toString() : ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Ngạch lương', text2: ngachCc ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Thời gian',
                  text2:
                      formatDate(tuNgay) + ' - ' + formatDate(denNgay) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Hệ số lương',
                  text2: formatDate(hsl.toString()) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Mức lương', text2: formatCurrency(luongCoBan) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
            ],
          ),
        )
      ],
    );
  }
}
