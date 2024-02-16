class SearchedUser {
  final String? pk;
  final String? pkId;
  final String? username;
  final String? fullName;
  final bool? isPrivate;
  final String? profilePicId;
  final String? profilePicUrl;
  final String? latestReelMedia;
  final String? socialContext;
  final String? searchSocialContext;

  SearchedUser({
    required this.pk,
    required this.pkId,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicId,
    required this.profilePicUrl,
    required this.latestReelMedia,
    required this.socialContext,
    required this.searchSocialContext,
  });

  factory SearchedUser.fromJson(Map<String, dynamic> json) {
    return SearchedUser(
      pk: json['user']['pk'].toString(),
      pkId: json['user']['pk_id'].toString(),
      username: json['user']['username'],
      fullName: json['user']['full_name'],
      isPrivate: json['user']['is_private'],
      profilePicId: json['user']['profile_pic_id'],
      profilePicUrl: json['user']['profile_pic_url'],
      latestReelMedia: json['user']['latest_reel_media'].toString(),
      socialContext: json['user']['social_context'],
      searchSocialContext: json['user']['search_social_context'],
    );
  }
}
