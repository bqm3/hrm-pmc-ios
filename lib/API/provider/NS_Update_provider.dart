import 'package:get/get_connect/http/src/response/response.dart';
import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get_connect/http/src/response/response.dart' as getResponse;

abstract class NSUpdate {
  Future<dynamic> NSUpdateInfo({required String cot, required String duLieu});
}

class NSUpdateAPI implements NSUpdate {
  final AuthService authService;
  NSUpdateAPI(this.authService);

  @override
  Future<dynamic> NSUpdateInfo(
      {required String cot, required String duLieu}) async {
    final maFromPrefs = await authService.ma;
    final urlEndPoint =
        "${URLHelper.NS_InforUpdate}?Ma=$maFromPrefs&Cot=$cot&Dulieu=$duLieu";

    return await HttpUtil().put(urlEndPoint);
  }
}

abstract class NSUpdate2 {
  Future<dynamic> NSUpdateInfo2(
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

class NSUpdateAPI2 implements NSUpdate2 {
  final AuthService authService;

  NSUpdateAPI2(this.authService);

  @override
  Future<dynamic> NSUpdateInfo2({
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
    final maFromPrefs = await authService.ma;

    final urlEndPoint2 =
        "${URLHelper.NS_UpdateNS}?Ma=$maFromPrefs&NgaySinh=$ngaySinh&NoiSinh=$noiSinh&GioiTinh=$gioiTinh&Dctt=$dctt&Dcll=$dcll&DienThoai=$dienThoai&Email=$email&Cmt=$cmt&NgayCmt=$ngayCmt&NoiCmt=$noiCmt&NganHang=$nganHang&TaiKhoan=$taiKhoan";

    final dio.Response response = await HttpUtil().put(urlEndPoint2);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(
          'API call failed with status code: ${response.statusCode}');
    }
  }
}
