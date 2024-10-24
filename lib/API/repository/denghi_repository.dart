import 'package:salesoft_hrm/API/provider/denghi_provider.dart';
import 'package:salesoft_hrm/model/denghi_model.dart';

abstract class IDeNghiRepository {
  Future<DeNghi?> getDeNghi(
      {required int pageSize,
      required int pageIndex,
      required String thang,
      required String nam});
}

class DeNghiRepository implements IDeNghiRepository {
  final IDeNghiProvider provider;
  DeNghiRepository({
    required this.provider,
  });
  @override
  Future<DeNghi?> getDeNghi(
      {required int pageSize,
      required int pageIndex,
      required String thang,
      required String nam}) async {
    try {
      final response = await provider.getDeNghi(
          pageSize: pageSize, pageIndex: pageIndex, thang: thang, nam: nam);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return DeNghi.fromJson(response);
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
