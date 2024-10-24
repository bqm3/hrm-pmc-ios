import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ICongTacProvider {
  Future<dynamic> getCongTac(
      {required String ma, required int pageSize, required int pageIndex});
}

class CongTacProviderAPI implements ICongTacProvider {
  final AuthService authService;

  CongTacProviderAPI(this.authService);

  @override
  Future<dynamic> getCongTac(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_congtac}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";

    return await HttpUtil().get(urlEndPoint);
  }
}
