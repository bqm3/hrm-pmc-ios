import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';

class QuanHeItemView extends StatelessWidget {
  final String? hoTen;
  final String? quanHe;
  final String? ngaySinh;
  final String? diaChi;
  final String? ngheNghiep;
  final String? maSoThue;
  final String? soCmt;
  final String? ngayCmt;
  final String? noiCmt;
  final String? ghiChu;

  const QuanHeItemView({
    Key? key,
    this.hoTen,
    this.quanHe,
    this.ngaySinh,
    this.diaChi,
    this.ngheNghiep,
    this.maSoThue,
    this.soCmt,
    this.ngayCmt,
    this.noiCmt,
    this.ghiChu,
  }) : super(key: key);
// void _showEditDialog3() {
//   final TextEditingController hoTenController = TextEditingController(text: '$hoTen');
//   final TextEditingController quanHeController = TextEditingController(text: '$quanHe');
//   final TextEditingController ngaySinhController = TextEditingController(text: formatDate(ngaySinh));
//   final TextEditingController diaChiController = TextEditingController(text: diaChi);
//   final TextEditingController ngheNghiepController = TextEditingController(text: ngheNghiep);
//   final TextEditingController maSoController = TextEditingController(text: maSoThue);
//   final TextEditingController cmtController = TextEditingController(text: soCmt);
//   final TextEditingController noiCapController = TextEditingController(text: noiCmt);
//   final TextEditingController ngayCapController = TextEditingController(text: formatDate(ngayCmt));
  
//   final _formKey = GlobalKey<FormState>();


//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: Text('Chỉnh sửa thông tin'),
//             content: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: hoTenController,
//                       decoration: InputDecoration(
//                         labelText: 'Họ tên',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             hoTenController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập họ tên';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: hoTenController,
//                       decoration: InputDecoration(
//                         labelText: 'Quan hệ',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             quanHeController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập quan hệ';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: ngaySinhController,
//                       decoration: InputDecoration(
//                         labelText: 'Ngày sinh',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             ngaySinhController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập ngày sinh';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: diaChiController,
//                       decoration: InputDecoration(
//                         labelText: 'Địa chỉ',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             diaChiController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập địa chỉ';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: ngheNghiepController,
//                       decoration: InputDecoration(
//                         labelText: 'Nghề nghiệp',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             ngheNghiepController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập nghề nghiệp';
//                         }
                        
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: maSoController,
//                       decoration: InputDecoration(
//                         labelText: 'Mã số thuế',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                            maSoController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập mã số thuế';
//                         }
                       
//                         return null;
//                       },
//                     ),
//                     TextFormField( controller: maSoController,
//                       controller: cmtController,
//                       decoration: InputDecoration(
//                         labelText: 'Số CCCD/CMND',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             cmtController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập số CCCD/CMND';
//                         }
//                         return null;
//                       },
//                     ),
//                      TextFormField(
//                       controller: ngayCapController,
//                       decoration: InputDecoration(
//                         labelText: 'Ngày cấp',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             ngayCapController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập ngày cấp';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: noiCapController,
//                       decoration: InputDecoration(
//                         labelText: 'Nơi cấp',
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.clear),
//                           onPressed: () {
//                             noiCapController.clear();
//                           },
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Vui lòng nhập nơi cấp';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               TextButton(
//                 child: Text('Hủy'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: Text('Xác nhận'),
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
                 
                   
//                     Navigator.of(context).pop();
//                   }
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
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
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Họ tên', text2: hoTen ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Quan hệ', text2: quanHe ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Ngày sinh', text2: formatDate(ngaySinh) ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Địa chỉ', text2: diaChi ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Nghề nghiệp', text2: ngheNghiep ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Mã số thuế', text2: maSoThue ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'CCCD/CMND', text2: soCmt ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Ngày cấp', text2: formatDate(ngayCmt) ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            RowHoSo(text1: 'Nơi cấp', text2: noiCmt ?? ''),
            SizedBox(
              height: AppConstant.getScreenSizeHeight(context) * 0.01,
            ),
            // RowHoSo(text1: 'Ghi chú', text2: ghiChu ?? ''),
          ],
        ),
      ),
    );
  }
}
