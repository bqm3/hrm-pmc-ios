import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/model/danhba_model.dart';

class DanhBaController extends GetxController with StateMixin<Danhba> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  Danhba? contentDisplay;
  Danhba? originalContentDisplay;
  int pageIndex = 1;
  int pageSize = 30;
  String removeDiacritics(String str) {
  final withDiacritics = 'àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ'
      'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴÈÉẸẺẼÊỀẾỆỂỄÌÍỊỈĨÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠÙÚỤỦŨƯỪỨỰỬỮỲÝỴỶỸĐ';
  final withoutDiacritics = 'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyd'
      'AAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD';

  return str.split('').map((char) {
    final index = withDiacritics.indexOf(char);
    if (index != -1) {
      return withoutDiacritics[index];
    }
    return char;
  }).join('');
}


  final IDanhBaRepository _repository = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchListContent();
  }

  void fetchListContent({bool isLoadMore = false}) async {
  if (!isLoadMore) {
    pageIndex = 1; 
    contentDisplay = null;
    refreshController.resetNoData(); 
  }

  final result = await _repository.getDanhBa(
    pageSize: pageSize,
    pageIndex: pageIndex,
  );

  print('Kết quả API: $result');

  if (result != null) {
    if (isLoadMore) {
      contentDisplay?.data?.addAll(result.data ?? []);
    } else {
      contentDisplay = result; 
      originalContentDisplay = result; 
    }

    refreshController.loadComplete(); 
    pageIndex++; 
    if (contentDisplay!.data!.isEmpty) {
      change(contentDisplay, status: RxStatus.empty()); 
    } else {
      change(contentDisplay, status: RxStatus.success());
    }
  } else {
    refreshController.loadNoData(); 
  }
}


void searchDanhBa(String query) { 
  if (query.isEmpty) {
    contentDisplay = originalContentDisplay;
  } else {
    final normalizedQuery = removeDiacritics(query.toLowerCase());
    final filteredData = originalContentDisplay?.data?.where((item) {
      final name = removeDiacritics('${item.hoDem} ${item.ten}'.toLowerCase());
      final id = item.ma?.toLowerCase() ?? '';
      return name.contains(normalizedQuery) || id.startsWith(normalizedQuery);
    }).toList();
    contentDisplay = Danhba(data: filteredData);
  }
  change(contentDisplay, status: RxStatus.success());
}


}
