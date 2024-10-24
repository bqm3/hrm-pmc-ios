import 'package:salesoft_hrm/API/provider/danhba_dt/hocvan_detail_provider.dart';
import 'package:salesoft_hrm/model/hocvan_model.dart';

abstract class IHocVanDtRepository {
  Future<hocvan?> getHocVanDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class HocVanDtRepository implements IHocVanDtRepository {
  final IHocVanDtProvider provider;
  HocVanDtRepository({
    required this.provider,
  });
  @override
  Future<hocvan?> getHocVanDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getHocVanDt(
          pageSize: pageSize, pageIndex: pageIndex, ma: ma);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return hocvan.fromJson(response);
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
