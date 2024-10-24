import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/model/loaidenghi_model.dart';

Future<List<LoaiDeNghi>> fetchLoaiDeNghi() async {
  final response = await http.get(
    Uri.parse(
        'https://apihrm.pmcweb.vn/api/DanhMuc/GetList?Table=DM_XetDuyet&Parent=1'),
    headers: {'accept': '*/*'},
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => LoaiDeNghi.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load danh mục');
  }
}
