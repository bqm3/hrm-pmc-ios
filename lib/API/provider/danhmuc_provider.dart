import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDanhMucProvider {
  Future<dynamic> getDanhMuc({
    required String table,
    required String parent,
    required String group,
  });
}

class DanhMucProviderAPI implements IDanhMucProvider {
  DanhMucProviderAPI();

  @override
  Future<dynamic> getDanhMuc({
    required String table,
    String? parent,
    String? group,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final urlEndPoint = Uri.parse("${URLHelper.danhMuc}?Table=$table" +
        (parent != null && parent.isNotEmpty ? "&Parent=$parent" : "") +
        (group != null && group.isNotEmpty ? "&Group=$group" : ""));

    return await HttpUtil().get(urlEndPoint.toString());
  }
}
