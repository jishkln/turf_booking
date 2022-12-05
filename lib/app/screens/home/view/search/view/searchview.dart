import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/home/controller/home_view.dart';
import 'package:truff_majestic/app/screens/home/model/home_model.dart';
import 'package:truff_majestic/app/screens/home/view/detail_page.dart';
import 'package:truff_majestic/app/screens/home/view/search/controller/searchcontroler.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

class SearchScreen extends GetView<SearchController> {
  SearchScreen({Key? key, required this.allturfList}) : super(key: key);
  final List<DataList> allturfList;
  final searchcontrollera = Get.put(SearchController());
  //final homeControllera = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlueAccent.withOpacity(0.5), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Search Your Turfs',
              style: TurffTheme.darkTextTheme.headline2,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 7.0,
                ),
                GetBuilder<SearchController>(
                  builder: (controller) => TextField(
                    onChanged: (value) =>
                        controller.runFilter(value, allturfList),
                    decoration: InputDecoration(
                      hintText: "Search your turf",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                GetBuilder<SearchController>(
                  builder: (controller) => Expanded(
                    child: controller.serchTurf.isNotEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: controller.serchTurf.length,
                              itemBuilder: (BuildContext context, int index) {
                                final datas = controller.serchTurf[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () =>
                                        Get.to(() => DetailPage(data: datas)),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: white1Color,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              bottomRight:
                                                  Radius.circular(40))),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7.0,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(datas
                                                        .turfLogo
                                                        .toString()),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                14,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                        vertical: 20),
                                                child: SizedBox(
                                                  width: 150,
                                                  height: 30,
                                                  child: FittedBox(
                                                    child: Text(
                                                        datas.turfName
                                                            .toString(),
                                                        style: TurffTheme
                                                            .darkTextTheme
                                                            .headline3),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      ),
                                                      Text(datas
                                                          .turfInfo!.turfRating!
                                                          .toString())
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            5,
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.favorite_outline),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              "NO Data Found",
                              style: TurffTheme.darkTextTheme.headline1,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
