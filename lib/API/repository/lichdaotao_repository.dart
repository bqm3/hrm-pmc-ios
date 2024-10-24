import 'package:salesoft_hrm/API/provider/lichdaotao_provider.dart';
import 'package:salesoft_hrm/model/lichdaotao_model.dart';

abstract class ILichDaoTaoRepository {
  Future<LichDaoTao?> getLichDaoTao({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class LichDaoTaoRepository implements ILichDaoTaoRepository {
  final ILichDaoTaoProvider provider;
  LichDaoTaoRepository({
    required this.provider,
  });
  @override
  Future<LichDaoTao?> getLichDaoTao({
    required String ma,
    required int pageIndex,
    required int pageSize,
  }) async {
    try {
      final response = await provider.getLichDaoTao(
          ma: ma, pageSize: pageSize, pageIndex: pageIndex);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return LichDaoTao.fromJson(response);
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
