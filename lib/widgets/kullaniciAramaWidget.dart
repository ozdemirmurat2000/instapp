import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/colorsUtil.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/controllers/searchedUserController.dart';
import 'package:instapp/services/Get/getClass.dart';

class KullaniciAramaWidget extends StatelessWidget {
  KullaniciAramaWidget(
      {super.key, required this.textColor, required this.controller});

  Color textColor;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var searchController = Get.find<SearchedUserController>();
    return Container(
      margin: EdgeInsets.only(
        top: 28.h,
        left: 23.w,
        right: 22.2,
      ),
      width: 330.w,
      height: 55.h,
      decoration: BoxDecoration(
        color: KColors.textFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),

      child: TextField(
        onChanged: (value) async {
          searchController.isSearching.value = true;
          await GetServices.getUserFollowerList(value);
          searchController.isSearching.value = false;
        },
        controller: controller,
        style: KTextStyle.KHeaderTextStyle(
          fontSize: 10.sp,
          textColor: Colors.white,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          alignLabelWithHint: false,
          hintText: 'Kullanıcı Adı Girin...',
          hintStyle: KTextStyle.KHeaderTextStyle(
            fontSize: 10.sp,
            textColor: KColors.textColorMini,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 21.h),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.only(
              top: 19.h,
              left: 18.w,
              bottom: 20.2.h,
              right: 8.59.w,
            ),
            child: Image.asset(
              'assets/icons/searchIcon-1.png',
              width: 19.41.w,
              height: 15.8.h,
              color: textColor,
            ),
          ),
        ),
      ),
      // child: Row(
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.only(
      //         top: 19.h,
      //         left: 18.w,
      //         bottom: 20.2.h,
      //         right: 8.59.w,
      //       ),
      //       child: Image.asset(
      //         'assets/icons/searchIcon-1.png',
      //         width: 19.41.w,
      //         height: 15.8.h,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
