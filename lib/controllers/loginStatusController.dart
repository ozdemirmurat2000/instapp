import 'package:get/get.dart';
import 'package:instapp/models/userDataModel.dart';
import 'package:instapp/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusController extends GetxController {
  RxBool loginStatus = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(loginStatus, (_) {
      if (loginStatus.value == true) {
        checkStatus();
      }
    });
    checkStatus();
  }

  var userDataModel = UserDataModel().obs;

  Future checkStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    loginStatus.value = pref.getBool('login_status') ?? false;

    print(pref.getBool('login_status'));

    if (loginStatus.value == true) {
      userDataModel.value.media_count = pref.getString('media_count')!;
      userDataModel.value.userName = pref.getString('username')!;
      userDataModel.value.userNameSurname = pref.getString('full_name')!;
      userDataModel.value.userFollowers = pref.getString('follower_count')!;
      userDataModel.value.userFollowed = pref.getString('following_count')!;
      userDataModel.value.userImageURL = pref.getString('profile_pic_url')!;
    }
  }
}
