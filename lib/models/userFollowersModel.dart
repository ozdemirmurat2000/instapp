class UserFollowersModel {
  final String? pk;
  final String? pkId;
  final String? username;
  final String? fullName;
  final bool? isPrivate;
  final String? fbidV2;
  final int? thirdPartyDownloadsEnabled;
  final String? strongId;
  final String? profilePicId;
  final String? profilePicUrl;
  final bool? isVerified;
  final bool? hasAnonymousProfilePicture;
  final List<dynamic>? accountBadges;
  final int? latestReelMedia;

  UserFollowersModel({
    this.pk,
    this.pkId,
    this.username,
    this.fullName,
    this.isPrivate,
    this.fbidV2,
    this.thirdPartyDownloadsEnabled,
    this.strongId,
    this.profilePicId,
    this.profilePicUrl,
    this.isVerified,
    this.hasAnonymousProfilePicture,
    this.accountBadges,
    this.latestReelMedia,
  });

  factory UserFollowersModel.fromJson(Map<String, dynamic> json) {
    return UserFollowersModel(
      pk: json['pk'] as String?,
      pkId: json['pk_id'] as String?,
      username: json['username'] as String?,
      fullName: json['full_name'] as String?,
      isPrivate: json['is_private'] as bool?,
      fbidV2: json['fbid_v2'] as String?,
      thirdPartyDownloadsEnabled: json['third_party_downloads_enabled'] as int?,
      strongId: json['strong_id__'] as String?,
      profilePicId: json['profile_pic_id'] as String?,
      profilePicUrl: json['profile_pic_url'] as String?,
      isVerified: json['is_verified'] as bool?,
      hasAnonymousProfilePicture:
          json['has_anonymous_profile_picture'] as bool?,
      accountBadges: json['account_badges'] as List<dynamic>?,
      latestReelMedia: json['latest_reel_media'] as int?,
    );
  }
}
