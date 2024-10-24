import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/widgets/dialog_thanhcong.dart';
import 'package:salesoft_hrm/widgets/dialog_thatbai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MKMoiDialog extends StatefulWidget {
  final String maNhanSu;

  MKMoiDialog({required this.maNhanSu});
  @override
  _MKMoiDialogState createState() => _MKMoiDialogState();
}

class _MKMoiDialogState extends State<MKMoiDialog> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmPassword = true;

  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isNewPasswordEmpty = false;
  bool _isConfirmPasswordEmpty = false;
  Future<void> _updatePassword(String newPassword) async {
    final ma = widget.maNhanSu;
    final url = Uri.parse(
        'https://apihrm.pmcweb.vn/api/NhanSu/ForgotPassword?Ma=$ma&NewPass=$newPassword');

    final response = await http.put(url, headers: {
      'accept': '*/*',
    });

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'Success') {
        Get.dialog(
          thongBaoDialog(
            text: responseData['message'] ?? 'Cập nhật mật khẩu mới thành công',
          ),
        );
      } else {
        Get.dialog(
          thongBaoDialog2(
            text: responseData['message'] ?? 'Có lỗi xảy ra',
          ),
        );
      }
    } else {
      Get.dialog(
        thongBaoDialog2(
          text: 'Lỗi kết nối tới server',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          final newPassword = newPasswordController.text;
                          final confirmPassword =
                              confirmPasswordController.text;

                          if (newPassword.isEmpty || confirmPassword.isEmpty) {
                            setState(() {
                              _isNewPasswordEmpty = newPassword.isEmpty;
                              _isConfirmPasswordEmpty = confirmPassword.isEmpty;
                            });
                            return;
                          }

                          if (newPassword.length < 8) {
                            setState(() {
                              _isPasswordValid = false;
                            });
                            return;
                          } else {
                            setState(() {
                              _isPasswordValid = true;
                            });
                          }

                          if (newPassword != confirmPassword) {
                            setState(() {
                              _isConfirmPasswordValid = false;
                            });
                            return;
                          } else {
                            setState(() {
                              _isConfirmPasswordValid = true;
                            });
                          }

                          Navigator.pop(context);
                          await _updatePassword(newPassword);
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
