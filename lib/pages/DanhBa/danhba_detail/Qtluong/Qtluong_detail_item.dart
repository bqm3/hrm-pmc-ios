import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class QtluongDtItemView extends StatelessWidget {
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

  const QtluongDtItemView(
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
              RowHoSo(text1: 'Chuyên ngành', text2: ngachCc ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Số QĐ', text2: soQd ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Ngày QĐ', text2: formatDate(ngayQd) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Loại QĐ', text2: loaiQd ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Từ ngày', text2: formatDate(tuNgay) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Đến ngày', text2: formatDate(denNgay) ?? ''),
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
                  text1: 'Lương CB',
                  text2: formatCurrency(luongCoBan) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Bậc lương', text2: bacCc.toString() ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Nội dung', text2: noiDung ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Số hợp đồng', text2: soHd ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'HĐ Lao động', text2: hdld ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'PC Hợp đồng', text2: phuLucHopDong ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'PC Trách nhiệm',
                  text2: formatCurrency(pcTrachNhiem) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'PC Lương', text2: formatCurrency(pcLuong) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'PC Khác', text2: formatCurrency(pcKhac) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'BHXH', text2: bhxh ?? ''),
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

class QtluongDtItemView2 extends StatelessWidget {
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

  const QtluongDtItemView2(
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
                RowHoSo(text1: 'Bậc lương', text2: bacCc.toString() ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
               RowHoSo(text1: 'Ngạch lương', text2: ngachCc ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
             
             
             
               RowHoSo(text1: 'Thời gian', text2: formatDate(tuNgay)+' - '+formatDate(denNgay) ?? ''),
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
                  text1: 'Mức lương',
                  text2: formatCurrency(luongCoBan) ?? ''),
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
 