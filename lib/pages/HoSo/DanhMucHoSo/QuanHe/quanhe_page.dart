import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/repository/post_quanHe_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/loaiquanhe_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/loaiquanhe_repository.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/quanhe_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/quanhe_item.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';

class QuanHePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QuanHeController controller = Get.put(QuanHeController());
    return Scaffold(
      appBar: AppBar(
        leading: const BackButtonWidget(),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Row(
          children: [
            const Expanded(
                flex: 9, child: TitleAppBarWidget(title: "Quan hệ gia đình")),
            const Spacer(),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  _showAddInfoDialog(context);
                },
                child: const FaIcon(FontAwesomeIcons.personCirclePlus,
                    color: AppColors.blueVNPT),
              ),
            ),
          ],
        ),
      ),
      body: controller.obx(
        (state) => ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstant.getScreenSizeWidth(context) * 0.05,
            vertical: 10,
          ),
          itemCount: state?.data?.length ?? 0,
          itemBuilder: (context, index) {
            final item = state!.data![index];
            return QuanHeItemView(
              hoTen: item.hoTen,
              quanHe: item.quanHe,
              ngaySinh: item.ngaySinh,
              diaChi: item.diaChi,
              ngheNghiep: item.ngheNghiep,
              maSoThue: item.maSoThue,
              soCmt: item.soCmt,
              ngayCmt: item.ngayCmt,
              noiCmt: item.noiCmt,
              ghiChu: item.ghiChu,
            );
          },
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(
          child: Text('Không có thông tin quan hệ'),
        ),
        onError: (error) => Center(child: Text('Lỗi: $error')),
      ),
    );
  }
}

void _showAddInfoDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AddInfoDialog();
    },
  );
}

class AddInfoDialog extends StatefulWidget {
  @override
  _AddInfoDialogState createState() => _AddInfoDialogState();
}

class _AddInfoDialogState extends State<AddInfoDialog> {
  final LoaiQuanHeController quanHeController =
      Get.put(LoaiQuanHeController(LoaiQuanHeRepository()));
  late Future<void> _fetchQuanHeFuture;
  final TextEditingController hoTenController = TextEditingController();
  final TextEditingController ngaySinhController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  final TextEditingController ngheNghiepController = TextEditingController();
  final TextEditingController maSoThueController = TextEditingController();
  final TextEditingController soCmtController = TextEditingController();
  final TextEditingController ngayCmtController = TextEditingController();
  final TextEditingController noiCmtController = TextEditingController();

  bool _hoTenError = false;
  bool _ngaySinhError = false;
  bool _ngaySinhError2 = false;
  bool _diaChiError = false;
  String? selectedQuanHe;
  bool validateDateFormat(String date) {
    final RegExp dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    return dateRegExp.hasMatch(date);
  }

  @override
  void initState() {
    super.initState();
    _fetchQuanHeFuture = quanHeController.fetchQuanHeList();
    if (quanHeController.quanHeList.isNotEmpty) {
      selectedQuanHe = quanHeController.quanHeList.first.ma;
    }
  }

