class UserPostModel {
  int? width;
  int? height;
  String? url;

  UserPostModel({this.width, this.height, this.url});

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      width: json['width'],
      height: json['height'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    return data;
  }
}
