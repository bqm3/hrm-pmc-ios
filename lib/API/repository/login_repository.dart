import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/pages/Home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  static const String baseUrl = 'https://apihrm.pmcweb.vn/api/Auth';

  var isLoggedIn = false.obs;

  Future<bool> login(String ma, String password) async {
    String upperCaseMa = ma.toUpperCase();
    final response = await http.post(
      Uri.parse('$baseUrl/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'ma': ma,
        'matKhau': password,
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.body);
      await prefs.setString('ma', ma);
      await prefs.setString('matKhau', password);
      isLoggedIn.value = true;
      Get.find<HomeController>().fetchUserInfo();
      return true;
    } else {
      print('Đăng nhập không thành công: ${response.body}');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('ma');
    await prefs.remove('matKhau');
    isLoggedIn.value = false;
  }

  Future<String?> get ma async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ma');
  }

  Future<String?> get token async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<AuthService> init() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.containsKey('ma');
    return this;
  }
}
