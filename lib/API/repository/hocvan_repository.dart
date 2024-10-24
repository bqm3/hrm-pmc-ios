import 'package:salesoft_hrm/API/provider/hocvan_provider.dart';
import 'package:salesoft_hrm/API/provider/quanhe_provider.dart';
import 'package:salesoft_hrm/model/hocvan_model.dart';

abstract class IHocVanRepository {
  Future<hocvan?> getHocVan({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class HocVanRepository implements IHocVanRepository {
  final IHocVanProvider provider;
  HocVanRepository({
    required this.provider,
  });
  @override
  Future<hocvan?> getHocVan({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response =
          await provider.getHocVan(pageSize: pageSize, pageIndex: pageIndex);
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
