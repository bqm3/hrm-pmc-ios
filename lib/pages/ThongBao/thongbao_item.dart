import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesoft_hrm/common/app_constant.dart';
import 'package:salesoft_hrm/widgets/inkwell_widget.dart';

class ThongBaoItemView extends StatelessWidget {
  final String? tieuDe;
  final String? noiDung;
  final bool? daXem;
  final String? date1;
  final int? idThongBao;
  final Function(String?, String?, String?)? onTap;

  const ThongBaoItemView({
    Key? key,
    this.onTap,
    this.tieuDe,
    this.noiDung,
    this.daXem,
    this.idThongBao,
    this.date1,
  }) : super(key: key);

  String _formatDate(String? date) {
    if (date == null) return '';
    try {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onPress: () => onTap?.call(tieuDe, noiDung, date1),
      child: Card(
        color: daXem == true ? Colors.white : Colors.grey[300],
        elevation: 6,
        margin: const EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/icon_app2.jpg'),
                    fit: BoxFit.cover,
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
                      tieuDe ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            height: 1.5,
                          ),
                    ),
                    AppConstant.spaceVerticalSmallExtra,
                    Text(
                      noiDung ?? '',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            height: 1.5,
                          ),
                    ),
                    AppConstant.spaceVerticalSmallExtra,
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
