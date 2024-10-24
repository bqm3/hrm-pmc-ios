import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/pages/Home/nghiviec_dialog.dart';
import 'package:salesoft_hrm/pages/TaiKhoan/taikhoan_page.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 200.h,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        Color avatarColor = AppColors.blueVNPT;
                        return Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: avatarColor,
                          ),
                          child: ClipOval(
                            child: Center(
                              child: Text(
                                homeController.kh.value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(() => Text(
                            '${homeController.hoDem.value} ${homeController.ten.value}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: 'Arimo',
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      Obx(() => Text(
                            'Mã nhân sự: ${homeController.ma.value}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10.sp,
                              fontFamily: 'Arimo',
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu1,
                ),
                title: Text(
                  'Thông tin cá nhân',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  Get.toNamed(ERouter.information.name);
                },
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu2,
                ),
                title: Text(
                  'Quan hệ gia đình',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  Get.toNamed(ERouter.quanhe.name);
                },
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu3,
                ),
                title: Text(
                  'Quá trình lương',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  Get.toNamed(ERouter.luong.name);
                },
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu4,
                ),
                title: Text(
                  'Quá trình công tác',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  Get.toNamed(ERouter.qtCongTac.name);
                },
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu5,
                ),
                title: Text(
                  'Khen thưởng, kỷ luật',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  Get.toNamed(ERouter.ktkl.name);
                },
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: Image.asset(AppResource.icLeave),
                ),
                title: Text(
                  'Đăng ký nghỉ việc',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NghiViecDialog(
                        dateController: _dateController,
                      );
                    },
                  );
                },
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu6,
                ),
                title: Text(
                  'Thay đổi mật khẩu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ChangePasswordDialog();
                    },
                  );
                },
              ),
              ListTile(
                leading: Container(
                  width: 26.0.w,
                  child: AppResource.icmenu7,
                ),
                title: Text(
                  'Đăng xuất',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.sp,
                    fontFamily: 'Arimo',
                  ),
                ),
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: FutureBuilder<PackageInfo>(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Phiên bản ${snapshot.data!.version}',
                          style: TextStyle(
                            fontFamily: 'Arimo',
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            fontSize: 10.sp,
                          ),
                        );
                      } else {
                        return Text('Đang tải phiên bản...');
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Xác nhận'),
        content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              final authService = Get.find<AuthService>();
              await authService.logout();
              SharedPreferences pref = await SharedPreferences.getInstance();
              bool? rememberMe = pref.getBool('rememberMe');
              if (rememberMe == null || !rememberMe) {
                await pref.remove('ma');
                await pref.remove('mk');
                await pref.remove('rememberMe');
              }
              Navigator.of(context).pop();
              Get.offAll(LoginPage());
            },
            child: Text('Đăng xuất'),
          ),
        ],
      );
    },
  );
}
