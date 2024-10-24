import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IXetDuyetProvider {
  Future<dynamic> getXetDuyet(
      {required String tinhTrang, required String loai});
}

class XetDuyetProviderAPI implements IXetDuyetProvider {
  XetDuyetProviderAPI();
  @override
  Future<dynamic> getXetDuyet(
      {required String tinhTrang, required String loai}) async {
    final prefs = await SharedPreferences.getInstance();
    final ma = prefs.getString('ma') ?? '';
    final urlEndPoint =
        "${URLHelper.NS_XetDuyet}?Ma=$ma&TinhTrang=$tinhTrang&Loai=$loai";
    return await HttpUtil().get(urlEndPoint);
  }
}