  @override
  void dispose() {
    hoTenController.dispose();
    ngaySinhController.dispose();
    diaChiController.dispose();
    ngheNghiepController.dispose();
    maSoThueController.dispose();
    soCmtController.dispose();
    ngayCmtController.dispose();
    noiCmtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: FutureBuilder<void>(
        future: _fetchQuanHeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi tải dữ liệu quan hệ'));
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Họ tên',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _hoTenError ? Colors.red : Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: hoTenController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập họ tên...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        if (_hoTenError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Vui lòng nhập họ tên.',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Quan hệ',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: Colors.white,
                      ),
                      child: DropdownButton<String>(
                        hint: const Text('Chọn quan hệ'),
                        value: selectedQuanHe,
                        isExpanded: true,
                        underline: Container(),
                        items: quanHeController.quanHeList
                            .map((LoaiQuanHe quanHe) {
                          return DropdownMenuItem<String>(
                            value: quanHe.ma,
                            child: Text(quanHe.ten),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedQuanHe = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Ngày sinh',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 1.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _ngaySinhError ? Colors.red : Colors.grey,
                            width: 0.5),
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: ngaySinhController,
                        style: TextStyle(
                          fontFamily: 'Arimo',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập ngày sinh...',
                          errorText: _ngaySinhError2
                              ? 'Nhập đúng định dạng dd/mm/yyyy'
                              : null,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Arimo',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    if (_ngaySinhError)
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Vui lòng nhập ngày sinh',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    SizedBox(height: 12.h),
                    Text(
                      'Địa chỉ',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _diaChiError ? Colors.red : Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: diaChiController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập địa chỉ...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        if (_diaChiError)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Vui lòng nhập địa chỉ.',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Nghề nghiệp',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: ngheNghiepController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập nghề nghiệp...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Mã số thuế',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: maSoThueController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập mã số thuế...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'CCCD/CMND',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: soCmtController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập CCCD/CMND...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Ngày cấp',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: ngayCmtController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập ngày cấp...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Nơi cấp',
                      style: TextStyle(
                        fontFamily: 'Arimo',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 1.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: noiCmtController,
                            style: TextStyle(
                              fontFamily: 'Arimo',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nhập nơi cấp...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 0.7),
                              borderRadius: BorderRadius.circular(10.0.r),
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0.r),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Quay lại',
                                style: TextStyle(
                                  fontFamily: 'Arimo',
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 4,
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: AppColors.blueVNPT,
                            borderRadius: BorderRadius.circular(10.0),
                            onPressed: () async {
                              _hoTenError = hoTenController.text.isEmpty;
                              _ngaySinhError = ngaySinhController.text.isEmpty;
                              _ngaySinhError2 =
                                  !validateDateFormat(ngaySinhController.text);
                              _diaChiError = diaChiController.text.isEmpty;

                              if (_hoTenError ||
                                  _ngaySinhError ||
                                  _ngaySinhError2 ||
                                  _diaChiError) {
                                // Hiển thị thông báo lỗi
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Vui lòng điền đầy đủ thông tin.')),
                                );
                                return;
                              }

                              print('Họ tên: ${hoTenController.text}');
                              print('Ngày sinh: ${ngaySinhController.text}');
                              print('Địa chỉ: ${diaChiController.text}');
                              print(
                                  'Nghề nghiệp: ${ngheNghiepController.text}');
                              print('Mã số thuế: ${maSoThueController.text}');
                              print('CCCD/CMND: ${soCmtController.text}');
                              print('Ngày cấp: ${ngayCmtController.text}');
                              print('Nơi cấp: ${noiCmtController.text}');
                              print('Quan hệ: $selectedQuanHe');

                              // Gọi API để thêm quan hệ
                              final response = await postQuanHe(
                                quanHe: selectedQuanHe!,
                                hoTen: hoTenController.text,
                                ngaySinh: ngaySinhController.text,
                                diaChi: diaChiController.text,
                                ngheNghiep: ngheNghiepController.text,
                                maSoThue: maSoThueController.text,
                                soCmt: soCmtController.text,
                                ngayCmt: ngayCmtController.text,
                                noiCmt: noiCmtController.text,
                              );
                            },
                            child: Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontFamily: 'Arimo',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

String? validateDate(String? value) {
  final RegExp dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (value == null || value.isEmpty) {
    return 'Vui lòng nhập ngày sinh';
  } else if (!dateRegExp.hasMatch(value)) {
    return 'Ngày sinh không hợp lệ. Vui lòng nhập theo định dạng dd/MM/yyyy';
  }
  return null;
}

String? valiDateNgayCap(String? value) {
  final RegExp dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegExp.hasMatch(value!)) {
    return 'Ngày cấp không hợp lệ. Vui lòng nhập theo định dạng dd/MM/yyyy';
  }
  return null;
}

String? validateCCCD(String? value) {
  final RegExp cccdRegExp = RegExp(r'^\d{9}$|^\d{12}$');
  if (!cccdRegExp.hasMatch(value!)) {
    return 'Số CCCD/CMND không hợp lệ. Vui lòng nhập 9 hoặc 12 chữ số';
  }
  return null;
}

String? validateMaSoThue(String? value) {
  final RegExp maSoThueRegExp = RegExp(r'^\d+$');
  if (!maSoThueRegExp.hasMatch(value!)) {
    return 'Mã số thuế chỉ được nhập số';
  }
  return null;
}
