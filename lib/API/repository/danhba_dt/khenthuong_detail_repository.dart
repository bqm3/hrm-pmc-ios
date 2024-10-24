import 'package:salesoft_hrm/API/provider/danhba_dt/khenthuong_detail_provider.dart';
import 'package:salesoft_hrm/model/khenthuong_model.dart';

abstract class IKhenThuongDtRepository {
  Future<Khenthuong?> getKhenThuongDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class KhenthuongDtRepository implements IKhenThuongDtRepository {
  final IKhenThuongDtProvider provider;

  KhenthuongDtRepository({
    required this.provider,
  });

  @override
  Future<Khenthuong?> getKhenThuongDt({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getKhenThuongDt(
        pageSize: pageSize,
        pageIndex: pageIndex,
        ma: ma,
      );

      if (response != null) {
        return Khenthuong.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}
