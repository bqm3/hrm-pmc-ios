import 'package:salesoft_hrm/API/provider/loainghi_provider.dart';
import 'package:salesoft_hrm/model/loainghi_model.dart';

abstract class ILoaiNghiRepository {
  Future<List<LoaiNghi>?> getLoaiNghi(
      {required String table, required String parrent});
}

class LoaiNghiRepository implements ILoaiNghiRepository {
  final ILoaiNghiProvider provider;

  LoaiNghiRepository({required this.provider});

  @override
  Future<List<LoaiNghi>?> getLoaiNghi(
      {required String table, required String parrent}) async {
    try {
      final response =
          await provider.getLoaiNghi(table: table, parrent: parrent);
      if (response != null) {
        final loaiNghiList =
            response.map((item) => LoaiNghi.fromJson(item)).toList();
        return loaiNghiList;
      }
    } catch (onError) {
      print('Error during API call: $onError');
      return null;
    }
    return null;
  }
}
