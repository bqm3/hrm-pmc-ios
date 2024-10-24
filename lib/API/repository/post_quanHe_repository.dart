import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

Future<void> postQuanHe({
  required String quanHe,
  required String hoTen,
  required String ngaySinh,
  required String diaChi,
  required String ngheNghiep,
  required String maSoThue,
  required String soCmt,
  required String ngayCmt,
  required String noiCmt,
}) async {
  final AuthService authService = AuthService();
  final maFromPrefs = await authService.ma;
  final String apiUrl = 'https://apihrm.pmcweb.vn/api/NhanSuQH/Update';
  final uri = Uri.parse(
      '$apiUrl?Ma=$maFromPrefs&QuanHe=$quanHe&HoTen=$hoTen&NgaySinh=$ngaySinh&DiaChi=$diaChi&NgheNghiep=$ngheNghiep&Cmt=$soCmt&NgayCmt=$ngayCmt&NoiCmt=$noiCmt&MaSoThue=$maSoThue');

  print('Request URL: $uri');

  final response = await http.post(
    uri,
    headers: {
      'accept': '*/*',
    },
  );

  final jsonResponse = json.decode(response.body);
  final String message = jsonResponse['message'] ?? 'Lỗi kết nối đến server';

  if (response.statusCode == 200) {
    Get.snackbar('Thông báo', message,
        snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    print('Status: ${jsonResponse['status']}');
  } else if (response.statusCode == 400) {
    Get.snackbar('Thông báo', message,
        snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    print('Request failed with status: ${response.statusCode}.');
  } else {
    Get.snackbar('Thông báo', 'Đã có lỗi xảy ra, vui lòng thử lại.',
        snackPosition: SnackPosition.TOP, backgroundColor: AppColors.blue50);
    print('Request failed with status: ${response.statusCode}.');
    print('Error response: ${response.body}');
  }
}
