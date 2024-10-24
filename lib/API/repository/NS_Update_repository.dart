import 'package:salesoft_hrm/API/provider/NS_Update_provider.dart';

abstract class IUpdateInfoRepository {
  Future<dynamic> NSUpdateAPI({
    required String cot,
    required String duLieu,
  });
}

class NSUpdateInfoRepository implements IUpdateInfoRepository {
  final NSUpdate provider;

  NSUpdateInfoRepository({
    required this.provider,
  });

  @override
  Future<dynamic> NSUpdateAPI({
    required String cot,
    required String duLieu,
  }) async {
    try {
      final response = await provider.NSUpdateInfo(cot: cot, duLieu: duLieu);
      return response;
    } catch (error) {
      print('Error during API call: $error');
      throw Exception('Error during API call: $error');
    }
  }
}

abstract class IUpdateNSRepository {
  Future<dynamic> NSUpdateAPI2(
      {required String ngaySinh,
      required String noiSinh,
      required String gioiTinh,
      required String dienThoai,
      required String dctt,
      required String dcll,
      required String email,
      required String cmt,
      required String ngayCmt,
      required String noiCmt,
      required String nganHang,
      required String taiKhoan});
}

class NSUpdateNSRepository implements IUpdateNSRepository {
  final NSUpdate2 provider2;

  NSUpdateNSRepository({
    required this.provider2,
  });

  @override
  Future<dynamic> NSUpdateAPI2({
    required String ngaySinh,
    required String noiSinh,
    required String gioiTinh,
    required String dienThoai,
    required String dctt,
    required String dcll,
    required String email,
    required String cmt,
    required String ngayCmt,
    required String noiCmt,
    required String nganHang,
    required String taiKhoan,
  }) async {
    try {
      final response2 = await provider2.NSUpdateInfo2(
        ngaySinh: ngaySinh,
        noiSinh: noiSinh,
        gioiTinh: gioiTinh,
        dienThoai: dienThoai,
        dctt: dctt,
        dcll: dcll,
        email: email,
        cmt: cmt,
        ngayCmt: ngayCmt,
        noiCmt: noiCmt,
        nganHang: nganHang,
        taiKhoan: taiKhoan,
      );

      if (response2 != null) {
        return response2; // Trả về kết quả thành công
      } else {
        throw Exception('API response was null');
      }
    } catch (error) {
      print('Error during API call: $error');
      throw Exception('Error during API call: $error');
    }
  }
}
