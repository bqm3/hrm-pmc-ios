import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IKyLuatDtProvider {
  Future<dynamic> getKyLuatDt(
      {required String ma, required int pageSize, required int pageIndex});
}

class KyLuatDtProviderAPI implements IKyLuatDtProvider {
  KyLuatDtProviderAPI();

  @override
  Future<dynamic> getKyLuatDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_kyluat}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";

    return await HttpUtil().get(urlEndPoint);
  }
}
