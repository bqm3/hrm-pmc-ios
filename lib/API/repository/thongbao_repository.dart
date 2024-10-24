import 'dart:convert';

import 'package:salesoft_hrm/API/provider/thongbao_provider.dart';
import 'package:salesoft_hrm/model/thongbao_model.dart';

abstract class IThongBaoRepository {
  Future<ThongBao?> getThongBao({
    required int pageSize,
    required int pageIndex,
    String searchTerm = '',
  });
}

class ThongBaoRepository implements IThongBaoRepository {
  final IThongBaoProvider provider;

  ThongBaoRepository({required this.provider});

  @override
  Future<ThongBao?> getThongBao({
    required int pageSize,
    required int pageIndex,
    String searchTerm = '',
  }) async {
    try {
      final response = await provider.getThongBao(
        pageSize: pageSize,
        pageIndex: pageIndex,
      );

      if (response.statusCode == 200) {
        return ThongBao.fromJson(json.decode(response.body));
      } else if (response.statusCode == 204) {
        return null;
      } else {
        throw Exception('Failed to load ThongBao: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during API call: $error');
      return null;
    }
  }
}
