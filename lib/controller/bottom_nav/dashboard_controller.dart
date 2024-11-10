import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../backend/services/dashboard/dashboard_service.dart';
import '../../backend/services/dashboard/home_model.dart';
import '../../backend/services/dashboard/talents_model.dart';

class DashboardController extends GetxController with DashboardService {
  // final List category = [
  //   {
  //     "name": "Music",
  //     "icon": Icons.music_note_outlined
  //   },
  //   {
  //     "name": "Sports",
  //     "icon": Icons.sports_basketball_outlined
  //   },
  //   {
  //     "name": "Actors",
  //     "icon": Icons.people_alt_outlined
  //   },
  //   {
  //     "name": "People",
  //     "icon": Icons.accessibility_outlined
  //   },
  //   {
  //     "name": "Models",
  //     "icon": Icons.model_training_outlined
  //   },
  //   {
  //     "name": "TV/Radio",
  //     "icon": Icons.radio_outlined
  //   },
  // ];

  @override
  void onInit() {
    homeProcess();
    super.onInit();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late HomeModel _homeModel;
  HomeModel get homeModel => _homeModel;

  ///* Get Home in process
  Future<HomeModel> homeProcess() async {
    _isLoading.value = true;
    update();
    await homeProcessApi().then((value) {
      _homeModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _homeModel;
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
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(_talentsModel.data.talent.videoPath)
          // "https://next-wisher.skyflightbd.com/public/uploads/1730566102.mp4"),
          )
        ..initialize();

      chewieController = ChewieController(
        // aspectRatio: 1,
        videoPlayerController: videoPlayerController,
        autoPlay: false,
        looping: true,
      );

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
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
