import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/provider/doimk_provider.dart';
import 'package:salesoft_hrm/common/app_colors.dart';

abstract class IUpdateMKRepository {
  Future<Map<String, dynamic>> doiMK({
    required String currentPass,
    required String newPass,
  });
}

class NSUpdateMKRepository implements IUpdateMKRepository {
  final DMDoiMK provider;

  NSUpdateMKRepository({
    required this.provider,
  });

  @override
  Future<Map<String, dynamic>> doiMK({
    required String currentPass,
    required String newPass,
  }) async {
    try {
      final http.Response response = await provider.doiMK(
        currentPass: currentPass,
        newPass: newPass,
      );

      print('Mã trạng thái phản hồi từ API: ${response.statusCode}');
      print('Nội dung phản hồi từ API: ${response.body}');

      Map<String, dynamic> jsonResponse;
      try {
        jsonResponse = json.decode(response.body);
      } catch (e) {
        throw Exception('Lỗi phân tích JSON: ${response.body}');
      }

      print('Phản hồi từ API: $jsonResponse');

      if (jsonResponse['status'] == 'Success') {
        return jsonResponse;
      } else {
        throw Exception('Đổi mật khẩu thất bại: ${jsonResponse['message']}');
      }
    } catch (error) {
      print('Lỗi trong quá trình gọi API: $error');
      throw Exception('Lỗi trong quá trình gọi API: $error');
    }
  }
}
