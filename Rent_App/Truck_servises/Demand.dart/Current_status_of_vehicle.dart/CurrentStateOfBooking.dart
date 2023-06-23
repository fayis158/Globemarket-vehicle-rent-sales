import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../required.dart';

class Current_State_of_bookings extends StatelessWidget {
  const Current_State_of_bookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 39, 38, 36),
            title: const Text("Current Status Of My Booking")),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return const Required_vehicle();
          },
        ));
  }
}
