import 'dart:convert';

class UserPremiumStatusModel {
  int? showAppRate;
  int? showSecretProfileButton;
  int isPremium;
  int userCoin;

  UserPremiumStatusModel(
      {required this.isPremium,
      required this.showAppRate,
      required this.showSecretProfileButton,
      required this.userCoin});

  factory UserPremiumStatusModel.fromJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);

    return UserPremiumStatusModel(
      isPremium: jsonMap['is_premium'] ?? 0,
      showAppRate: jsonMap['is_show_iappreview'] ?? 0,
      showSecretProfileButton: jsonMap['is_button_show_android'] ?? 0,
      userCoin: jsonMap['users_coin'] ?? 0,
    );
  }
}
