import 'package:salesoft_hrm/API/provider/danhba_dt/quanhe_detail_provider.dart';

import 'package:salesoft_hrm/model/quanhe_model.dart';

abstract class IQuanHeDtRepository {
  Future<Quanhe?> getQuanHeDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class QuanHeDtRepository implements IQuanHeDtRepository {
  final IQuanHeDtProvider provider;
  QuanHeDtRepository({
    required this.provider,
  });
  @override
  Future<Quanhe?> getQuanHeDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getQuanHeDt(
          pageSize: pageSize, pageIndex: pageIndex, ma: ma);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return Quanhe.fromJson(response);
        } else {
          throw Exception('Invalid response format');
        }
      }
    } catch (onError) {
      print('Error during API call: $onError');
      return null;
    }
    return null;
  }
}
