


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../backend/services/dashboard/dashboard_service.dart';
import '../../backend/services/dashboard/home_model.dart';

class DashboardController extends GetxController with DashboardService{

  final List category = [
    {
      "name": "Music",
      "icon": Icons.music_note_outlined
    },
    {
      "name": "Sports",
      "icon": Icons.sports_basketball_outlined
    },
    {
      "name": "Actors",
      "icon": Icons.people_alt_outlined
    },
    {
      "name": "People",
      "icon": Icons.accessibility_outlined
    },
    {
      "name": "Models",
      "icon": Icons.model_training_outlined
    },
    {
      "name": "TV/Radio",
      "icon": Icons.radio_outlined
    },
  ];




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

}