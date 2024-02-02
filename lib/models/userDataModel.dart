import 'package:get/get.dart';

class UserDataModel {
  String userNameSurname;
  String userName;
  String userFollowers;
  String userFollowed;
  String userShares;
  String positiveFollows;
  String negativeFollows;
  String postiveUnFollows;
  String negativeUnFollows;
  String userImageURL;
  String media_count;

  List? userHistories;

  UserDataModel({
    this.userNameSurname = '',
    this.userName = '',
    this.userFollowers = '',
    this.userFollowed = '',
    this.positiveFollows = '',
    this.negativeFollows = '',
    this.postiveUnFollows = '',
    this.negativeUnFollows = '',
    this.userShares = '',
    this.userHistories,
    this.userImageURL = '',
    this.media_count = '',
  });
}
