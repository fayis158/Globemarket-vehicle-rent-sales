import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Change_vehicle_number/change_vehicle_number.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Contactus/contactus.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Documents/Documents.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/Screens/Login_page/Login_with_username.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Drawer_inside_pages/Analytics/analytics.dart';
import '../../Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../Drawer_inside_pages/Change_password/change_password.dart';
import '../../Drawer_inside_pages/Report/reports.dart';

class Drawermain extends StatelessWidget {
  const Drawermain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 32, 71, 78),
              height: 160,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Center(
                        child: Image.asset(
                          "images/gpslogo1.png",
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            ListTile(
              onTap: () {
                TabBarDemo().navigateTo(context);
              },
              leading: const Icon(
                Icons.dashboard,
                color: Colors.black,
                size: 25,
              ),
              title: Text(
                'Home'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Buy_GPS2(text: "BUY GPS"),
                    ));
              },
              leading: const Icon(
                CupertinoIcons.purchased_circle,
                color: Colors.black,
                size: 25,
              ),
              title: Text(
                'BuyGPS'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Buy_GPS2(text: "Assign Vehicle"),
                    ));
                // const Ums().navigateTo(context);
              },
              leading: const Icon(
                Icons.gps_fixed,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'assignvehicle'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ExpansionTile(
              leading: const Icon(
                Icons.language,
                color: Colors.black,
              ),
              title: Text(
                'language'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.locale = const Locale('en', 'US');
                          //  Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                        },
                        child: const Text(
                          "English",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.locale = const Locale('hi', 'IN');
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                          // Navigator.of(context).pop();
                        },
                        child: const Text(
                          "हिंदी",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.setLocale(const Locale('kn', 'IN'));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                        },
                        child: const Text(
                          "ಕನ್ನಡ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.setLocale(const Locale('ta', 'IN'));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                        },
                        child: const Text(
                          "தமிழ்",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr()),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.setLocale(const Locale('gu', 'IN'));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                        },
                        child: const Text(
                          "ગુજરાતી",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr()),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.setLocale(const Locale('mr', 'IN'));
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                        },
                        child: const Text(
                          "मराठी",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr()),
                  ],
                )
              ],
            ),
            // const ListTile(
            //   leading: Icon(
            //     Icons.language,
            //     color: Colors.black,
            //     size: 28,
            //   ),
            //   title: Text(
            //     "Language",
            //     style: TextStyle(
            //         color: Colors.black,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14),
            //   ),
            // ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Reports(),
                ));
              },
              leading: const Icon(
                Icons.bar_chart_outlined,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Reports'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                const ContactUs().navigateTo(context);
              },
              leading: const Icon(
                Icons.phone,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Contactus'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Changepasswordpage().navigateTo(context);
              },
              leading: const Icon(
                Icons.password,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Changepassword'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () => launchUrl(
                  Uri.parse('https://youtube.com/@globegpstechnologies5655')),
              leading: const Icon(
                Icons.ondemand_video_sharp,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'youtube'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Documents(),
                ));
              },
              leading: const Icon(
                Icons.library_books,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Documents'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Change_vehicle_number(),
                ));
              },
              leading: const Icon(
                Icons.car_rental_sharp,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Changevehiclenum'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://parivahan.gov.in/rcdlstatus/?pur_cd=101'));
              },
              leading: const Icon(
                Icons.fact_check_outlined,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Checklicense'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () {
                const analytics().navigateTo(context);
              },
              leading: const Icon(
                Icons.analytics_outlined,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Analytics'.tr(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            ListTile(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                var data = await sp.clear();
                Homepagedatasmap.clear();
                filteredData.clear();
                allVehicle = '';
                stoppedvehicle = '';
                filteredData = [];
                finalUid = 0;
                  sp.remove("typeofuser");
                if (data == true &&
                    Homepagedatasmap.isEmpty &&
                    filteredData.isEmpty) {
                  const Login_with_username().navigateTo(context);
                }
              },
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Logout'.tr(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            Text('Legal'.tr()),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('https://www.globalgps.in/terms.aspx'));
              },
              leading: const Icon(
                CupertinoIcons.hammer_fill,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'TandC'.tr(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('http://www.globalgps.in/terms.aspx'));
              },
              leading: const Icon(
                CupertinoIcons.globe,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Oursite'.tr(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () => launchUrl(Uri.parse('https://www.globalgps.in/')),
              leading: const Icon(
                Icons.info,
                color: Colors.black,
                size: 28,
              ),
              title: Text(
                'Aboutus'.tr(),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
