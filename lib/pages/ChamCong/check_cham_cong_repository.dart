import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckChamCong {
  bool checkCCIn = true;
  bool checkCCOut = false;
  Future<void> checkVao() async {
    final prefs = await SharedPreferences.getInstance();
    final ma = prefs.getString('ma');

    if (ma == null) {
      print('Không tìm thấy mã trong SharedPreferences');
      return;
    }
    final urlEndPoint = '${URLHelper.NS_CheckVao}?Ma=$ma';
    final response = await HttpUtil().post(urlEndPoint, params: {'Ma': ma});

    if (response.statusCode == 200) {
      checkCCIn = false;
    } else if (response.statusCode == 400) {
      checkCCIn = true;
    } else {
      print('Lỗi khi kiểm tra chấm công: ${response.statusCode}');
    }
    print('Giá trị của checkCCIn là: $checkCCIn');
  }
}
