import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ICongTacDtProvider {
  Future<dynamic> getCongTacDt(
      {required String ma, required int pageSize, required int pageIndex});
}

class CongTacDtProviderAPI implements ICongTacDtProvider {
  CongTacDtProviderAPI();

  @override
  Future<dynamic> getCongTacDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_congtac}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";

    return await HttpUtil().get(urlEndPoint);
  }
}
