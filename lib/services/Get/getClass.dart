import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:instapp/controllers/errorDialogController.dart';
import 'package:instapp/controllers/searchedUserController.dart';
import 'package:instapp/controllers/usersStoriesController.dart';
import 'package:instapp/models/searchedUserModel.dart';
import 'package:instapp/models/userFollowerModel.dart';
import 'package:instapp/models/userStoryModel.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../../models/storyModel.dart';

class GetServices {
  ///
  ///
  /// KULLANICI INSTAGRAM CEREZLERININ ALINMASI
  ///
  ///
  static Future<bool> getCookies() async {
    final cookieManager = WebviewCookieManager();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool cookieStatus = preferences.getBool('cookie_status') ?? false;
    log(cookieStatus.toString());
    try {
      if (cookieStatus == false) {
        await Future.delayed(const Duration(seconds: 3));

        // KULLANICI INSTAGRAM CEREZLERI ALMA
        final gotCookies =
            await cookieManager.getCookies('https://www.instagram.com/');

        // ALINAN CEREZLERI MAP YAPISINA DONUSTURMA

        Map map = {for (var item in gotCookies) item.name: item.value};

        if (map.containsKey('ds_user_id') &&
            map.containsKey('ig_did') &&
            map.containsKey('ig_nrcb') &&
            map.containsKey('csrftoken') &&
            map.containsKey('mid') &&
            map.containsKey('sessionid') &&
            map.containsKey('shbid') &&
            map.containsKey('shbts') &&
            map.containsKey('rur')) {
          map.forEach((key, value) async {
            log('$key : $value');
            await preferences.setString(key, value);
          });
          log('FETCH COOKIES VERILERI TAMAMLANDI');

          await preferences.setBool('cookie_status', true);

          return true;
        } else {
          await getCookies();
          return false;
        }
      }
    } catch (e) {
      log('$e');
    }
    return false;
  }

  ///
  ///
  /// KULLANICI PROFIL DETAYLARININ ALINMASI
  ///
  ///
  static Future getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool cookieStatus = prefs.getBool('cookie_status') ?? false;
    bool userDataStaus = prefs.getBool('user_data_status') ?? false;

    if (cookieStatus == true && userDataStaus == false) {
      try {
        String instagramId = prefs.getString('ds_user_id')!;
        String csrftoken = prefs.getString('csrftoken')!;
        String sessionId = prefs.getString('sessionid')!;
        String url = 'https://i.instagram.com/api/v1/users/$instagramId/info/';

        final response = await http.get(Uri.parse(url), headers: {
          'sec-ch-ua':
              '"Chromium";v="94", "Google Chrome";v="94", ";Not A Brand";v="99"',
          'X-IG-WWW-Claim':
              'hmac.AR2WwJKC3WR-MoU7JMDfFFID-7fdmd1WlxNLEkz2dna04cuf',
          'sec-ch-ua-mobile': '?0',
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36',
          'Accept': '*/*',
          'X-ASBD-ID': '198387',
          'sec-ch-ua-platform': '"macOS"',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'csrftoken=$csrftoken;sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data.containsKey("status") && data["status"] == "fail") {
          } else {
            OneSignal.login(
                prefs.getString('device_id') ?? 'onesignal id atanamadi');
            await prefs.setString('username', data["user"]["username"]);
            await prefs.setString(
                'profile_pic_url', data["user"]["profile_pic_url"]);
            await prefs.setString('full_name', data["user"]["full_name"]);
            await prefs.setString('biography', data["user"]["biography"]);
            await prefs.setString(
                'follower_count', data["user"]["follower_count"].toString());
            await prefs.setString(
                'following_count', data["user"]["following_count"].toString());
            await prefs.setString(
                'media_count', data["user"]["media_count"].toString());
            await prefs.setString(
                'onesignal_id',
                OneSignal.User.pushSubscription.id ??
                    'onesignal id yazilamadi');
            await prefs.setBool('user_data_status', true);

            log('FETCH USER INFO VERILERI TAMAMLADIN');

            return true;
          }
        } else {
          log('${response.statusCode} - ${response.body}');
          ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log('bir hata olustu ======> $e');
      }
    } else {
      log('cerez durumu $cookieStatus');
      ErrorDialogs.gosterHataDialogi();
    }
  }

  ///
  ///
  /// KULLANICININ TAKIP ETTIKLERININ VERISI ALINMASI
  ///
  ///

  static Future getUserFollowingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool cookieStatus = prefs.getBool('cookie_status') ?? false;
    bool followingDataStatus = prefs.getBool('following_data_status') ?? false;

