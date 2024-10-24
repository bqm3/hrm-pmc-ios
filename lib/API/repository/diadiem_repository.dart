import 'package:salesoft_hrm/API/provider/diadiem_provider.dart';
import 'package:salesoft_hrm/model/diadiem_model.dart';

abstract class IDiaDiemRepository {
  Future<DiaDiemList?> getDiaDiem();
}

class DiaDiemRepository implements IDiaDiemRepository {
  final IDiaDiemProvider provider;

  DiaDiemRepository({required this.provider});

  @override
  Future<DiaDiemList?> getDiaDiem() async {
    try {
      final response = await provider.getDiaDiem();
      if (response != null) {
        return DiaDiemList.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi trong quá trình gọi API: $e');
      return null;
    }
  }
}
