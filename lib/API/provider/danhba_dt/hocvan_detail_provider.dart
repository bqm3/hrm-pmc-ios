import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IHocVanDtProvider {
  Future<dynamic> getHocVanDt(
      {required int pageSize, required int pageIndex, required String ma});
}

class HocVanDtProviderAPI implements IHocVanDtProvider {
  HocVanDtProviderAPI();
  @override
  Future<dynamic> getHocVanDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_hocvan}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";
    return await HttpUtil().get(urlEndPoint);
  }
}
