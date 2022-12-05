import 'dart:developer';

import 'package:get/get.dart';
import 'package:truff_majestic/app/screens/home/controller/geolocator.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';

class SearchController extends GetxController {
  final allTurfControler = Get.put(LocationProvider());
  List<DataList> serchTurf = [];
  @override
  void onInit() {
    serchTurf = allTurfControler.turfList;
    super.onInit();
  }

  void runFilter(String keyWord, List<DataList> allTurfList) {
    log(allTurfControler.turfList.toString());
    log(keyWord);

    List<DataList> results = [];
    if (keyWord.isEmpty) {
      results = allTurfList;
    } else {
      results = allTurfList
          .where((element) =>
              element.turfName!.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    }
    serchTurf = results;
    log("message $serchTurf");
    update();
  }
}
