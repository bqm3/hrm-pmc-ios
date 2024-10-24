import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/doimk_provider.dart';
import 'package:salesoft_hrm/API/repository/doimk_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/common/router.dart';
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:salesoft_hrm/pages/login/login_page.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaiKhoanPage extends StatelessWidget {
  const TaiKhoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _profile(),
          const SizedBox(
            height: 30,
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ChangePasswordDialog();
                  },
                );
              },
              child: const Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: FaIcon(
                      FontAwesomeIcons.lock,
                      color: AppColors.orBgr,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    flex: 60,
                    child: Text(
                      'Đổi mật khẩu',
                      style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
            height: 1,
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: GestureDetector(
              onTap: () async {
                _showLogoutConfirmationDialog(context);
              },
              child: const Row(
                children: [
                  Expanded(
                    flex: 15,
                    child: FaIcon(
                      FontAwesomeIcons.signOut,
                      color: AppColors.orBgr,
                      size: 30,
                    ),
                  ),
                  Expanded(
                    flex: 60,
                    child: Text(
                      'Đăng xuất',
                      style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _profile extends StatelessWidget {
  _profile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.only(
          top: AppConstant.getScreenSizeHeight(context) * 0.1,
          left: AppConstant.getScreenSizeWidth(context) * 0.02),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(ERouter.hoSo.name);
        },
        child: Row(
          children: [
            Obx(() {
              Color avatarColor;
              avatarColor = AppColors.blueVNPT;
              return Container(
                width: AppConstant.getScreenSizeWidth(context) * 0.15,
                height: AppConstant.getScreenSizeWidth(context) * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: avatarColor,
                ),
                child: ClipOval(
                  child: Center(
                    child: Text(
                      homeController.kh.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      '${homeController.hoDem.value} ${homeController.ten.value}',
                      style: const TextStyle(
                          color: AppColors.orBgr,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                const Text(
                  'Xem hồ sơ cá nhân',
                  style: TextStyle(color: AppColors.orBgr, fontSize: 18),
                ),
              ],
            )
          ],
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

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscureTextOldPassword = true;
  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmPassword = true;

  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isOldPasswordValid = true;
  bool _isOldPasswordEmpty = false;
  bool _isNewPasswordEmpty = false;
  bool _isConfirmPasswordEmpty = false;
  bool _isOldPasswordIncorrect = false;

  @override
  Widget build(BuildContext context) {
    final NSUpdateMKRepository updateMKRepository = NSUpdateMKRepository(
      provider: NSDoiMK(Get.find<AuthService>()),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),
                _buildPasswordTextField(
                  label: 'Mật khẩu cũ',
                  controller: oldPasswordController,
                  obscureText: _obscureTextOldPassword,
                  onToggleObscureText: () {
                    setState(() {
                      _obscureTextOldPassword = !_obscureTextOldPassword;
                    });
                  },
                  isPasswordValid: _isOldPasswordValid,
                  isEmpty: _isOldPasswordEmpty,
                  isOldPasswordIncorrect: _isOldPasswordIncorrect,
                ),
                SizedBox(height: 8.h),
                _buildPasswordTextField(
                  label: 'Mật khẩu mới',
                  controller: newPasswordController,
                  obscureText: _obscureTextNewPassword,
                  onToggleObscureText: () {
                    setState(() {
                      _obscureTextNewPassword = !_obscureTextNewPassword;
                    });
                  },
                  isEmpty: _isNewPasswordEmpty,
                ),
                if (!_isPasswordValid)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Mật khẩu phải có ít nhất 8 ký tự',
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
                SizedBox(height: 8.h),
                _buildPasswordTextField(
                  label: 'Xác nhận mật khẩu mới',
                  controller: confirmPasswordController,
                  obscureText: _obscureTextConfirmPassword,
                  onToggleObscureText: () {
                    setState(() {
                      _obscureTextConfirmPassword =
                          !_obscureTextConfirmPassword;
                    });
                  },
                  isEmpty: _isConfirmPasswordEmpty,
                ),
                if (!_isConfirmPasswordValid)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Mật khẩu mới và xác nhận mật khẩu không khớp',
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
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
                          border: Border.all(color: Colors.black, width: 0.7),
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
                          setState(() {
                            _isOldPasswordEmpty =
                                oldPasswordController.text.isEmpty;
                            _isNewPasswordEmpty =
                                newPasswordController.text.isEmpty;
                            _isConfirmPasswordEmpty =
                                confirmPasswordController.text.isEmpty;
                            _isOldPasswordIncorrect = false;
                          });

                          if (_isOldPasswordEmpty ||
                              _isNewPasswordEmpty ||
                              _isConfirmPasswordEmpty) {
                            return;
                          }

                          final prefs = await SharedPreferences.getInstance();
                          String? storedPassword = prefs.getString('matKhau');

                          setState(() {
                            _isOldPasswordValid =
                                oldPasswordController.text == storedPassword;
                            _isOldPasswordIncorrect = !_isOldPasswordValid;
                            _isPasswordValid =
                                newPasswordController.text.length >= 8;
                            _isConfirmPasswordValid =
                                newPasswordController.text ==
                                    confirmPasswordController.text;
                          });

                          if (_isOldPasswordIncorrect ||
                              !_isPasswordValid ||
                              !_isConfirmPasswordValid) {
                            return;
                          }
                          await prefs.remove('matKhau');
                          await prefs.setString(
                              'matKhau', newPasswordController.text);
                         
                          Navigator.pop(context);
                                      Get.dialog(
        thongBaoDialog(text:'Đổi mật khẩu thành công'),
      );
                          final response = await updateMKRepository.doiMK(
                            currentPass: oldPasswordController.text,
                            newPass: newPasswordController.text,
                          );
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
  }

  Widget _buildPasswordTextField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleObscureText,
    bool isPasswordValid = true,
    bool isEmpty = false,
    bool isOldPasswordIncorrect = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Arimo',
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 1.0),
          decoration: BoxDecoration(
            border: Border.all(
                color: (isPasswordValid && !isEmpty) ? Colors.grey : Colors.red,
                width: 0.5),
            borderRadius: BorderRadius.circular(10.0.r),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(
                    obscureText
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: Colors.black,
                  ),
                  onPressed: onToggleObscureText,
                ),
              ),
            ],
          ),
        ),
        if (isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Trường này không được để trống',
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
        if (isOldPasswordIncorrect)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Mật khẩu cũ không đúng',
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
