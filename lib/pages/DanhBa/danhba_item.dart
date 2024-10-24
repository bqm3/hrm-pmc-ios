import 'package:flutter/material.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DanhBaItemView extends StatelessWidget {
  final String? kh;
  final String? hoDem;
  final String? ten;
  final String? phongban;
  final String? dienthoai;
  final String? zalo;
  final String? email;
  final String? gioiTinh;
  final String? dienThoai;
  final String? ma;
  // final Function(String?)? onTap;

  const DanhBaItemView({
    Key? key,
    // this.onTap,
    this.kh,
    this.hoDem,
    this.ten,
    this.phongban,
    this.dienthoai,
    this.zalo,
    this.email,
    this.gioiTinh,
    this.dienThoai,
    this.ma,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color avatarColor = AppColors.blueVNPT;

    return InkWellWidget(
      // onPress: () => onTap?.call(ma),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: avatarColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    kh ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (hoDem ?? '') + ' ' + (ten ?? ''),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            height: 1.5,
                          ),
                    ),
                    AppConstant.spaceVerticalSmallExtra,
                    Text(
                      'Phòng Ban: ' + (phongban ?? ''),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            height: 1.5,
                          ),
                    ),
                    AppConstant.spaceVerticalSmallExtra,
                    Text('Điện thoại: ' + (dienThoai ?? ''),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              height: 1.5,
                            )),
                    AppConstant.spaceVerticalSmallExtra,
                    Text('Email: ' + (email ?? ''),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              height: 1.5,
                            ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconWidget extends StatelessWidget {
  final String imageAssetName;
  final Function()? onPress;
  final String? phoneNumber;

  const _CircleIconWidget({
    Key? key,
    required this.imageAssetName,
    this.onPress,
    this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onPress: onPress,
      padding: const EdgeInsets.all(4),
      borderRadius: 22,
      child: Image.asset(
        imageAssetName,
        fit: BoxFit.fill,
        width: 28,
        height: 28,
      ),
    );
  }
}

void _makePhoneCall(String? phoneNumber) async {
  if (phoneNumber != null) {
    String url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
