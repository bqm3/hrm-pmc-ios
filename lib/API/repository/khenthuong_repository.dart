import 'package:salesoft_hrm/API/provider/khenthuong_provider.dart';
import 'package:salesoft_hrm/model/NSCongtac_model.dart';
import 'package:salesoft_hrm/model/khenthuong_model.dart';
import 'package:salesoft_hrm/model/kyluat_model.dart';

abstract class IKhenThuongRepository {
  Future<Khenthuong?> getKhenThuong({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class KhenthuongRepository implements IKhenThuongRepository {
  final IKhenThuongProvider provider;

  KhenthuongRepository({
    required this.provider,
  });

  @override
  Future<Khenthuong?> getKhenThuong({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getKhenThuong(
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

abstract class IKyLuatRepository {
  Future<Kyluat?> getKyLuat({
    required String ma,
    required int pageSize,
    required int pageIndex,
  });
}

class KyLuatRepository implements IKyLuatRepository {
  final IKyLuatProvider provider;

  KyLuatRepository({
    required this.provider,
  });

  @override
  Future<Kyluat?> getKyLuat({
    required String ma,
    required int pageSize,
    required int pageIndex,
  }) async {
    try {
      final response = await provider.getKyLuat(
        pageSize: pageSize,
        pageIndex: pageIndex,
        ma: ma,
      );

      if (response != null) {
        return Kyluat.fromJson(response);
      } else {
        return null;
      }
    } catch (e) {
      print('Error during API call: $e');
      return null;
    }
  }
}
