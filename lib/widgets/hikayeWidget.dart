import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/models/hikayeModel.dart';

import '../consts/colorsUtil.dart';

class HikayeWidget extends StatelessWidget {
  HikayeWidget({super.key, required this.kullaniciHikaye});

  HikayeModel kullaniciHikaye;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(3.w),
          margin: EdgeInsets.only(left: 10.w),
          width: kullaniciHikaye.size?.w ?? 53.w,
          height: kullaniciHikaye.size?.w ?? 53.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.w),
            border: Border.all(
              width: 2.w,
              color: KColors.textColorLinearStart,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: KColors.textColorLinearStart.withOpacity(0.4),
              border: Border.all(width: 2.w, color: Colors.transparent),
              borderRadius: BorderRadius.circular(100.w),
              image: DecorationImage(
                fit: kullaniciHikaye.isCover == false
                    ? BoxFit.cover
                    : BoxFit.none,
                image: AssetImage(
                  kullaniciHikaye.userImage,
                ),
              ),
            ),
          ),
        ),
        kullaniciHikaye.isShowName == true
            ? Container(
                margin: EdgeInsets.only(left: 10.w, top: 5.w),
                child: Text(
                  kullaniciHikaye.userName,
                  style: KTextStyle.KHeaderTextStyle(
                    fontSize: 9.sp,
                    textColor: KColors.textColorMini,
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
