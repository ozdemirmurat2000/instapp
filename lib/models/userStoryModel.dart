import 'dart:convert';

class UserStoryDataModel {
  List<Map<String, dynamic>>? userStory;

  UserStoryDataModel({this.userStory});

  factory UserStoryDataModel.fromJson(String json) {
    List<dynamic> dataMap = jsonDecode(json);
    List<Map<String, dynamic>> dataModel = [];

    for (var element in dataMap) {
      if (element['video_versions'] != null &&
          element['image_versions2'] != null) {
        double change = element['video_duration'];
        dataModel.add({
          'url': element['video_versions'][2]['url'],
          'duration': change.toInt(),
        });
      } else if (element['image_versions2'] != null) {
        dataModel.add({
          'image_url': element['image_versions2']['candidates'][0]['url'],
        });
      }
    }
    return UserStoryDataModel(userStory: dataModel);
  }
}
