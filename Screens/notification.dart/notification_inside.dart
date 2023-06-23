import 'package:flutter/material.dart';

import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/notification.dart/notification.dart';
import 'package:url_launcher/url_launcher.dart';

class Notification_inside extends StatelessWidget {
  String vehiclenum;
  String date;
  String location;
  String link;
  Notification_inside(
      {super.key,
      required this.vehiclenum,
      required this.date,
      required this.location,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const notificationclass(),
                ));
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehiclenum,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              date,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(width: width(context) * 0.5, child: Text(location)),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(
                    Uri.parse(link));
              },
              child: Text(
                link,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//https://www.google.com/maps/@12.9466368,77.5880704,12z