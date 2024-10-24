import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salesoft_hrm/common/app_colors.dart';
import 'package:salesoft_hrm/common/app_constant.dart';

class RowHoSo extends StatefulWidget {
  final String text1;
  final String text2;

  const RowHoSo({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  _RowHoSoState createState() => _RowHoSoState();
}

class _RowHoSoState extends State<RowHoSo> {
  bool thuGon = true;
  bool xemThem = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: Text(
              widget.text1,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Arimo'),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              setState(() {
                thuGon = !thuGon;
                xemThem = !xemThem;
              });
            },
            child: Text(
              widget.text2,
              maxLines: xemThem ? (thuGon ? 1 : 3) : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Arimo'),
            ),
          ),
        ),
      ],
    );
  }
}

class RowHoSo2 extends StatefulWidget {
  final String text1;
  final String text2;

  const RowHoSo2({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  _RowHoSo2State createState() => _RowHoSo2State();
}

class _RowHoSo2State extends State<RowHoSo2> {
  bool thuGon = true;
  bool xemThem = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: Text(
              widget.text1,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Arimo'),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () {
              setState(() {
                thuGon = !thuGon;
                xemThem = !xemThem;
              });
            },
            child: Text(
              widget.text2,
              maxLines: xemThem ? (thuGon ? 1 : 3) : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, fontFamily: 'Arimo'),
            ),
          ),
        ),
      ],
    );
  }
}
