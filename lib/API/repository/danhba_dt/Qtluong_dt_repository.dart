import 'package:salesoft_hrm/API/provider/danhba_dt/Qtluong_detail_provider.dart';
import 'package:salesoft_hrm/model/Qtluong_model.dart';

abstract class ILuongDtRepository {
  Future<Qtluong?> getLuongDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class LuongDtRepository implements ILuongDtRepository {
  final ILuongDtProvider provider;
  LuongDtRepository({
    required this.provider,
  });
  @override
  Future<Qtluong?> getLuongDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getLuongDt(
          pageSize: pageSize, pageIndex: pageIndex, ma: ma);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return Qtluong.fromJson(response);
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