    if (cookieStatus == true && followingDataStatus == false) {
      String instagramId = prefs.getString('ds_user_id')!;
      String csrftoken = prefs.getString('csrftoken')!;
      String sessionId = prefs.getString('sessionid')!;

      String url;
      url =
          'https://i.instagram.com/api/v1/friendships/$instagramId/following/';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          'sec-ch-ua':
              '"Chromium";v="94", "Google Chrome";v="94", ";Not A Brand";v="99"',
          'X-IG-WWW-Claim':
              'hmac.AR2WwJKC3WR-MoU7JMDfFFID-7fdmd1WlxNLEkz2dna04cuf',
          'sec-ch-ua-mobile': '?0',
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36',
          'Accept': '*/*',
          'X-ASBD-ID': '198387',
          'sec-ch-ua-platform': '"macOS"',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'csrftoken=$csrftoken;sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          List users = data['users'];

          await prefs.setString('current_following_data', jsonEncode(users));
          await prefs.setBool('following_data_status', true);

          var tarih = DateTime.now();

          var formatter = DateFormat('dd/MM/yyyy - HH:mm');
          prefs.setString('following_data_time', formatter.format(tarih));

          log('FETCH USER FOLLOWING TAMAMLANDI');
          log('${users.length}');

          return true;
        } else {
          log('${response.statusCode} > ${response.body}');
          ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log('bir hata olustu ===+==> $e');
        ErrorDialogs.gosterHataDialogi();
      }
    }
  }

  ///
  ///
  /// KULLANICININ TAKIPCILERININ VERISI ALINMASI
  ///
  ///
  static Future getUserFollowersData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool cookieStatus = prefs.getBool('cookie_status') ?? false;
    bool followersDataStatus = prefs.getBool('followers_data_status') ?? false;

    if (cookieStatus == true && followersDataStatus == false) {
      String? instagramId = prefs.getString('ds_user_id');
      String? csrftoken = prefs.getString('csrftoken');
      String? sessionId = prefs.getString('sessionid');
      String url;
      url =
          'https://i.instagram.com/api/v1/friendships/$instagramId/followers/';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          'sec-ch-ua':
              '"Chromium";v="94", "Google Chrome";v="94", ";Not A Brand";v="99"',
          'X-IG-WWW-Claim':
              'hmac.AR2WwJKC3WR-MoU7JMDfFFID-7fdmd1WlxNLEkz2dna04cuf',
          'sec-ch-ua-mobile': '?0',
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36',
          'Accept': '*/*',
          'X-ASBD-ID': '198387',
          'sec-ch-ua-platform': '"macOS"',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'csrftoken=$csrftoken;sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          List users = data['users'];

          await prefs.setString('current_followers_data', jsonEncode(users));
          await prefs.setBool('followers_data_status', true);

          var tarih = DateTime.now();

          var formatter = DateFormat('dd/MM/yyyy - HH:mm');
          await prefs.setString('followers_data_time', formatter.format(tarih));

          log('FETCH USER FOLLOWERS TAMAMLANDI');

          return true;
        } else {
          log('${response.statusCode} > ${response.body}');
          ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log('bir hata olustu ===+==> $e');
        ErrorDialogs.gosterHataDialogi();
      }
    }
  }

  ///
  ///
  /// KULLANICININ TAKIPCILERININ HIKAYE VERISI ALINMASI
  ///
  ///
  static Future getUserStories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var controller = Get.put(UserStoriesController());

    bool cookieStatus = prefs.getBool('cookie_status') ?? false;

    if (cookieStatus == true) {
      String? instagramId = prefs.getString('ds_user_id');
      String? csrftoken = prefs.getString('csrftoken');
      String? sessionId = prefs.getString('sessionid');
      String url;
      url = 'https://www.instagram.com/api/v1/feed/reels_tray/';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          var jsonDataList = json.decode(response.body);
          var jsonDecodeList = jsonDataList['tray'];

          // log('$jsonDecodeList');

          List<InstagramReel> instagramReels = [];
          for (var jsonData in jsonDecodeList) {
            instagramReels.add(InstagramReel.fromJson(jsonData));
          }
          controller.instagramReels.value = instagramReels;
          log('HIKAYELER BASARIYLA ALINDI');

          return true;
        } else {
          log('${response.statusCode} > ${response.body}');
          ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log('bir hata olustu ===+==> $e');
        ErrorDialogs.gosterHataDialogi();
      }
    }
  }

  ///
  ///
  /// KULLANICININ TAKIPCILERININ LISTESI
  ///
  ///
  static Future getUserFollowerList(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var controller = Get.put(SearchedUserController());
    bool cookieStatus = prefs.getBool('cookie_status') ?? false;

    if (cookieStatus == true) {
      String? instagramId = prefs.getString('ds_user_id');
      String? csrftoken = prefs.getString('csrftoken');
      String? sessionId = prefs.getString('sessionid');
      String url;
      url =
          'https://www.instagram.com/api/v1/web/search/topsearch/?context=blended&query=$value&rank_token=0.6872023492760977&include_reel=true';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var jsonDecodeList = data['users'];

          // log('$jsonDecodeList');

          List<SearchedUser> searchedUser = [];
          for (var jsonData in jsonDecodeList) {
            searchedUser.add(SearchedUser.fromJson(jsonData));
          }

          controller.users.value = searchedUser;

          return true;
        } else {
          log('${response.statusCode} > ${response.body}');
          // ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log('bir hata olustu ===+==> $e');
        // ErrorDialogs.gosterHataDialogi();
      }
    }
  }

  static Future getUserFollowerListUserInfo(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var controller = Get.put(SearchedUserController());
    bool cookieStatus = prefs.getBool('cookie_status') ?? false;

    if (cookieStatus == true) {
      String? instagramId = prefs.getString('ds_user_id');
      String? sessionId = prefs.getString('sessionid');
      String url;
      url =
          'https://instagram.com/api/v1/users/web_profile_info/?username=$username';

      try {
        final response = await http.get(Uri.parse(url), headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          var jsonMap = jsonDecode(response.body);
          var jsonList = jsonMap['data']['user'];

          controller.userData.value =
              UserFollowerDataModel.fromJson(jsonEncode(jsonList));

          log('${controller.userData.value?.isPrivate}');

          return true;
        } else {
          log('${response.statusCode} > ${response.body}');
          // ErrorDialogs.gosterHataDialogi();
        }
      } catch (e) {
        log('kullanici takipci listesi alinca bir hata olustu ===+==> $e');
        // ErrorDialogs.gosterHataDialogi();
      }
    }
  }

  static Future<bool> fetchPostData(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool cookieStatus = prefs.getBool('cookie_status') ?? false;
    var controller = Get.put(SearchedUserController());

    String urlPost =
        'https://www.instagram.com/api/v1/feed/user/$username/username/?count=15';

    if (cookieStatus) {
      String? instagramId = prefs.getString('ds_user_id');
      String? sessionId = prefs.getString('sessionid');

      await getUserFollowerListUserInfo(username);
      try {
        final response = await http.get(Uri.parse(urlPost), headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
        });

        if (response.statusCode == 200) {
          var jsonMap2 = jsonDecode(response.body);
          List data = jsonMap2['items'];

          controller.userPosts.clear();

          for (var element in data) {
            controller.userPosts
                .add(element['image_versions2']['candidates'][0]['url']);
          }

          return true;
        }
      } catch (e) {
        log(' KULLANICI POST POST ALINIRKEN BIR HATA OLUSTU $e');
        return false;
      }
    }

    return true;
  }

  static Future fetchUserStory(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var controllerStory = Get.put(UserStoriesController());

    bool cookieStatus = prefs.getBool('cookie_status') ?? false;

    if (cookieStatus == true) {
      String? instagramId = prefs.getString('ds_user_id');
      String? sessionId = prefs.getString('sessionid');
      String url;
      url = 'https://www.instagram.com/api/v1/feed/user/$userID/story';
      try {
        final response = await http.get(Uri.parse(url), headers: {
          'User-Agent':
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
          'X-IG-App-ID': '936619743392459',
          'cookie': 'ds_user_id=$instagramId; sessionid=$sessionId;',
        });
        if (response.statusCode == 200) {
          log('HIKAYELER GETIRILDI');
          var json = jsonDecode(response.body);
          var newJson = await json["reel"]['items'];

          if (newJson.toString().contains("image_versions2")) {
            log('true');
          }

          // log(jsonEncode(newJson));
          controllerStory.userStories.value = UserStoryDataModel();

          controllerStory.userStories.value =
              UserStoryDataModel.fromJson(jsonEncode(newJson));

          return true;
        } else {
          log('${response.statusCode} > ${response.body}');
          return false;
        }
      } catch (e) {
        log('bir hata olustu ===+==> $e');
        return false;
      }
    }
  }
}
