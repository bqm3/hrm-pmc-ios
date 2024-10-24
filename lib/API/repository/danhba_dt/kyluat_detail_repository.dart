import 'package:salesoft_hrm/API/provider/danhba_dt/kyluat_detail_provider.dart';
import 'package:salesoft_hrm/model/kyluat_model.dart';

abstract class IKyLuatDtRepository {
  Future<Kyluat?> getKyLuatDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class KyLuatDtRepository implements IKyLuatDtRepository {
  final IKyLuatDtProvider provider;

  KyLuatDtRepository({
    required this.provider,
  });

  @override
  Future<Kyluat?> getKyLuatDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getKyLuatDt(
        pageSize: pageSize,
        pageIndex: pageIndex,
        ma: ma,
      );

      if (response != null) {
        return Kyluat.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}
