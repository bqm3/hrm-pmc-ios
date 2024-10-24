import 'package:get/get.dart';

class FilterDateController extends GetxController with StateMixin<bool> {
  var isCustomDateFilter = false.obs;
  DateTime? customFromDate, customToDate;
  @override
  void onInit() {
    super.onInit();
    change(true, status: RxStatus.success());
  }
}
