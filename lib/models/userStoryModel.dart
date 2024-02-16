import 'dart:convert';

class UserStoryDataModel {
  List<Map<String, dynamic>>? userStory;

  UserStoryDataModel({this.userStory});

  factory UserStoryDataModel.fromJson(String json) {
    List<dynamic> dataMap = jsonDecode(json);
    List<Map<String, dynamic>> dataModel = [];

    for (var element in dataMap) {
      if (element['video_versions'] != null) {
        double change = element['video_duration'];
        dataModel.add({
          'url': element['video_versions'][2]['url'],
          'duration': change.toInt(),
        });
      }
    }
    return UserStoryDataModel(userStory: dataModel);
  }
}
