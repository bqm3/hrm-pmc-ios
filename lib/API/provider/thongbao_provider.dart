import 'package:http/http.dart' as http;
import 'package:salesoft_hrm/API/repository/login_repository.dart';

abstract class IThongBaoProvider {
  Future<http.Response> getThongBao(
      {required int pageSize, required int pageIndex});
}

class ThongBaoProviderAPI implements IThongBaoProvider {
  final AuthService authService;

  ThongBaoProviderAPI(this.authService);

  @override
  Future<http.Response> getThongBao({
    required int pageSize,
    required int pageIndex,
  }) async {
    final maFromPrefs = await authService.ma;
    final urlEndPoint =
        "https://apihrm.pmcweb.vn/api/ThongBao/GetList?PageSize=$pageSize&PageIndex=$pageIndex&Ma=$maFromPrefs";

    final response = await http.get(Uri.parse(urlEndPoint));
    return response;
  }
}
