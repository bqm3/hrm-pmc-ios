import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class ILoaiNghiProvider {
  Future<List<dynamic>?> getLoaiNghi(
      {required String table, required String parrent});
}

class LoaiNghiProviderAPI implements ILoaiNghiProvider {
  @override
  Future<List<dynamic>?> getLoaiNghi(
      {required String table, required String parrent}) async {
    final urlEndPoint = "${URLHelper.DM_LoaiNghi}?Table=$table&Parent=$parrent";
    final response = await HttpUtil().get(urlEndPoint);
    return response as List<dynamic>;
  }
}
