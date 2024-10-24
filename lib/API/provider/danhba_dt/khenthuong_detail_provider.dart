import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IKhenThuongDtProvider {
  Future<dynamic> getKhenThuongDt(
      {required String ma, required int pageSize, required int pageIndex});
}

class KhenThuongDtProviderAPI implements IKhenThuongDtProvider {
  KhenThuongDtProviderAPI();

  @override
  Future<dynamic> getKhenThuongDt(
      {required String ma,
      required int pageSize,
      required int pageIndex}) async {
    final urlEndPoint =
        "${URLHelper.NS_khenthuong}?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$ma";

    return await HttpUtil().get(urlEndPoint);
  }
}
