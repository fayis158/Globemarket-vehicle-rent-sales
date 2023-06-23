

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bearing {
  static double getBearing(LatLng startPosition, LatLng endPosition) {
    double latitudeDiff = (startPosition.latitude - endPosition.latitude).abs();
    double longitudeDiff =
        (startPosition.longitude - endPosition.longitude).abs();

    if (startPosition.latitude < endPosition.latitude &&
        startPosition.longitude < endPosition.longitude) {
      return (atan(longitudeDiff / latitudeDiff) * 180 / pi);
    } else if (startPosition.latitude >= endPosition.latitude &&
        startPosition.longitude < endPosition.longitude) {
      return (90 - atan(longitudeDiff / latitudeDiff) * 180 / pi) + 90;
    } else if (startPosition.latitude >= endPosition.latitude &&
        startPosition.longitude >= endPosition.longitude) {
      return atan(longitudeDiff / latitudeDiff) * 180 / pi + 180;
    } else if (startPosition.latitude < endPosition.latitude &&
        startPosition.longitude >= endPosition.longitude) {
      return (90 - atan(longitudeDiff / latitudeDiff) * 180 / pi) + 270;
    }

    return -1;
  }
}

class Circularprogress extends StatelessWidget {
  const Circularprogress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.95,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CircularProgressIndicator(),
            Text(
              "LOADING.. PLEASE WAIT",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  const CountWidget({super.key, required this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 12,
      backgroundColor: Colors.red,
      child: Text(
        '$count',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
