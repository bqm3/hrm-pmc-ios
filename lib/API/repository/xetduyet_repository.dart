import 'dart:convert';

import 'package:salesoft_hrm/API/provider/xetduyet_provider.dart';
import 'package:salesoft_hrm/model/xetduyet_model.dart';

abstract class IXetDuyetRepository {
  Future<List<XetDuyet>?> getXetDuyet(
      {required String tinhTrang, required String loai});
}

class XetDuyetRepository implements IXetDuyetRepository {
  final IXetDuyetProvider provider;

  XetDuyetRepository({
    required this.provider,
  });

  @override
  Future<List<XetDuyet>?> getXetDuyet(
      {required String tinhTrang, required String loai}) async {
    try {
      final response = await provider.getXetDuyet(
        tinhTrang: tinhTrang,
        loai: loai,
      );

      if (response != null) {
        if (response is String) {
          final List<dynamic> jsonResponse = jsonDecode(response);
          return List<XetDuyet>.from(
              jsonResponse.map((item) => XetDuyet.fromJson(item)));
        } else if (response is List<dynamic>) {
          return List<XetDuyet>.from(
              response.map((item) => XetDuyet.fromJson(item)));
        } else {
          print('Unexpected response type: ${response.runtimeType}');
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}
