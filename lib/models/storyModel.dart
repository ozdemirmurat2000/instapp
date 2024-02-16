class InstagramReel {
  final String id;
  final String strongId;
  final String latestReelMedia;
  final String? expiringAt;
  final String seen;
  final bool? canReply;
  final bool? canGifQuickReply;
  final bool? canReshare;
  final bool? canReactWithAvatar;
  final String? reelType;
  final String? storyDurationSecs;
  final bool? birthdayBadgeEnabled;
  final bool? hasBestiesMedia;
  final double? latestBestiesReelMedia;
  final String? mediaCount;
  final List<String>? mediaIds;
  final bool? hasVideo;
  final bool? hasFanClubMedia;
  final bool? showFanClubStoriesTeaser;
  final List<String>? disabledReplyTypes;
  final User user;
  final String? prefetchCount;
  final Map<String, double>? rankerScores;
  final String? rankedPosition;
  final String? seenRankedPosition;
  final bool? muted;

  InstagramReel({
    required this.id,
    required this.strongId,
    required this.latestReelMedia,
    required this.expiringAt,
    required this.seen,
    required this.canReply,
    required this.canGifQuickReply,
    required this.canReshare,
    required this.canReactWithAvatar,
    required this.reelType,
    required this.storyDurationSecs,
    required this.birthdayBadgeEnabled,
    required this.hasBestiesMedia,
    required this.latestBestiesReelMedia,
    required this.mediaCount,
    required this.mediaIds,
    required this.hasVideo,
    required this.hasFanClubMedia,
    required this.showFanClubStoriesTeaser,
    required this.disabledReplyTypes,
    required this.user,
    required this.prefetchCount,
    required this.rankerScores,
    required this.rankedPosition,
    required this.seenRankedPosition,
    required this.muted,
  });

  factory InstagramReel.fromJson(Map<String, dynamic> json) {
    return InstagramReel(
      id: json['id'].toString(),
      strongId: json['strong_id__'].toString(),
      latestReelMedia: json['latest_reel_media'].toString(),
      expiringAt: json['expiring_at']?.toString(),
      seen: json['seen'].toString(),
      canReply: json['can_reply'],
      canGifQuickReply: json['can_gif_quick_reply'],
      canReshare: json['can_reshare'],
      canReactWithAvatar: json['can_react_with_avatar'],
      reelType: json['reel_type']?.toString(),
      storyDurationSecs: json['story_duration_secs']?.toString(),
      birthdayBadgeEnabled: json['birthday_badge_enabled'],
      hasBestiesMedia: json['has_besties_media'],
      latestBestiesReelMedia: json['latest_besties_reel_media'],
      mediaCount: json['media_count']?.toString(),
      mediaIds: List<String>.from(json['media_ids'] ?? []),
      hasVideo: json['has_video'],
      hasFanClubMedia: json['has_fan_club_media'],
      showFanClubStoriesTeaser: json['show_fan_club_stories_teaser'],
      disabledReplyTypes: List<String>.from(json['disabled_reply_types'] ?? []),
      user: User.fromJson(json['user']),
      prefetchCount: json['prefetch_count']?.toString(),
      rankerScores: json['ranker_scores'] != null
          ? Map<String, double>.from(json['ranker_scores']!)
          : null,
      rankedPosition: json['ranked_position']?.toString(),
      seenRankedPosition: json['seen_ranked_position']?.toString(),
      muted: json['muted'],
    );
  }
}

class User {
  final String pk;
  final String pkId;
  final String username;
  final String fullName;
  final bool isPrivate;
  final String strongId;
  final bool isVerified;
  final String profilePicId;
  final String? profilePicUrl;
  final String birthdayTodayVisibilityForViewer;
  final FriendshipStatus friendshipStatus;

  User({
    required this.pk,
    required this.pkId,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.strongId,
    required this.isVerified,
    required this.profilePicId,
    required this.profilePicUrl,
    required this.birthdayTodayVisibilityForViewer,
    required this.friendshipStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pk: json['pk'].toString(),
      pkId: json['pk_id'].toString(),
      username: json['username'] ?? "",
      fullName: json['full_name'] ?? "",
      isPrivate: json['is_private'],
      strongId: json['strong_id__']?.toString() ?? "",
      isVerified: json['is_verified'],
      profilePicId: json['profile_pic_id'] ?? "",
      profilePicUrl: json['profile_pic_url'] ?? "",
      birthdayTodayVisibilityForViewer:
          json['birthday_today_visibility_for_viewer'] ?? "",
      friendshipStatus: FriendshipStatus.fromJson(json['friendship_status']),
    );
  }
}

class FriendshipStatus {
  final bool muting;
  final bool isMutingReel;
  final bool following;
  final bool isBestie;
  final bool outgoingRequest;

  FriendshipStatus({
    required this.muting,
    required this.isMutingReel,
    required this.following,
    required this.isBestie,
    required this.outgoingRequest,
  });

  factory FriendshipStatus.fromJson(Map<String, dynamic> json) {
    return FriendshipStatus(
      muting: json['muting'],
      isMutingReel: json['is_muting_reel'],
      following: json['following'],
      isBestie: json['is_bestie'],
      outgoingRequest: json['outgoing_request'],
    );
  }
}
