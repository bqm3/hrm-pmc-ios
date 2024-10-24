import 'package:salesoft_hrm/API/provider/danhba_dt/congtactr_detail_provider.dart';
import 'package:salesoft_hrm/model/ns_congtactr.dart';

abstract class ICongTacTrDtRepository {
  Future<NsCongtactr?> getCongTacTrDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class CongTacTrDtRepository implements ICongTacTrDtRepository {
  final ICongTacTrDtProvider provider;

  CongTacTrDtRepository({
    required this.provider,
  });

  @override
  Future<NsCongtactr?> getCongTacTrDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getCongTacTrDt(
        pageSize: pageSize,
        pageIndex: pageIndex,
        ma: ma,
      );

      if (response != null) {
        return NsCongtactr.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}
