import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class HocVanItemView extends StatelessWidget {
  final String? nhanSu;
  final String? hocVan;
  final String? hocVi;
  final String? truongDt;
  final String? loaiBang;
  final String? chuyenNganh;
  final String? quocGia;
  final int? namTn;

  const HocVanItemView({
    Key? key,
    this.nhanSu,
    this.hocVan,
    this.hocVi,
    this.truongDt,
    this.loaiBang,
    this.chuyenNganh,
    this.quocGia,
    this.namTn,
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
             
              RowHoSo(text1: 'Học vấn', text2: hocVan ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Học vị', text2: hocVi ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Trường', text2: truongDt ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Loại bằng', text2: loaiBang ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Chuyên ngành', text2: chuyenNganh ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Quốc gia', text2: quocGia ?? ''),
              SizedBox(
                height: AppConstant.getScreenSizeHeight(context) * 0.01,
              ),
              RowHoSo(text1: 'Năm TN', text2: namTn?.toString() ?? ''),
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
