import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_controller.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_item.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';

class DanhBaPage extends StatelessWidget {
  DanhBaPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DanhBaController());
    void _reloadData() {
      controller.fetchListContent();
    }

    searchController.addListener(() {
      controller.searchDanhBa(searchController.text);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.05,
        ),
        const SizedBox(height: 30),
        Container(
          padding: EdgeInsets.only(
              left: AppConstant.getScreenSizeWidth(context) * 0.02),
          width: AppConstant.getScreenSizeWidth(context) * 0.98,
          child: SearchBar(
            controller: searchController,
            hintText: 'Tìm kiếm...',
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: controller.obx(
            (contentDisplay) {
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: false,
                enablePullUp: true,
                onRefresh: () => {controller.fetchListContent()},
                onLoading: () =>
                    {controller.fetchListContent(isLoadMore: true)},
                child: ListView.builder(
                  itemCount: contentDisplay?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return DanhBaItemView(
                      kh: contentDisplay?.data?[index].kh,
                      hoDem: contentDisplay?.data?[index].hoDem,
                      ten: contentDisplay?.data?[index].ten,
                      phongban: contentDisplay?.data?[index].phongBan,
                      email: contentDisplay?.data?[index].email,
                      dienThoai: contentDisplay?.data?[index].dienThoai,
                      gioiTinh: contentDisplay?.data?[index].gioiTinh,
                      ma: contentDisplay?.data?[index].ma,
                    );
                  },
                ),
              );
            },
            onEmpty: EmptyDataWidget(
              onReloadData: _reloadData,
            ),
          ),
        ),
      ],
    );
  }
}
