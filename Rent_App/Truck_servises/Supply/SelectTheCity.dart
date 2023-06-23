import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/add_my_vehicle.dart';

import '../../../Constant.dart';

String? globefromcity;
String? globeltocity; 

class Select_City extends StatefulWidget {
  Select_City({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _Select_CityState createState() => _Select_CityState();
}

class _Select_CityState extends State<Select_City> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 39, 38, 36),
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
        inputDecoration: const InputDecoration(hintText: "Search your location"),
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
          globefromcity = controller.text;
          Navigator.pop(context);
        },
      ),
    );
  }
}

//To City

class Select_CityTo extends StatefulWidget {
  Select_CityTo({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _Select_CityToState createState() => _Select_CityToState();
}

class _Select_CityToState extends State<Select_CityTo> {
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
        inputDecoration: const InputDecoration(hintText: "Search your location"),
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
            globeltocity = controller.text;
          Navigator.pop(context);
        },
      ),
    );
  }
}
