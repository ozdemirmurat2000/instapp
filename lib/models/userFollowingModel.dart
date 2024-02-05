class UserFollowingModel {
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
  final bool? isFavorite;

  UserFollowingModel({
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
    this.isFavorite,
  });

  factory UserFollowingModel.fromJson(Map<String, dynamic> json) {
    return UserFollowingModel(
      pk: json['pk'],
      pkId: json['pk_id'],
      username: json['username'],
      fullName: json['full_name'],
      isPrivate: json['is_private'] as bool,
      fbidV2: json['fbid_v2'],
      thirdPartyDownloadsEnabled: json['third_party_downloads_enabled'] as int,
      strongId: json['strong_id__'],
      profilePicId: json['profile_pic_id'] ?? '',
      profilePicUrl: json['profile_pic_url'] ?? '',
      isVerified: json['is_verified'] as bool,
      hasAnonymousProfilePicture: json['has_anonymous_profile_picture'] as bool,
      accountBadges: json['account_badges'],
      latestReelMedia: json['latest_reel_media'] as int,
      isFavorite: json['is_favorite'],
    );
  }
}
