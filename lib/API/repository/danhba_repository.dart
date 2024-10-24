import 'package:salesoft_hrm/API/provider/danhba_provider.dart';
import 'package:salesoft_hrm/model/danhba_model.dart';

abstract class IDanhBaRepository {
  Future<Danhba> getDanhBa({
    required int pageSize,
    required int pageIndex,
    String searchTerm = '',
  });
}

class DanhBaRepository implements IDanhBaRepository {
  final IDanhBaProvider provider;
  DanhBaRepository({
    required this.provider,
  });
  @override
  Future<Danhba> getDanhBa({
    required int pageSize,
    required int pageIndex,
    String searchTerm = '',
  }) async {
    final response =
        provider.getDanhBa(pageSize: pageSize, pageIndex: pageIndex);

    return response.then<Danhba>((value) {
      if (value != null) {
        return Future<Danhba>.value(Danhba.fromJson(value));
      } else {
        return Future<Danhba>.value();
      }
    }).catchError((onError) {
      print('Error during API call: $onError');
      return Future<Danhba>.value();
    });
  }
}
