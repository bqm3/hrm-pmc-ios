import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class CongTacTrDtItemView extends StatelessWidget {
  final String? nhansu;
  final String? donVi;
  final String? tuNgay;
  final String? denNgay;
  final String? phongban;
  final String? chucVu;
  final String? kiemNhiem;
  final String? ghiChu;
  final String? thoiGian;
  final double? mucLuong;

  const CongTacTrDtItemView({
    Key? key,
    this.nhansu,
    this.donVi,
    this.tuNgay,
    this.denNgay,
    this.phongban,
    this.chucVu,
    this.kiemNhiem,
    this.ghiChu,
    this.thoiGian,
    this.mucLuong,
  }) : super(key: key);

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
              RowHoSo(text1: 'Đơn vị', text2: donVi ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Phòng ban', text2: phongban ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Chức vụ', text2: chucVu ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
           
              RowHoSo(text1: 'Kiêm nhiệm', text2: kiemNhiem ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
             
              RowHoSo(text1: 'Thời gian', text2: formatDate(tuNgay)+' - '+formatDate(denNgay) ?? ''),
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

class CongTacDtItemView extends StatelessWidget {
  final String? soQd;
  final String? ngayQd;
  final String? nhanSu;
  final String? tuNgay;
  final String? denNgay;
  final String? congTy;
  final String? donVi;
  final String? phongBan;
  final String? toCongTac;
  final String? chucVu;
  final String? kiemNhiem;
  final String? loaiQd;
  final String? ghiChu;
  final String? thoiGian;
  final double? mucLuong;
  final String? chuyenNganh;

  const CongTacDtItemView(
      {Key? key,
      this.soQd,
      this.ngayQd,
      this.nhanSu,
      this.tuNgay,
      this.denNgay,
      this.congTy,
      this.donVi,
      this.phongBan,
      this.toCongTac,
      this.chucVu,
      this.kiemNhiem,
      this.loaiQd,
      this.ghiChu,
      this.thoiGian,
      this.mucLuong,
      this.chuyenNganh})
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
              RowHoSo(text1: 'Công ty', text2: congTy ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Đơn vị', text2: donVi ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Phòng ban', text2: phongBan ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Bộ phận', text2: toCongTac ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
             
              RowHoSo(text1: 'Chức vụ', text2: chucVu ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Kiêm nhiệm', text2: kiemNhiem ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Loại QĐ', text2: loaiQd ?? ''),
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
              
              
              RowHoSo(text1: 'Ngày hiệu lực', text2: formatDate(tuNgay) ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Đến ngày', text2: formatDate(denNgay) ?? ''),
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
