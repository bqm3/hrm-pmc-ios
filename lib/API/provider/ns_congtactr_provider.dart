import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ICongTacTrProvider {
  Future<dynamic> getCongTacTr(
      {required String ma, required int pageSize, required int pageIndex});
}

class CongTacTrProviderAPI implements ICongTacTrProvider {
  final AuthService authService;

  CongTacTrProviderAPI(this.authService);

  @override
  Future<dynamic> getCongTacTr(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.NS_congtactr}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";

    return await HttpUtil().get(urlEndPoint);

    
  }
}
