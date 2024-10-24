import 'package:salesoft_hrm/API/provider/doica_provider.dart';
import 'package:salesoft_hrm/model/doica_model.dart';

abstract class IDoiCaRepository {
  Future<DoiCaResponse> getDoiCa(
      {required String thang,
      required String nam,
      required String tinhtrang,
      required int pageSize,
      required int pageIndex});
}

class DoiCaRepository implements IDoiCaRepository {
  final IDoiCaProvider provider;
  DoiCaRepository({required this.provider});

  @override
  Future<DoiCaResponse> getDoiCa(
      {required String thang,
      required String nam,
      required String tinhtrang,
      required int pageSize,
      required int pageIndex}) async {
    try {
      final response = await provider.getDoiCa(
          thang: thang,
          nam: nam,
          tinhtrang: tinhtrang,
          pageSize: pageSize,
          pageIndex: pageIndex);

      if (response is List<dynamic>) {
        return DoiCaResponse.fromJson(response);
      } else {
        return DoiCaResponse(items: []);
      }
    } catch (e) {
      print('Error during API call: $e');
      return DoiCaResponse(items: []);
    }
  }
}
