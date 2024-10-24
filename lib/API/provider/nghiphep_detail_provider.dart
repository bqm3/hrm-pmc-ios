import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class INghiPhepDetailProvider {
  Future<dynamic> getNghiPhepDetail(
      {required int id, required String thang, required String nam});
}

class NghiPhepDetailProviderAPI implements INghiPhepDetailProvider {
  NghiPhepDetailProviderAPI();
  @override
  Future<dynamic> getNghiPhepDetail(
      {required int id, required String thang, required String nam}) async {
    final urlEndPoint =
        "${URLHelper.NS_NghiPhepDetail}?Id=$id&Thang=$thang&Nam=$nam";
    return await HttpUtil().get(urlEndPoint);
  }
}
