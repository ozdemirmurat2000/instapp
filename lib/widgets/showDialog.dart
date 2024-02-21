import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';

Future<dynamic> showMyDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: const Color(0xff161616),
          ),
          width: 339.w,
          height: 613.h,
          child: Column(
            children: [
              SizedBox(height: 21.h),
              const Text('Uygulma Ismi'),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 47.w),
                child: Image.asset(
                  'assets/images/historyBackground.png',
                  width: 245.76.w,
                  height: 252.h,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 31.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  color: const Color(0xff1D1D1D),
                ),
                child: RatingBar.builder(
                  itemSize: 33.h,
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
              SizedBox(height: 11.h),
              Text(
                'Bizi Oylayın',
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                textAlign: TextAlign.center,
                'Görüşleriniz bizim için çok önemli, daha fazla yeni özellik geliştirmemize yardımcı olmak için Play Store’da bizi derecelendirin.',
                style: KTextStyle.KHeaderTextStyle(
                    fontSize: 10.sp, textColor: KColors.textColorMini),
              ),
              SizedBox(height: 19.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                width: 290.w,
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.w),
                  gradient: LinearGradient(
                    colors: [
                      KColors.textColorLinearStart,
                      KColors.textColorLinearMiddle,
                      KColors.textColorLinearEnd,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.unlock4,
                      size: 18.h,
                      color: Colors.white,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Kilidi Aç',
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Daha Sonra',
                  style: KTextStyle.KHeaderTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      textColor: const Color(0xFFBBBBBB)),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
