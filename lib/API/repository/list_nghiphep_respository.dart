import 'package:salesoft_hrm/API/provider/list_nghiphep_provider.dart';
import 'package:salesoft_hrm/model/list_nghiphep_model.dart';

abstract class IListNghiPhepRepository {
  Future<ListNghiPhep?> getListNghiPhep(
      {required int pageIndex,
      required int pageSize,
      required String loaiNghi,
      required String ma,
      required String thang,
      required String nam,
      required String tinhTrang});
}

class ListNghiPhepRepository implements IListNghiPhepRepository {
  final IListNghiPhepProvider provider;
  ListNghiPhepRepository({
    required this.provider,
  });
  @override
  Future<ListNghiPhep?> getListNghiPhep(
      {required int pageIndex,
      required int pageSize,
      required String loaiNghi,
      required String ma,
      required String thang,
      required String nam,
      required String tinhTrang}) async {
    try {
      final response = await provider.getListNghiPhep(
          ma: ma,
          thang: thang,
          nam: nam,
          pageIndex: pageIndex,
          pageSize: pageSize,
          tinhTrang: tinhTrang,
          loaiNghi: loaiNghi);
      if (response != null) {
        if (response is Map<String, dynamic>) {
          return ListNghiPhep.fromJson(response);
        } else {
          throw Exception('Invalid response format');
        }
      }
    } catch (onError) {
      print('Error during API call: $onError');
      return null;
    }
    return null;
  }
}
