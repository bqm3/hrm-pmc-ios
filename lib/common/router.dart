import 'package:get/get.dart';
import 'package:salesoft_hrm/API/provider/danhba_provider.dart';
import 'package:salesoft_hrm/API/repository/danhba_repository.dart';
import 'package:salesoft_hrm/API/repository/thongbao_repository.dart';
import 'package:salesoft_hrm/bottom_menu.dart';
import 'package:salesoft_hrm/main_controller.dart';
import 'package:salesoft_hrm/model/xetduyet_model.dart';
import 'package:salesoft_hrm/pages/BangLuong/bangluong_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/KhenThuong&Kyluat/ktkl_detail_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/QTCongTac/congtac_detail_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/Qtluong/Qtluong_detail_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/danhba_detail_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/information_dt_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_detail/quanhe/quanhe_dt_page.dart';
import 'package:salesoft_hrm/pages/DanhBa/danhba_page.dart';
import 'package:salesoft_hrm/pages/DaoTao/daotao_page.dart';
import 'package:salesoft_hrm/pages/DeNghi/denghi_page.dart';
import 'package:salesoft_hrm/pages/DoiCa/doica_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/KhenThuong&KyLuat/khenthuong_kyluat_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTCongTac/congtac_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QTLuong/Qtluong_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/infomation_page.dart';
import 'package:salesoft_hrm/pages/HoSo/hoso_page.dart';
import 'package:salesoft_hrm/pages/ChamCong/chamcong_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/dangkynghi_page.dart';
import 'package:salesoft_hrm/pages/NghiPhep/nghiphep_page.dart';
import 'package:salesoft_hrm/pages/HoSo/DanhMucHoSo/QuanHe/quanhe_page.dart';
import 'package:salesoft_hrm/pages/XetDuyet/xetduyet_page.dart';

enum ERouter {
  mainPage,
  chamCong,
  hoSo,
  nghiPhep,
  danhBa,
  information,
  information_dt,
  quanhe,
  quanhe_dt,
  qtCongTac,
  qtCongTac_dt,
  ktkl,
  ktkl_dt,
  luong,
  luong_dt,
  danhba_dt,
  xetduyet,
  bangluong,
  daotao,
  denghi,
  doica,
  dknghi,
}

extension ERouterExt on ERouter {
  String get name {
    switch (this) {
      case ERouter.mainPage:
        return "/main_page";
      case ERouter.chamCong:
        return "/cham_cong";
      case ERouter.hoSo:
        return "/ho_so";
      case ERouter.nghiPhep:
        return "/nghiPhep";
      case ERouter.danhBa:
        return "/danhBa";
      case ERouter.information:
        return "/information";
      case ERouter.quanhe:
        return "/quanhe";
      case ERouter.qtCongTac:
        return "/qtCongTac";
      case ERouter.ktkl:
        return "/khenthuongkyluat";
      case ERouter.luong:
        return "/luong";
      case ERouter.danhba_dt:
        return "/danhba_dt";
      case ERouter.information_dt:
        return "/infomation_dt";
      case ERouter.quanhe_dt:
        return "/quanhe_dt";
      case ERouter.luong_dt:
        return "/luong_dt";
      case ERouter.qtCongTac_dt:
        return "/qtCongTac_dt";
      case ERouter.ktkl_dt:
        return "/khenthuongkyluat_dt";
      case ERouter.xetduyet:
        return "/xet_duyet";
      case ERouter.bangluong:
        return "/bang_luong";
      case ERouter.daotao:
        return "/dao_tao";
      case ERouter.denghi:
        return "/denghi";
      case ERouter.doica:
        return "/doica";
      case ERouter.dknghi:
        return "/dknghi";
      default:
        return "/";
    }
  }
}

class RouterPage {
  static final routers = [
    GetPage(
      name: ERouter.mainPage.name,
      page: () => MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: ERouter.chamCong.name,
      page: () => const ChamCongPage(),
    ),
    GetPage(
      name: ERouter.hoSo.name,
      page: () => const HoSoPage(),
    ),
    GetPage(
      name: ERouter.nghiPhep.name,
      page: () => const NghiPhepPage(),
    ),
    GetPage(
      name: ERouter.danhBa.name,
      page: () => DanhBaPage(),
    ),
    GetPage(name: ERouter.information.name, page: () => MyInformation()),
    GetPage(
      name: ERouter.quanhe.name,
      page: () => QuanHePage(),
    ),
    GetPage(
      name: ERouter.qtCongTac.name,
      page: () => CongTacPage(),
    ),
    GetPage(
      name: ERouter.ktkl.name,
      page: () => KTKLPage(),
    ),
    GetPage(
      name: ERouter.luong.name,
      page: () => LuongPage(),
    ),
    GetPage(
      name: ERouter.danhba_dt.name,
      page: () => const danhbaDtPage(),
    ),
    GetPage(
      name: ERouter.information_dt.name,
      page: () => const InformationDtPage(),
    ),
    GetPage(
      name: ERouter.quanhe_dt.name,
      page: () => QuanHeDtPage(),
    ),
    GetPage(
      name: ERouter.luong_dt.name,
      page: () => LuongDtPage(),
    ),
    GetPage(
      name: ERouter.qtCongTac_dt.name,
      page: () => CongTacDtPage(),
    ),
    GetPage(
      name: ERouter.ktkl_dt.name,
      page: () => KTKLDTPage(),
    ),
    GetPage(
      name: ERouter.xetduyet.name,
      page: () => const XetDuyetPage(),
    ),
    GetPage(
      name: ERouter.bangluong.name,
      page: () => const BangLuongPage(),
    ),
    GetPage(
      name: ERouter.daotao.name,
      page: () => const DaoTaoPage(),
    ),
    GetPage(
      name: ERouter.denghi.name,
      page: () => DeNghiPage(),
    ),
    GetPage(
      name: ERouter.doica.name,
      page: () => DoiCaPage(),
    ),
    GetPage(
      name: ERouter.dknghi.name,
      page: () => dkNghiPage(),
    )
  ];
}

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IDanhBaProvider>(
      () => DanhBaProviderAPI(),
      fenix: true,
    );
    Get.lazyPut<IDanhBaRepository>(
      () => DanhBaRepository(provider: Get.find()),
      fenix: true,
    );
    Get.lazyPut<IThongBaoRepository>(
      () => ThongBaoRepository(provider: Get.find()),
      fenix: true,
    );
    Get.put(MainController());
  }
}
