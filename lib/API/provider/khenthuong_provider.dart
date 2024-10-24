  import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IKhenThuongProvider {
  Future<dynamic> getKhenThuong(
      {required String ma, required int pageSize, required int pageIndex});
}

class KhenThuongProviderAPI implements IKhenThuongProvider {
  final AuthService authService;

  KhenThuongProviderAPI(this.authService);

  @override
  Future<dynamic> getKhenThuong(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_khenthuong}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";

    return await HttpUtil().get(urlEndPoint);
  }
}
abstract class IKyLuatProvider {
  Future<dynamic> getKyLuat(
      {required String ma, required int pageSize, required int pageIndex});
}

class KyLuatProviderAPI implements IKyLuatProvider {
  final AuthService authService;

  KyLuatProviderAPI(this.authService);

  @override
  Future<dynamic> getKyLuat(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_kyluat}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";

    return await HttpUtil().get(urlEndPoint);
  }
}
