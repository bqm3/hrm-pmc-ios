import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IDeNghiProvider {
  Future<dynamic> getDeNghi(
      {required int pageSize,
      required int pageIndex,
      required String thang,
      required String nam});
}

class DeNghiProviderAPI implements IDeNghiProvider {
  final AuthService authService;

  DeNghiProviderAPI(this.authService);
  @override
  Future<dynamic> getDeNghi(
      {required int pageSize,
      required int pageIndex,
      required String thang,
      required String nam}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_DeNghi}?PageInpdex=$pageIndex&PageSize=$pageSize&Ma=$maFromPrefs&Thang=$thang&Nam=$nam";
    return await HttpUtil().get(urlEndPoint);
  }
}
