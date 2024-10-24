import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
  var userName = ''.obs;
  var password = ''.obs;
  var passwordVisible = true.obs;
  var userNameError = RxnString();
  var passwordError = RxnString();

  bool isValidateInfo() {
    bool isValid = true;
    if (userName.value.trim().isEmpty) {
      userNameError.value = "Mã đăng nhập không được để trống";
      isValid = false;
    } else {
      userNameError.value = null;
    }

    if (password.value.trim().isEmpty) {
      passwordError.value = "Mật khẩu không được để trống";
      isValid = false;
    } else {
      passwordError.value = null;
    }

    return isValid;
  }

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    update();
  }

  bool getPasswordVisible() {
    return passwordVisible.value;
  }

  void clearPassword() {
    password.value = '';
  }

  void setErrors() {
    if (userName.value.trim().isEmpty) {
      userNameError.value = "Mã đăng nhập không được để trống";
    }
    if (password.value.trim().isEmpty) {
      passwordError.value = "Mật khẩu không được để trống";
    }
  }
}

class TokenController extends GetxController {
  var fcmToken = ''.obs;

  void setToken(String token) {
    fcmToken.value = token;
  }

  String? getToken() {
    return fcmToken.value.isNotEmpty ? fcmToken.value : null;
  }
}
