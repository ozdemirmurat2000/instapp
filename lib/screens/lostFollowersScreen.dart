import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../consts/textStyle.dart';
import '../controllers/loginStatusController.dart';
import '../models/userFollowersModel.dart';
import '../utils/screenDetails.dart';

class LostFollowersScreen extends StatelessWidget {
  LostFollowersScreen({super.key});

  var controller = Get.find<LoginStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: ScreenDetails.appBar(context, showCup: true),
      body: controller.lostFollowers.isEmpty
          ? const Center(
              child: Text('Henüz veri yok.'),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: ScreenDetails.divider(context),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(top: 14.h, left: 23.w, bottom: 13.h),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Giden Takipçiler',
                      style: KTextStyle.KHeaderTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.lostFollowers.length,
                    itemBuilder: (context, index) =>
                        followerCardTool(controller.lostFollowers[index]),
                    physics: const NeverScrollableScrollPhysics(),
                  )
                ],
              ),
            ),
    );
  }

  Container followerCardTool(UserFollowersModel userModel) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h, right: 22.5.w, left: 22.5.w),
      width: 330.w,
      height: 80.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: const Color(0xFF120F16)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 27.w),
            width: 47.h,
            height: 47.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.h),
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(userModel.profilePicUrl!),
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(width: 13.7),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // NAME
                userModel.fullName!,
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  textColor: const Color(0xFFFAFAFA),
                ),
              ),
              // USERNAME
              Text(
                userModel.username!,
                style: KTextStyle.KHeaderTextStyle(
                  fontSize: 12.sp,
                  textColor: const Color(0xFF9A9A9A),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
