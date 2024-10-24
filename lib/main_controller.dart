
import 'package:get/get.dart';
import 'package:salesoft_hrm/model/app_info.dart';

class MainController extends GetxController with StateMixin<bool> {
  var pageIndex = 0.obs;
  AppInfoModel? appInfo;


  void changePage(int index) {
    pageIndex.value = index;
  }
  var listNotificationUnread = [];

  var isCustomDateFilter = false.obs;

  @override
  void onInit() {
    super.onInit();
      pageIndex.value = 0;
    getAppInfo();
  }




  ///
  /// Lấy thông tin app
  ///
  Future<void> getAppInfo() async {
    if (appInfo != null) {
      this.appInfo = appInfo;
    }

    /// Xử lý nâng cấp version
    final versionServer = double.tryParse(appInfo?.appVersion ?? "1.0.0");

          change(true, status: RxStatus.success());

  }

  ///
  /// Lấy thông tin port
  ///


  
}
