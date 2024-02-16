import 'package:get/get.dart';
import 'package:instapp/models/userStoryModel.dart';

import '../models/storyModel.dart';

class UserStoriesController extends GetxController {
  RxList<InstagramReel> instagramReels = <InstagramReel>[].obs;
  var userStories = UserStoryDataModel().obs;
}
