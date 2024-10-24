import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salesoft_hrm/API/provider/thongbao_provider.dart';
import 'package:salesoft_hrm/API/repository/thongbao_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_controller.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_detail.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_item.dart';
import 'package:salesoft_hrm/widgets/empty_data_widget.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';

class ThongBaoPage extends StatelessWidget {
  ThongBaoPage({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThongBaoController(
      repository:
          ThongBaoRepository(provider: ThongBaoProviderAPI(AuthService())),
      authService: AuthService(),
    ));
    void _reloadData() {
      controller.fetchListContent();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConstant.getScreenSizeHeight(context) * 0.05,
        ),
        const SizedBox(height: 10),
        Row(children: [
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: Text(
              'Thông báo',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.4,
                  ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () => _showSettingsBottomSheet(context),
              child: const FaIcon(
                FontAwesomeIcons.cog,
                color: Colors.white,
              ),
            ),
          ),
        ]),
        Expanded(
          child: controller.obx(
            (contentDisplay) {
              return SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: () async {
                  controller.fetchListContent();
                  controller.refreshController.refreshCompleted();
                },
                child: ListView.builder(
                  itemCount: contentDisplay?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final idThongBao = contentDisplay?.data?[index].idThongBao;
                    return ThongBaoItemView(
                      tieuDe: contentDisplay?.data?[index].tieuDe,
                      noiDung: contentDisplay?.data?[index].noiDung,
                      date1: contentDisplay?.data?[index].date1,
                      daXem: contentDisplay?.data?[index].daXem,
                      idThongBao: idThongBao,
                      onTap: (tieuDe, noiDung, date1) {
                        if (tieuDe != null) {
                          controller.markAsRead(tieuDe, noiDung!).then((_) {
                            Get.to(() => ThongBaoDetailPage(
                                  tieuDe: tieuDe,
                                  noiDung: noiDung,
                                  date1: date1,
                                ));
                            controller.fetchListContent();
                          });
                        }
                      },
                    );
                  },
                ),
              );
            },
            onEmpty: EmptyDataWidget(
              onReloadData: _reloadData,
            ),
            onError: (error) => Center(child: Text('Có lỗi xảy ra: $error')),
          ),
        ),
      ],
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    final controller = Get.find<ThongBaoController>();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const FaIcon(
                  FontAwesomeIcons.envelopeOpen,
                  color: Colors.black,
                ),
                title: const Text('Đánh dấu tất cả là đã đọc'),
                onTap: () async {
                  await controller.markAsRead2();
                  controller.fetchListContent();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
