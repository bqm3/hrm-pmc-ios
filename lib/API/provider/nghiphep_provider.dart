import 'package:http/http.dart' as http;
import 'dart:convert';

class NghiPhepProviderAPI {
  Future<void> postNghiPhep({
    required String tuNgay,
    required String denNgay,
    required String buoiNghi,
    required String loaiNghi,
    required String ngayDangKy,
    required String lyDo,
    required String ma,
  }) async {
    const urlEndPoint = "https://apihrm.pmcweb.vn/api/NghiPhep/DangKyNghi";

    final url = Uri.parse('$urlEndPoint'
        '?LoaiNghi=${Uri.encodeComponent(loaiNghi)}'
        '&Ma=${Uri.encodeComponent(ma)}'
        '&NgayDangKy=${Uri.encodeComponent(ngayDangKy)}'
        '&TuNgay=${Uri.encodeComponent(tuNgay)}'
        '&DenNgay=${Uri.encodeComponent(denNgay)}'
        '&BuoiNghi=${Uri.encodeComponent(buoiNghi)}'
        '&LyDo=${Uri.encodeComponent(lyDo)}');

    try {
      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Đăng ký nghỉ thành công');
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error posting data: $e');
      rethrow;
    }
  }
}
