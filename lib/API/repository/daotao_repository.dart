import 'package:salesoft_hrm/API/provider/daotao_provider.dart';
import 'package:salesoft_hrm/model/daotao_model.dart';

abstract class IDaoTaoRepository {
  Future<DaoTao?> getDaoTao({
    required String ma,
    required String thang,
    required String nam,
  });
}

class DaoTaoRepository implements IDaoTaoRepository {
  final IDaoTaoProvider provider;
  DaoTaoRepository({
    required this.provider,
  });
  @override
  Future<DaoTao?> getDaoTao({
    required String ma,
    required String thang,
    required String nam,
  }) async {
    try {
      final response = await provider.getDaoTao(ma: ma, thang: thang, nam: nam);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return DaoTao.fromJson(response);
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
