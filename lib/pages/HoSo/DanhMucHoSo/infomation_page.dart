import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/NS_Update_provider.dart';
import 'package:salesoft_hrm/API/repository/NS_Update_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/format_date.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/HocVan/hocvan_controller.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/HocVan/hocvan_item.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/UnApproved/not_approved_controller.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/widgets/component/back_button_widget.dart';
import 'package:salesoft_hrm/widgets/component/title_appbar_widget.dart';
import 'package:salesoft_hrm/widgets/cot_hoso_widget.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';

class MyInformation extends StatefulWidget {
  const MyInformation({Key? key}) : super(key: key);

  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  final HomeController homeController = Get.find<HomeController>();
  final HocVanController controller = Get.put(HocVanController());

  bool isValidPhoneNumber(String phone) {
    final RegExp phoneExp = RegExp(r'^0[0-9]{9}$');
    return phoneExp.hasMatch(phone);
  }

  bool isValidEmail(String email) {
    final RegExp emailExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailExp.hasMatch(email);
  }

  Future<void> dialogApproved() async {
    final ApprovedController approvedController = Get.put(ApprovedController());
    await approvedController.fetchUserInfo();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppConstant.getScreenSizeWidth(context) * 0.05),
                    child: Text(
                      'Đang chờ xét duyệt',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'Arimo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.01,
                  ),
                  RowHoSo(
                    text1: 'Họ tên',
                    text2: approvedController.hoTen.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo(
                    text1: 'Ngày sinh',
                    text2: formatDate(approvedController.ngaySinh.value),
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo(
                    text1: 'Giới tính',
                    text2: approvedController.gioiTinh.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo3(
                    text1: 'Địa chỉ',
                    text2: approvedController.dcll.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo3(
                    text1: 'Điện thoại',
                    text2: approvedController.dienThoai.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo3(
                    text1: 'Email',
                    text2: approvedController.email.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo(
                    text1: 'Số CMT',
                    text2: approvedController.cmt.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo(
                    text1: 'Nơi cấp',
                    text2: approvedController.noiCmt.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo(
                    text1: 'Ngày cấp',
                    text2: formatDate(approvedController.ngayCmt.value),
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo3(
                    // icon: Icons.edit,
                    text1: 'Tài khoản',
                    text2: approvedController.taiKhoan.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                  RowHoSo3(
                    // icon: Icons.edit,
                    text1: 'Ngân hàng',
                    text2: approvedController.nganHang.value,
                  ),
                  SizedBox(
                    height: AppConstant.getScreenSizeHeight(context) * 0.02,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog2() {
    final AuthService authService = Get.find<AuthService>();
    final TextEditingController hoTenController = TextEditingController(
        text: '${homeController.hoDem.value} ${homeController.ten.value}');
    final TextEditingController ngaySinhController =
        TextEditingController(text: formatDate(homeController.ngaySinh.value));
    final TextEditingController diaChiController =
        TextEditingController(text: homeController.dcll.value);
    final TextEditingController dienThoaiController =
        TextEditingController(text: homeController.dienThoai.value);
    final TextEditingController emailController =
        TextEditingController(text: homeController.email.value);
    final TextEditingController cmtController =
        TextEditingController(text: homeController.cmt.value);
    final TextEditingController noiCapController =
        TextEditingController(text: homeController.noiCmt.value);
    final TextEditingController ngayCapController =
        TextEditingController(text: formatDate(homeController.ngayCmt.value));
    final TextEditingController taiKhoanController =
        TextEditingController(text: homeController.taiKhoan.value);
    final TextEditingController nganHangController =
        TextEditingController(text: homeController.nganHang.value);
    final TextEditingController noiSinhController = TextEditingController();
    final TextEditingController dcttController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    String gioiTinh = homeController.gioiTinh.value;
    bool ngaySinhError = false;
    bool ngaySinhError2 = false;

    bool noiSinhError = false;
    bool dcttError = false;
    bool dcllError = false;
    bool dienThoaiError = false;
    bool dienThoaiError2 = false;

    bool emailError = false;
    bool emailError2 = false;

    bool cccdError = false;
    bool cccdError2 = false;

    bool noiCapError = false;
    bool noiCapError2 = false;

    bool ngayCapError = false;
    bool ngayCapError2 = false;

    bool taiKhoanError = false;
    bool taiKhoanError2 = false;

    bool nganHangError = false;
    bool validateDateFormat(String date) {
      final RegExp datePattern = RegExp(r"^\d{2}/\d{2}/\d{4}$");
      return datePattern.hasMatch(date);
    }

    bool validatePhoneNumber(String phone) {
      final RegExp phonePattern = RegExp(r"^\d{10}$");
      return phonePattern.hasMatch(phone);
    }

    bool validateEmail(String email) {
      final RegExp emailPattern = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      return emailPattern.hasMatch(email);
    }

    bool validateCCCD(String cccd) {
      final RegExp cccdPattern = RegExp(r"^\d{12}$");
      return cccdPattern.hasMatch(cccd);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text(
                          'Họ tên',
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
                            border: Border.all(color: Colors.grey, width: 0.5),
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
                              hintText: 'Nhập nội dung...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Arimo',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            enabled: false,
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
                                  color:
                                      ngaySinhError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
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
                                      errorText: ngaySinhError2
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
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      ngaySinhController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (ngaySinhError)
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
                          'Nơi sinh',
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
                                  color:
                                      noiSinhError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: noiSinhController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập nơi sinh...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Arimo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      noiSinhController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (noiSinhError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập nơi sinh',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Giới tính',
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
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(10.0.r),
                            color: Colors.white,
                          ),
                          child: DropdownButton<String>(
                            value: gioiTinh,
                            isExpanded: true,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                gioiTinh = newValue!;
                                homeController.gioiTinh.value = gioiTinh;
                              });
                            },
                            items: <String>['Nam', 'Nữ']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Địa chỉ thường trú',
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
                                  color: dcttError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: dcttController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập dctt...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Arimo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      dcttController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (dcttError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập dctt',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Địa chỉ liên lạc',
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
                                  color: dcllError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: diaChiController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập dcll...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Arimo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      diaChiController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (dcllError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập dcll',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Điện thoại',
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
                                  color:
                                      dienThoaiError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: dienThoaiController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập điện thoại...',
                                      errorText: dienThoaiError2
                                          ? 'Nhập đúng định dạng số điện thoại'
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
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      dienThoaiController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (dienThoaiError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập điện thoại',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Email',
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
                                  color: emailError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: emailController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập email...',
                                      errorText: emailError2
                                          ? 'Nhập đúng định dạng email'
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
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      emailController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (emailError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập email',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'CCCD/CMND',
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
                                  color: cccdError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: cmtController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập CCCD/CMND...',
                                      errorText: cccdError
                                          ? 'Nhập đúng định dạng cccd'
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
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      cmtController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (cccdError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập CCCD/CMND',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Nơi cấp',
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
                                  color:
                                      ngaySinhError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: noiCapController,
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
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      noiCapController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (noiCapError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập nơi cấp',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Ngày cấp ',
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
                                  color:
                                      ngayCapError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: ngayCapController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập ngày cấp...',
                                      errorText: ngayCapError2
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
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      ngayCapController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (ngayCapError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập ngày cấp',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Tài khoản',
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
                                  color:
                                      taiKhoanError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: taiKhoanController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập tài khoản...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Arimo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      taiKhoanController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (taiKhoanError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập tài khoản',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 12.h),
                        Text(
                          'Ngân hàng',
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
                                  color:
                                      nganHangError ? Colors.red : Colors.grey,
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(10.0.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: TextField(
                                    controller: nganHangController,
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập ngân hàng...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Arimo',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      nganHangController.clear();
                                    },
                                    child: const FaIcon(
                                      FontAwesomeIcons.times,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        if (nganHangError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Vui lòng nhập ngân hàng',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 0.7),
                                  borderRadius: BorderRadius.circular(10.0.r),
                                ),
                                child: CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0.r),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Quay lại',
                                    style: TextStyle(
                                      fontFamily: 'Arimo',
                                      color: Colors.black,
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
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      ngaySinhError =
                                          ngaySinhController.text.isEmpty;
                                      nganHangError =
                                          nganHangController.text.isEmpty;
                                      noiSinhError =
                                          noiSinhController.text.isEmpty;
                                      dcttError = dcttController.text.isEmpty;
                                      dcllError = diaChiController.text.isEmpty;
                                      dienThoaiError =
                                          dienThoaiController.text.isEmpty;
                                      emailError = emailController.text.isEmpty;
                                      cccdError = cmtController.text.isEmpty;
                                      noiCapError =
                                          noiCapController.text.isEmpty;
                                      ngayCapError =
                                          ngayCapController.text.isEmpty;
                                      taiKhoanError =
                                          taiKhoanController.text.isEmpty;
                                      ngaySinhError2 = !validateDateFormat(
                                          ngaySinhController.text);
                                      ngayCapError2 = !validateDateFormat(
                                          ngayCapController.text);
                                      dienThoaiError2 = !validatePhoneNumber(
                                          dienThoaiController.text);
                                      emailError2 =
                                          !validateEmail(emailController.text);
                                      cccdError2 =
                                          !validateCCCD(cmtController.text);
                                    });

                                    if (!ngaySinhError &&
                                        !noiSinhError &&
                                        !dcttError &
                                            !dcllError &
                                            !emailError &
                                            !cccdError &
                                            !noiCapError &
                                            !ngayCapError &
                                            !taiKhoanError &
                                            !nganHangError &&
                                        !dcttError &&
                                        !dienThoaiError) {
                                      try {
                                        final provider2 =
                                            NSUpdateAPI2(authService);
                                        final repository2 =
                                            NSUpdateNSRepository(
                                                provider2: provider2);
                                        final DateFormat formatter =
                                            DateFormat('yyyy/MM/dd');
                                        final String formattedNgaySinh =
                                            formatter.format(
                                                DateFormat('dd/MM/yyyy').parse(
                                                    ngaySinhController.text));
                                        final String formattedNgayCap =
                                            formatter.format(
                                                DateFormat('dd/MM/yyyy').parse(
                                                    ngayCapController.text));
                                        final response =
                                            await repository2.NSUpdateAPI2(
                                          ngaySinh: formattedNgaySinh,
                                          dienThoai: dienThoaiController.text,
                                          dcll: diaChiController.text,
                                          email: emailController.text,
                                          cmt: cmtController.text,
                                          noiCmt: noiCapController.text,
                                          ngayCmt: formattedNgayCap,
                                          nganHang: nganHangController.text,
                                          taiKhoan: taiKhoanController.text,
                                          noiSinh: noiSinhController.text,
                                          gioiTinh: gioiTinh,
                                          dctt: dcttController.text,
                                        );

                                        if (response.statusCode == 200) {
                                         
                                          Navigator.of(context).pop();
                                           Get.dialog(
        thongBaoDialog(text: response.body['message'] ??
                                                "Cập nhật thông tin cá nhân thành công",),
      );
                                        } else if (response.statusCode == 400) {
                                          
                                           Get.dialog(
        thongBaoDialog2(text:response.body['message'] ??
                                                "Cập nhật thông tin cá nhân thất bại",),
      );
                                        }
                                      } catch (error) {
                                        print(error);
                                        
                                         Get.dialog(
        thongBaoDialog(text:"Cập nhật thông tin cá nhân thành công",),
      );
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
                                child: const Text(
                                  'Xác nhận',
                                  style: TextStyle(
                                    fontFamily: 'Arimo',
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showEditDialog(String title, String currentValue, String cot) {
    final TextEditingController textController =
        TextEditingController(text: currentValue);
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thay đổi $title'),
          content: Form(
            key: _formKey,
            child: Stack(
              children: [
                TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: currentValue,
                    suffixIcon: textController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                textController.clear();
                              });
                            },
                          )
                        : null,
                  ),
                  keyboardType: (title == 'điện thoại')
                      ? TextInputType.phone
                      : TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập $title';
                    }
                    if (title == 'điện thoại' && !isValidPhoneNumber(value)) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    if (title == 'email' && !isValidEmail(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Xác nhận'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String newValue = textController.text;
                  await homeController.updateUserInfo(cot, newValue);
                  
                  Navigator.of(context).pop();
                   Get.dialog(
        thongBaoDialog2(text: "Đăng ký thay đổi $title thành công",),
      );
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
    return Scaffold(
      appBar: AppBar(
          leading: const BackButtonWidget(),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                flex: 9,
                child: TitleAppBarWidget(title: "Sơ Yếu Lý Lịch"),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _showEditDialog2();
                  },
                  child: const FaIcon(FontAwesomeIcons.edit,
                      color: AppColors.blueVNPT),
                ),
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Text(
                    'Thông tin cá nhân',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arimo'),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      dialogApproved();
                    },
                    child: const FaIcon(FontAwesomeIcons.list),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    RowHoSo(
                      text1: 'Họ tên',
                      text2:
                          '${homeController.hoDem.value} ${homeController.ten.value}',
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RowHoSo(
                      text1: 'Ngày sinh',
                      text2: formatDate(homeController.ngaySinh.value),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RowHoSo(
                      text1: 'Giới tính',
                      text2: homeController.gioiTinh.value,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    RowHoSo3(
                      text1: 'Địa chỉ',
                      // icon: Icons.edit,
                      text2: homeController.dcll.value,
                      onTap: () => _showEditDialog(
                          'địa chỉ', homeController.dcll.value, 'DCLL'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      text1: 'Điện thoại',
                      // icon: Icons.edit,
                      text2: homeController.dienThoai.value,
                      onTap: () => _showEditDialog('điện thoại',
                          homeController.dienThoai.value, 'DienThoai'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Email',
                      text2: homeController.email.value,
                      onTap: () => _showEditDialog(
                          'email', homeController.email.value, 'Email'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Số CMT',
                      text2: homeController.cmt.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Nơi cấp',
                      text2: homeController.noiCmt.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Ngày cấp',
                      text2: formatDate(homeController.ngayCmt.value),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Tài khoản',
                      text2: homeController.taiKhoan.value,
                      onTap: () => _showEditDialog('tài khoản',
                          homeController.taiKhoan.value, 'TaiKhoan'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo3(
                      // icon: Icons.edit,
                      text1: 'Ngân hàng',
                      text2: homeController.nganHang.value,
                      onTap: () => _showEditDialog('ngân hàng',
                          homeController.nganHang.value, 'NganHang'),
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
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
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.01,
                    ),
                    RowHoSo(
                      text1: 'Đơn vị',
                      text2: homeController.donVi.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Phòng ban',
                      text2: homeController.phongBan.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Bộ phận',
                      text2: homeController.toCongTac.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                    RowHoSo(
                      text1: 'Chức vụ',
                      text2: homeController.chucVu.value,
                    ),
                    SizedBox(
                      height: AppConstant.getScreenSizeHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.07,
              ),
              const Text(
                'Học vấn',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: AppConstant.getScreenSizeWidth(context) * 0.01,
              ),
              Container(
                child: Get.find<HocVanController>().obx(
                  (state) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: state?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = state!.data![index];
                      return HocVanItemView(
                        nhanSu: item.nhanSu,
                        hocVan: item.hocVan,
                        hocVi: item.hocVi,
                        truongDt: item.truongDt,
                        loaiBang: item.loaiBang,
                        chuyenNganh: item.chuyenNganh,
                        namTn: item.namTn,
                        quocGia: item.quocGia,
                      );
                    },
                  ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: const Center(
                    child: Text('Không có thông tin'),
                  ),
                  onError: (error) =>
                      const Center(child: Text('Không có thông tin')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowHoSo3 extends StatefulWidget {
  final String text1;
  final String text2;
  // final IconData icon;
  final Function()? onTap;

  const RowHoSo3(
      {Key? key,
      required this.text1,
      required this.text2,
      // required this.icon,
      this.onTap})
      : super(key: key);

  @override
  _RowHoSoState createState() => _RowHoSoState();
}

class _RowHoSoState extends State<RowHoSo3> {
  bool thuGon = true;
  bool xemThem = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Row(children: [
              Text(
                widget.text1,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Arimo',
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              // Column(
              //   children:[
              //      Icon(
              //   widget.icon,
              //   size:15,

              // ),
              // SizedBox(height: AppConstant.getScreenSizeHeight(context)*0.015),
              //   ]
              // )
            ]),
          ),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              setState(() {
                thuGon = !thuGon;
                xemThem = !xemThem;
              });
            },
            child: Text(
              widget.text2,
              maxLines: xemThem ? (thuGon ? 1 : 3) : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Arimo'),
            ),
          ),
        ),
      ],
    );
  }
}
