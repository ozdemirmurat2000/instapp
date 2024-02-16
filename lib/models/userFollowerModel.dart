import 'dart:convert';

class UserFollowerDataModel {
  String followedCount;
  String followerCount;
  String fullName;
  String userName;
  String mediaCount;
  bool isPrivate;
  String profilePicURL;
  String profilePicURLHD;
  bool followedByViewer;
  bool followsByViewer;

  UserFollowerDataModel({
    required this.followedByViewer,
    required this.followedCount,
    required this.followerCount,
    required this.followsByViewer,
    required this.fullName,
    required this.isPrivate,
    required this.mediaCount,
    required this.profilePicURL,
    required this.profilePicURLHD,
    required this.userName,
  });

  factory UserFollowerDataModel.fromJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);

    return UserFollowerDataModel(
        followedByViewer: jsonMap['followed_by_viewer'],
        followedCount: jsonMap['edge_followed_by']['count'].toString(),
        followerCount: jsonMap['edge_follow']['count'].toString(),
        followsByViewer: jsonMap['follows_viewer'],
        fullName: jsonMap['full_name'],
        isPrivate: jsonMap['is_private'],
        mediaCount: jsonMap['edge_owner_to_timeline_media']['count'].toString(),
        profilePicURL: jsonMap['profile_pic_url'],
        profilePicURLHD: jsonMap['profile_pic_url_hd'],
        userName: jsonMap['username']);
  }
}
