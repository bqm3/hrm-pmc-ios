import 'package:salesoft_hrm/API/provider/quanhe_provider.dart';
import 'package:salesoft_hrm/model/quanhe_model.dart';

abstract class IQuanHeRepository {
  Future<Quanhe?> getQuanHe({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class QuanHeRepository implements IQuanHeRepository {
  final IQuanHeProvider provider;
  QuanHeRepository({
    required this.provider,
  });
  @override
  Future<Quanhe?> getQuanHe({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getQuanHe(
          pageSize: pageSize, pageIndex: pageIndex, ma: ma);
    if (response != null) {
        if (response is Map<String, dynamic>) {
          return Quanhe.fromJson(response);
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
