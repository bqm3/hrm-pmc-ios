import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppConstant {
  static final kSpaceHorizontalVerySmall = 2.0.w;
  static final kSpaceHorizontalSmall = 4.0.w;
  static final kSpaceHorizontalSmallExtra = 8.0.w;
  static final kSpaceHorizontalSmallExtraExtra = 12.0.w;
  static final kSpaceHorizontalSmallExtraExtraExtra = 16.0.w;
  static const kSpaceHorizontalMedium = 20.0;
  static const kSpaceHorizontalMediumExtra = 24.0;
  static final kSpaceHorizontalLarge = 24.0.w;

  static final kSpaceVerticalVerySmall = 2.0.h;
  static final kSpaceVerticalSmall = 4.0.h;
  static final kSpaceVerticalSmallExtra = 8.0.h;
  static final kSpaceVerticalSmallExtraExtra = 12.0.h;
  static final kSpaceVerticalSmallExtraExtraExtra = 16.0.h;
  static final kSpaceVerticalMedium = 20.0.h;
  static final kSpaceVerticalMediumExtra = 24.0.h;
  static final kSpaceVerticalLarge = 60.0.h;

  static double getScreenSizeWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  static double getScreenSizeHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

 
  /// Horizontal
  static final spaceHorizontalVerySmall = SizedBox(
    width: kSpaceHorizontalVerySmall,
  );
  static final spaceHorizontalSmall = SizedBox(
    width: kSpaceHorizontalSmall,
  );
  static final spaceHorizontalSmallExtra = SizedBox(
    width: kSpaceHorizontalSmallExtra,
  );
  static final spaceHorizontalSmallExtraExtra = SizedBox(
    width: kSpaceHorizontalSmallExtraExtra,
  );
  static final spaceHorizontalSmallLarge = SizedBox(
    width: kSpaceHorizontalSmallExtraExtraExtra,
  );
  static const spaceHorizontalMedium = SizedBox(
    width: kSpaceHorizontalMedium,
  );
  static const spaceHorizontalMediumExtra = SizedBox(
    width: kSpaceHorizontalMediumExtra,
  );
  static final spaceHorizontalSmallExtraExtraExtra = SizedBox(
    width: kSpaceHorizontalSmallExtraExtraExtra,
  );

  /// Vertical
  static final spaceVerticalVerySmall = SizedBox(
    height: kSpaceVerticalVerySmall,
  );
  static final spaceVerticalSmall = SizedBox(
    height: kSpaceVerticalSmall,
  );
  static final spaceVerticalSmallMedium = SizedBox(
    height: kSpaceVerticalSmallExtraExtra,
  );
  static final spaceVerticalSmallExtra = SizedBox(
    height: kSpaceVerticalSmallExtra,
  );

  static final spaceVerticalMedium = SizedBox(
    height: kSpaceVerticalMedium,
  );

  static final spaceVerticalMediumExtra = SizedBox(
    height: kSpaceVerticalMediumExtra,
  );
  static final spaceVerticalMax=SizedBox(
    height: kSpaceVerticalLarge,
  );
  static final spaceVerticalSmallExtraExtraExtra = SizedBox(
    height: kSpaceVerticalSmallExtraExtraExtra,
  );
  static final spaceVerticalSafeArea = SizedBox(
    height: AppBar().preferredSize.height + kSpaceVerticalSmallExtraExtra,
  );

  static const videoType = "video";
  static const documentType = "document";
  static const imageType = "image";
  static const websiteType = "website";

  static const loginAdmin = "ADMIN";
  static const loginSale = "SALE";
  static const loginCs = "CS";
  static const loginWareHouse = "WAREHOUSE";

  static const customerTypeAll = "all";
  static const customerTypePhatSinhDoanhThu = "1";
  static const customerTypePhatSinhDoanhThuTrong3T = "2";
  static const customerTypePhatSinhDoanhThuQua3T = "3";
  static const customerTypeKoChamSocQua1T = "4";

  static const otHoaDonBanHang = "1";
  static const otPhieuDatHang = "2";
  static const otNoQuaHan = "3";
  static const otHoaDonXuatHang = "4";

  static const statusDaXuat = 2;

  static const success = "success";
  static const error = "error";
  static const kiem_kho = "-1";
  static const labelFilterCustomDate = "Tuỳ chọn";

  static const emailType = "email";
  static const phoneType = "phone";

  static Icon CONRIM_DELETE_ICON = Icon(
    Icons.notifications_none,
    color: AppColors.red,
    size: 23.sp,
  );
  static const MOI = 0;
  static const DANG_CHAM_SOC = 1;
  static const HOAN_THANH = 2;
  static const DA_HUY = 3;

  static const RAT_KEM = 0;
  static const CHUA_HAI_LONG = 1;
  static const BINH_THUONG = 2;
  static const HAI_LONG = 3;
  static const RAT_HAI_LONG = 4;
  static const LABEL_DA_HOAN_THANH = "Đã hoàn thành";
  static const IMAGE_MAX_FILE_SIZE =
      1; //mb - dung lượng ảnh tối đa có thể upload
  static const FILE_MAX_FILE_SIZE =
      10; //mb - dung lượng tệp tối đa có thể upload
}
