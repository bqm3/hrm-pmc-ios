import 'package:salesoft_hrm/API/provider/danhba_dt/congtac_detail_provider.dart';
import 'package:salesoft_hrm/model/NSCongtac_model.dart';

abstract class ICongTacDtRepository {
  Future<NsCongtac?> getCongTacDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class CongTacDtRepository implements ICongTacDtRepository {
  final ICongTacDtProvider provider;

  CongTacDtRepository({
    required this.provider,
  });

  @override
  Future<NsCongtac?> getCongTacDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getCongTacDt(
        pageSize: pageSize,
        pageIndex: pageIndex,
        ma: ma,
      );

      if (response != null) {
        return NsCongtac.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}
