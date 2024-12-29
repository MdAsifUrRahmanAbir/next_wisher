// import 'package:chewie/chewie.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
// import 'package:next_wisher/backend/utils/custom_loading_api.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:video_player/video_player.dart';

import '../../backend/services/dashboard/category_model.dart';
import '../../backend/services/dashboard/dashboard_service.dart';
import '../../backend/services/dashboard/home_model.dart';
import '../../backend/services/dashboard/talents_model.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../view/nav_pages/dashboard/featured_celebrities_screen.dart';
import 'bottom_nav_controller.dart';

class DashboardController extends GetxController with DashboardService {
  final List category = [
    {
      "icon": "assets/categories/actor.jpg"
    },
    {
      "icon": "assets/categories/people.jpg"
    },
    {
      "icon": "assets/categories/model.jpg"
    },
    {
      "icon": "assets/categories/music.jpg"
    },
    {
      "icon": "assets/categories/sport.jpg"
    },
    {
      "icon": "assets/categories/radio.jpg"
    },
  ];

  @override
  void onInit() {
    homeProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  RxList<HomeTalent> talentList = <HomeTalent>[].obs;


  RxList<Categories> categoriesList = <Categories>[].obs;
  final searchController = TextEditingController();

  late HomeModel _homeModel;
  HomeModel get homeModel => _homeModel;

  ///* Get Home in process
  Future<HomeModel> homeProcess() async {
    _isLoading.value = true;
    update();
    await homeProcessApi().then((value) {
      _homeModel = value!;
      for (var e in _homeModel.data.categories) {
        if(e.child.isNotEmpty){
          categoriesList.add(e);
        }
      }
      talentList.value = _homeModel.data.homeTalents;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _homeModel;
  }



  /// ------------------------------------- >>
  final _isCategoryLoading = false.obs;
  bool get isCategoryLoading => _isCategoryLoading.value;


  late CategoryModel _categoryModel;
  CategoryModel get categoryModel => _categoryModel;


  ///* Get CategoryModel in process
  Future<CategoryModel> categoryModelProcess(String tag, String name) async {
    _isCategoryLoading.value = true;
    update();
    await categoryModelProcessApi(tag: tag).then((value) {
      _categoryModel = value!;
      // searchController.text = tag;
      talentList.value = _categoryModel.data.talents;
      Get.find<BottomNavController>().selectedIndex.value = 5;
      Get.to(FeaturedCelebritiesScreen(showSearchBar: false, appTitle: name));
      _isCategoryLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isCategoryLoading.value = false;
    update();
    return _categoryModel;
  }




  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  /// ------------------------------------- >>
  final _isTalentLoading = false.obs;
  bool get isTalentLoading => _isTalentLoading.value;

  late TalentsModel _talentsModel;
  TalentsModel get talentsModel => _talentsModel;

  ///* Get Talents in process
  Future<TalentsModel> talentsProcess(String id) async {
    _isTalentLoading.value = true;
    update();
    await talentsProcessApi(id).then((value) {
      _talentsModel = value!;
      // videoPlayerController = VideoPlayerController.networkUrl(
      //     Uri.parse(_talentsModel.data.talent.videoPath)
      //     // Uri.parse("https://nextwisher.com/uploads/1734898560.mp4")
      //     )
      //   ..initialize();
      //
      // chewieController = ChewieController(
      //   aspectRatio: 4/5,
      //   maxScale: 1,
      //   videoPlayerController: videoPlayerController,
      //   autoPlay: true, // Auto-play the video
      //   looping: false, // Disable looping by default
      //   // aspectRatio: 16/9,
      //   placeholder: CustomLoadingAPI(),
      //   errorBuilder: (context, url) => Icon(Icons.error),
      //
      //
      //   allowFullScreen: true,
      //   zoomAndPan: false,
      //   fullScreenByDefault: false
      // );

      debugPrint(_talentsModel.data.talent.videoPath);
      _isTalentLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isTalentLoading.value = false;
    update();
    return _talentsModel;
  }

  @override
  void dispose() {
    // videoPlayerController.dispose();
    // chewieController.dispose();
    super.dispose();
  }
}
