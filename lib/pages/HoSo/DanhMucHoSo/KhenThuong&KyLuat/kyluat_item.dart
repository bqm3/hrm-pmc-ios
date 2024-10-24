import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class KyLuatItemView extends StatelessWidget {
  final String? nhanSu;
  final String? soQd;
  final String? ngayQd;
  final String? ngayHieuLuc;
  final String? hinhThuc;
  final int? thoiGian;
  final String? noiDung;
  final String? nguoiKy;
  final String? capQd;
  final String? ghiChu;
  final double? soTien;

  const KyLuatItemView(
      {Key? key,
      this.nhanSu,
      this.soQd,
      this.ngayQd,
      this.ngayHieuLuc,
      this.hinhThuc,
      this.thoiGian,
      this.noiDung,
      this.nguoiKy,
      this.capQd,
      this.ghiChu,
      this.soTien})
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
              
              RowHoSo(text1: 'Số QĐ', text2: soQd ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Cấp QĐ', text2: capQd ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Ngày QĐ', text2: formatDate(ngayQd) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(
                  text1: 'Ngày hiệu lực', text2: formatDate(ngayHieuLuc) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Hình thức', text2: hinhThuc ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              
              RowHoSo(text1: 'Nội dung', text2: noiDung ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Người ký', text2: nguoiKy ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Số tiền', text2: formatCurrency(soTien) ?? ''),
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
