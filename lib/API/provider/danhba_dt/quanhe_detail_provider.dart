import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IQuanHeDtProvider {
  Future<dynamic> getQuanHeDt(
      {required String ma, required int pageSize, required int pageIndex});
}

class QuanHeDtProviderAPI implements IQuanHeDtProvider {
  @override
  Future<dynamic> getQuanHeDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_quanhe}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";
    return await HttpUtil().get(urlEndPoint);
  }
}
