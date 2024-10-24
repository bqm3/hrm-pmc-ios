import 'package:http/http.dart' as http;
import 'dart:convert';

class PostDeNghiProviderAPI {
  Future<void> postDeNghi({
    required String xetDuyet,
    required String noiDung,
    required String soTien,
    required String thoiGian,
    required String lyDo,
    required String ma,
  }) async {
    const urlEndPoint = "https://apihrm.pmcweb.vn/api/NhanSuDN/Create";

    final url = Uri.parse('$urlEndPoint'
        '?XetDuyet=${Uri.encodeComponent(xetDuyet)}'
        '&Ma=${Uri.encodeComponent(ma)}'
        '&NoiDung=${Uri.encodeComponent(noiDung)}'
        '&SoTien=${Uri.encodeComponent(soTien)}'
        '&ThoiGian=${Uri.encodeComponent(thoiGian)}'
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
        print('Đề xuất thành công');
      } else {
        throw Exception('Failed to post data');
      }
    } catch (e) {
      print('Error posting data: $e');
      rethrow;
    }
  }
}
