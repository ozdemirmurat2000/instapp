class HikayeModel {
  String userName;
  String userImage;
  bool? isView;
  double? size;
  bool isCover;
  bool? isShowName;

  HikayeModel({
    required this.userImage,
    required this.userName,
    this.isView,
    this.size,
    this.isCover = false,
    this.isShowName = true,
  });
}
