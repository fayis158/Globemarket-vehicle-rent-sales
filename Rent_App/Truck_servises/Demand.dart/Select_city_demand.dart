import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../Constant.dart';

String? globefromcitydemand;
String? globeltocitydemand;

class Select_City_demand extends StatefulWidget {
  Select_City_demand({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _Select_City_demandState createState() => _Select_City_demandState();
}

class _Select_City_demandState extends State<Select_City_demand> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: googleAPiKey,
        inputDecoration:
            const InputDecoration(hintText: "Search your location"),
        debounceTime: 800,
        countries: ["in", "fr"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // print("placeDetails" + prediction.lng.toString());
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;

          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
          globefromcitydemand = controller.text;
          Navigator.pop(context);
        },
      ),
    );
  }
}

//To City

class Select_CityTodemand extends StatefulWidget {
  Select_CityTodemand({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _Select_CityTodemandState createState() => _Select_CityTodemandState();
}

class _Select_CityTodemandState extends State<Select_CityTodemand> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: googleAPiKey,
        inputDecoration:
            const InputDecoration(hintText: "Search your location"),
        debounceTime: 800,
        countries: ["in", "fr"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // print("placeDetails" + prediction.lng.toString());
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;

          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
          globeltocitydemand = controller.text;
          Navigator.pop(context);
        },
      ),
    );
  }
}
