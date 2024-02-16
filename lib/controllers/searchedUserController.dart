import 'package:get/get.dart';
import 'package:instapp/models/searchedUserModel.dart';
import 'package:instapp/models/userFollowerModel.dart';
import 'package:instapp/models/userPremiumStatusModel.dart';

class SearchedUserController extends GetxController {
  RxBool isSearching = false.obs;
  RxList<SearchedUser> users = <SearchedUser>[].obs;
  RxList<String> userPosts = <String>[].obs;
  Rx<UserFollowerDataModel?> userData = Rx(null);
  var userPremiumStatus = UserPremiumStatusModel(
          isPremium: 0, showAppRate: 0, showSecretProfileButton: 0, userCoin: 0)
      .obs;
}
