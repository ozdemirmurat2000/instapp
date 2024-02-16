import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/models/hikayeModel.dart';

import '../consts/colorsUtil.dart';
import '../services/Get/getClass.dart';

class HikayeWidget extends StatefulWidget {
  HikayeWidget({super.key, required this.kullaniciHikaye, this.isBold = false});

  HikayeModel kullaniciHikaye;
  bool isBold = false;

  @override
  State<HikayeWidget> createState() => _HikayeWidgetState();
}

class _HikayeWidgetState extends State<HikayeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          margin: EdgeInsets.only(left: 10.w),
          width: widget.kullaniciHikaye.size?.w ?? 53.w,
          height: widget.kullaniciHikaye.size?.w ?? 53.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.w),
            border: GradientBoxBorder(
              gradient: LinearGradient(
                colors: [
                  KColors.textColorLinearStart,
                  KColors.textColorLinearMiddle,
                  KColors.textColorLinearEnd,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              width: 2,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: KColors.textColorLinearStart.withOpacity(0.4),
              border: Border.all(width: 2.w, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100.w),
              image: widget.kullaniciHikaye.userImage!.contains('assets')
                  ? DecorationImage(
                      fit: widget.kullaniciHikaye.isCover == false
                          ? BoxFit.cover
                          : BoxFit.none,
                      image: AssetImage(widget.kullaniciHikaye.userImage!),
                    )
                  : DecorationImage(
                      fit: widget.kullaniciHikaye.isCover == false
                          ? BoxFit.cover
                          : BoxFit.none,
                      image: NetworkImage(widget.kullaniciHikaye.userImage!)),
            ),
          ),
        ),
        widget.kullaniciHikaye.isShowName == true
            ? Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.w),
                child: Text(
                  widget.kullaniciHikaye.userName,
                  style: KTextStyle.KHeaderTextStyle(
                    fontSize: 9.sp,
                    textColor: KColors.textColorMini,
                    fontWeight:
                        widget.isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
