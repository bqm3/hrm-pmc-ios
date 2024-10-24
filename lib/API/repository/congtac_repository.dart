import 'package:salesoft_hrm/API/provider/congtac_provider.dart';
import 'package:salesoft_hrm/model/NSCongtac_model.dart';

abstract class ICongTacRepository {
  Future<NsCongtac?> getCongTac({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class CongTacRepository implements ICongTacRepository {
  final ICongTacProvider provider;

  CongTacRepository({
    required this.provider,
  });

  @override
  Future<NsCongtac?> getCongTac({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getCongTac(
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
