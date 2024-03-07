import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:instapp/consts/textStyle.dart';
import 'package:instapp/utils/screenDetails.dart';
import 'package:story_view/story_view.dart';

import '../controllers/usersStoriesController.dart';
import '../services/Get/getClass.dart';

class StoryScreen extends StatefulWidget {
  StoryScreen({super.key, required this.userId});

  String userId;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryController controller = StoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(widget.userId);
  }

  Future<bool> fetchData(String userID) async {
    try {
      bool isStory = await GetServices.fetchUserStory(userID);

      if (isStory) {
        for (var element in userStoryController.userStories.value.userStory!) {
          stories.add(
            element.containsKey('duration')
                ? StoryItem.pageVideo(
                    element['url'],
                    controller: controller,
                    duration: Duration(
                      seconds: element['duration'],
                    ),
                  )
                : StoryItem.pageImage(
                    url: element['image_url'],
                    controller: controller,
                  ),
          );
        }
        setState(() {
          isStoryA = isStory;
        });
      } else {
        setState(() {
          isStoryA = isStory;
        });
        log('hikaye bulunamadi');
      }

      setState(() {
        isLoading = true;
      });

      return true;
    } catch (e) {
      log('hikaye gosterilirken bir hata olustu $e');
      return false;
    }
  }

  bool isStoryA = false;
  bool isLoading = false;
  var userStoryController = Get.find<UserStoriesController>();
  List<StoryItem> stories = [];

  @override
  Widget build(BuildContext context) {
    log(stories.length.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: ScreenDetails.appBar(context),
      body: isLoading == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : stories.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Suan bu kullanicinin Hikayeleri Gosteremiyoruz.',
                    style: KTextStyle.KHeaderTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white),
                  ),
                )
              : StoryView(
                  storyItems: stories,
                  controller: controller,
                  onComplete: () {
                    Get.back();
                  },
                ),
    );
  }
}
