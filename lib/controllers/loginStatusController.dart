import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:instapp/models/userDataModel.dart';
import 'package:instapp/models/userFollowersModel.dart';
import 'package:instapp/models/userFollowingModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusController extends GetxController {
  RxBool loginStatus = false.obs;
  static bool webView = false;

  var userDataModel = UserDataModel().obs;
  RxList<UserFollowersModel> userFollowersList = <UserFollowersModel>[].obs;
  RxList<UserFollowingModel> userFollowingList = <UserFollowingModel>[].obs;
  RxSet userUnfollowingData = <String>{}.obs;

  Future checkStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    userDataModel.value.media_count = pref.getString('media_count') ?? '';
    userDataModel.value.userName = pref.getString('username') ?? '';
    userDataModel.value.userNameSurname = pref.getString('full_name') ?? '';
    userDataModel.value.userFollowers = pref.getString('follower_count') ?? '';
    userDataModel.value.userFollowed = pref.getString('following_count') ?? '';
    userDataModel.value.userImageURL = pref.getString('profile_pic_url') ?? '';
    String dataFolowing = pref.getString('current_following_data') ?? '';
    String dataFolowers = pref.getString('current_followers_data') ?? '';
    final followingList = jsonDecode(dataFolowing) as List<dynamic>;
    final followersList = jsonDecode(dataFolowers) as List<dynamic>;

    final userFollowingModel =
        followingList.map((item) => UserFollowersModel.fromJson(item)).toList();
    final userFollowersModel =
        followersList.map((item) => UserFollowersModel.fromJson(item)).toList();

    userFollowersList.value = userFollowersModel;
    userFollowingList.value = userFollowingList;

    List followingUsers = [];

    for (var element in userFollowingModel) {
      followingUsers.add(element.username);
    }
    List followersUsers = [];

    for (var element in userFollowersModel) {
      followersUsers.add(element.username);
    }

    final List<UserFollowersModel> notFollowing = userFollowingModel
        .where((user) => !userFollowersModel
            .any((follower) => follower.username == user.username))
        .toList();

    for (var element in notFollowing) {
      log('${element.username}');
    }

    // log(userFollowersModel[152].fullName);
  }
}
