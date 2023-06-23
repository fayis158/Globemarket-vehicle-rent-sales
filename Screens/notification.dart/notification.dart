
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Screens/notification.dart/notification_inside.dart';
import 'package:http/http.dart' as http;

class notificationclass extends StatefulWidget {
  const notificationclass({super.key});

  @override
  State<notificationclass> createState() => _notificationclassState();
}

class _notificationclassState extends State<notificationclass> {
  @override
  void initState() {
    super.initState();
    not();
  }

  bool isloading = false;

  not() async {
    await Api.notification();
    setState(() {
      isloading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: Text("notification".tr()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: isloading == false
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notificationlist.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Notification_inside(
                      vehiclenum: "${notificationlist[index]["vehicleNo"]}",
                      location: "${notificationlist[index]["message"]}",
                      date: "${notificationlist[index]["date"]}",
                      link:
                          "https://www.google.com/maps/@${notificationlist[index]["latitude"]},${notificationlist[index]["longitude"]}",
                    ),
                  ));
                },
                leading: const Icon(Icons.mail_outline),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${notificationlist[index]["vehicleNo"]},(${notificationlist[index]["alertType"]})"),
                    Text(
                      "${notificationlist[index]["date"]}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 19,
                ),
              ),
            ),
    );
  }
}
