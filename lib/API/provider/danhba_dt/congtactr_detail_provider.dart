import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ICongTacTrDtProvider {
  Future<dynamic> getCongTacTrDt(
      {required String ma, required int pageSize, required int pageIndex});
}

class CongTacTrDtProviderAPI implements ICongTacTrDtProvider {
  CongTacTrDtProviderAPI();

  @override
  Future<dynamic> getCongTacTrDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_congtactr}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";

    return await HttpUtil().get(urlEndPoint);
  }
}
