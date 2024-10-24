import 'package:salesoft_hrm/API/provider/ns_congtactr_provider.dart';
import 'package:salesoft_hrm/model/ns_congtactr.dart';

abstract class ICongTacTrRepository {
  Future<NsCongtactr?> getCongTacTr({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class CongTacTrRepository implements ICongTacTrRepository {
  final ICongTacTrProvider provider;

  CongTacTrRepository({
    required this.provider,
  });

  @override
  Future<NsCongtactr?> getCongTacTr({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getCongTacTr(
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
