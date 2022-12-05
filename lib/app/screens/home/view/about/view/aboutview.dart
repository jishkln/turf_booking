import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:get/get.dart';
import 'package:truff_majestic/app/screens/home/view/about/controller/aboutcontroller.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';

class AboutScreen extends GetView<ProfileController> {
  AboutScreen({Key? key}) : super(key: key);

  final aboutcontroller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [white1Color, greenColor],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey,
          centerTitle: true,
          title:  Text(
            'About',
            style: TurffTheme.darkTextTheme.headline1,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 50,
              ),
              child: TabBar(
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  indicator:
                      const UnderlineTabIndicator(borderSide: BorderSide.none),
                  controller: aboutcontroller.controller,
                  tabs: aboutcontroller.myTap
                 
                  ),
            ),
            CustomCard(
              color: const Color.fromARGB(255, 235, 239, 230),
              elevation: 15,
              shadowColor: Colors.green,
              borderRadius: 30,
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(
                  controller: aboutcontroller.controller,
                  children: const [
                    Center(
                      child: Text(
                        'Welcome to Arco and enjoy your game with better turf. you can book your nearest turf or favourite turf ,enjoy your game and share your experience,thank you.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Text(
                        "I am Jishnu from kerala.I Expertised in UI/UX Designing and Flutter development based on kerala,currently iam a freelance worker. i developed this app and i think you got better experience from here. Once of all thank you for supporting me.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}