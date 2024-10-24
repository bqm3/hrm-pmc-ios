import 'package:salesoft_hrm/API/provider/calamviec_provider.dart';
import 'package:salesoft_hrm/model/calamviec_model.dart';

abstract class ICaLamRepository {
  Future<CaLamList?> getCaLam();
}

class CaLamRepository implements ICaLamRepository {
  final ICaLamProvider provider;

  CaLamRepository({required this.provider});

  @override
  Future<CaLamList?> getCaLam() async {
    try {
      final response = await provider.getCaLam();
      if (response != null) {
        final danhSachCaLam = CaLamList.fromJson(response).caLamList;

        // Không lọc theo ngày, trả về toàn bộ danh sách
        return CaLamList(caLamList: danhSachCaLam);
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi trong quá trình gọi API: $e');
      return null;
    }
  }
}
