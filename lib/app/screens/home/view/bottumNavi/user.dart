import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:truff_majestic/app/screens/auth/login_page/view/login_email.dart';
import 'package:truff_majestic/app/screens/home/view/about/view/aboutview.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/navigation.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: ListView(
          children: [
            BigUserCard(
              cardColor: greenColor,
              userName: 'Jishnu',
              userProfilePic:
                  const AssetImage('assets/images/login_image/cricket.png'),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Update",
                titleStyle: const TextStyle(color: greenColor),
                subtitle: "Tap to change your data",
                onTap: () {
                  if (kDebugMode) {
                    print("OK");
                  }
                },
              ),
            ),
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () async {
                    await storage.deleteAll();

                    NavigationServices.pushRemoveUntil(
                        screen: const LoginEmail());
                  },
                  icons: Icons.exit_to_app_rounded,
                  titleStyle: const TextStyle(color: greenColor),
                  title: "Sign Out",
                  subtitle: 'See You Later',
                  iconStyle: IconStyle(backgroundColor: redColor),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                    onTap: () {},
                    icons: CupertinoIcons.pencil_outline,
                    iconStyle: IconStyle(),
                    title: 'Privacy Policy',
                    subtitle: "© 2022 All Rights Reserved",
                    titleStyle: const TextStyle(color: greenColor)),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Get.to(() => AboutScreen());
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  titleStyle: const TextStyle(color: greenColor),
                  subtitle: "Learn more about Estadio App",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
