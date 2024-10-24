import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';
import 'package:salesoft_hrm/model/not_approved_model.dart';

abstract class IApprovedProvider {
  Future<Approved> getApproved({required String ma});
}

class ApprovedProviderAPI implements IApprovedProvider {
  final AuthService authService;

  ApprovedProviderAPI(this.authService);

  @override
  Future<Approved> getApproved({required String ma}) async {
    final maFromPrefs = await authService.ma;
    if (maFromPrefs != null) {
      final urlEndPoint =
          "${URLHelper.NS_NotApproved}?Ma=$maFromPrefs&TinhTrang=0";
      try {
        final response = await HttpUtil().get(urlEndPoint);
        if (response != null && response is Map<String, dynamic>) {
          return Approved.fromJson(response);
        } else {
          print('Invalid response format: $response');
          return Approved();
        }
      } catch (error) {
        print('Error fetching Nhan Su info: $error');
        return Approved();
      }
    } else {
      print('User not logged in');
      return Approved();
    }
  }
}
