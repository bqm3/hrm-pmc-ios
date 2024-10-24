import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:salesoft_hrm/model/daotao_model.dart';

class LoaiDaoTaoProvider {
  Future<DaoTaoListResponse> getList() async {
    final response = await http
        .get(Uri.parse('https://apihrm.pmcweb.vn/api/DaoTao/GetList'));

    if (response.statusCode == 200) {
      return DaoTaoListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load class list');
    }
  }
}

class DaoTaoListResponse {
  List<LoaiDaoTao>? data;

  DaoTaoListResponse({this.data});

  factory DaoTaoListResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LoaiDaoTao> dataList =
        list.map((i) => LoaiDaoTao.fromJson(i)).toList();

    return DaoTaoListResponse(data: dataList);
  }
}
