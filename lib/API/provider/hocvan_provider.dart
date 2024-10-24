import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IHocVanProvider {
  Future<dynamic> getHocVan({required int pageSize, required int pageIndex});
}

class HocVanProviderAPI implements IHocVanProvider {
  final AuthService authService;

  HocVanProviderAPI(this.authService);
  @override
  Future<dynamic> getHocVan(
      {required int pageSize, required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_hocvan}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";
    return await HttpUtil().get(urlEndPoint);
  }
}
