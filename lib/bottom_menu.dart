import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/danhba_provider.dart';
import 'package:salesoft_hrm/API/provider/doica_provider.dart';
import 'package:salesoft_hrm/API/provider/list_chamcong_provider.dart';
import 'package:salesoft_hrm/API/provider/thongbao_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/API/repository/doica_repository.dart';
import 'package:salesoft_hrm/API/repository/list_chamcong_repository.dart';
import 'package:salesoft_hrm/API/repository/login_repository.dart';
import 'package:salesoft_hrm/API/repository/thongbao_repository.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/pages/Home/drawer.dart';
import 'package:salesoft_hrm/pages/Home/home_page.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_controller.dart';
import 'package:salesoft_hrm/pages/ThongBao/thongbao_page.dart';
import 'package:salesoft_hrm/resources/app_resource.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<IDanhBaProvider>(() => DanhBaProviderAPI(), fenix: true);
    Get.lazyPut<IDanhBaRepository>(() => DanhBaRepository(provider: Get.find()),
        fenix: true);
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<IThongBaoProvider>(
        () => ThongBaoProviderAPI(Get.find<AuthService>()),
        fenix: true);

    Get.lazyPut<IThongBaoRepository>(
        () => ThongBaoRepository(provider: Get.find<IThongBaoProvider>()),
        fenix: true);

    Get.lazyPut<ThongBaoController>(
      () => ThongBaoController(
        repository: Get.find<IThongBaoRepository>(),
        authService: Get.find<AuthService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<IListChamCongProvider>(
        () => ListChamCongProviderAPI(Get.find<AuthService>()),
        fenix: true);
    Get.lazyPut<IListChamCongRepository>(
        () => ListChamCongRepository(provider: Get.find()),
        fenix: true);
    Get.lazyPut<IDoiCaProvider>(() => DoiCaProviderAPI(Get.find<AuthService>()),
        fenix: true);
    Get.lazyPut<IDoiCaRepository>(() => DoiCaRepository(provider: Get.find()),
        fenix: true);

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          return Scaffold(
            key: _scaffoldKey,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppResource.icBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  _getPage(controller.pageIndex.value),
                ],
              ),
            ),
            drawer: MyDrawer(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  width: 68.r,
                  height: 68.r,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.blueVNPT2,
                        width: 5.0,
                      ),
                    ),
                    child: FloatingActionButton(
                      backgroundColor: AppColors.blueVNPT,
                      shape: const CircleBorder(),
                      onPressed: () {
                        controller.pageIndex.value = 2;
                        final thongBaoController =
                            Get.find<ThongBaoController>();
                        thongBaoController.fetchListContent();
                      },
                      child: Image.asset(
                        AppResource.icNotification,
                        fit: BoxFit.fitWidth,
                        color: AppColors.blue50,
                        width: 24.r,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: controller.obx((state) {
              return _bottomAppBarView(controller);
            }),
          );
        }),
      ),
    );
  }

  BottomAppBar _bottomAppBarView(MainController controller) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: AppColors.greyBackground,
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppConstant.kSpaceHorizontalMedium,
          right: AppConstant.kSpaceHorizontalMedium,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _NavigationItemView(
              canShowBadge: false,
              label: 'Trang chủ',
              assetName: AppResource.icHome,
              assetColor: AppColors.grey,
              index: 0,
              onPress: () => controller.pageIndex.value = 0,
            ),
            SizedBox(width: 60.w),
            _NavigationItemView(
              canShowBadge: false,
              label: 'Tài khoản',
              index: 1,
              assetName: AppResource.icUser,
              onPress: () {
                controller.pageIndex.value = 0;
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return HomePage();
      case 1:
        return MyDrawer();
      case 2:
        return ThongBaoPage();
      case 3:
        return MyDrawer();
      default:
        return const Center(child: Text('Unknown Page'));
    }
  }
}

class _NavigationItemView extends StatelessWidget {
  final Function()? onPress;
  final String? assetName;
  final IconData? icon;
  final Color? assetColor;
  final String? label;
  final int? index;
  final bool? canShowBadge;
  final int badgeContent;

  const _NavigationItemView({
    Key? key,
    this.onPress,
    this.assetName,
    this.icon,
    this.label,
    this.assetColor,
    this.index = -1,
    this.canShowBadge,
    this.badgeContent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find();

    return Expanded(
      child: InkWellWidget(
        borderRadius: 4,
        padding: const EdgeInsets.only(
          top: 4,
        ),
        onPress: onPress,
        child: SizedBox(
          height: ScreenUtil().bottomBarHeight > 0 ? 40.h : 60.h,
          child: Obx(
            () => Column(
              children: [
                Stack(
                  children: [
                    _buildIcon(controller),
                    Visibility(
                      visible: (canShowBadge == true) && badgeContent != 0,
                      child: Positioned(
                        right: 0,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: 16.r,
                            minHeight: 16.r,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Center(
                            child: Text(
                              badgeContent.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                AppConstant.spaceVerticalSmall,
                Text(
                  label ?? '',
                  style: TextStyle(
                    fontFamily: 'Arimo',
                    fontSize: 10.sp,
                    color: controller.pageIndex.value == index
                        ? AppColors.blueVNPT
                        : AppColors.grey300,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(MainController controller) {
    if (assetName?.isNotEmpty == true) {
      return Container(
        alignment: Alignment.center,
        width: 24.r,
        height: 24.r,
        child: Image.asset(
          assetName ?? '',
          width: 20.r,
          height: 20.r,
          fit: BoxFit.fill,
          color: controller.pageIndex.value == index
              ? AppColors.blueVNPT
              : AppColors.grey,
        ),
      );
    } else {
      return SizedBox(
        width: 20.r,
        height: 20.r,
      );
    }
  }
}
