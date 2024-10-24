import 'package:salesoft_hrm/API/api_config/http_util.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/url_helper.dart';

abstract class IListNghiPhepProvider {
  Future<dynamic> getListNghiPhep(
      {required int pageIndex,
      required int pageSize,
      required String loaiNghi,
      required String ma,
      required String thang,
      required String nam,
      required String tinhTrang});
}

class ListNghiPhepProviderAPI implements IListNghiPhepProvider {
  final AuthService authService;

  ListNghiPhepProviderAPI(this.authService);
  @override
  Future<dynamic> getListNghiPhep(
      {required int pageIndex,
      required int pageSize,
      required String loaiNghi,
      required String ma,
      required String thang,
      required String nam,
      required String tinhTrang}) async {
    final maFromPrefs = await authService.ma;

    final urlEndPoint =
        "${URLHelper.DM_NghiPhep}?PageIndex=$pageIndex&PageSize=$pageSize&Ma=$maFromPrefs&LoaiNghi=$loaiNghi&Thang=$thang&Nam=$nam&TinhTrang=$tinhTrang";
    return await HttpUtil().get(urlEndPoint);
  }
}
