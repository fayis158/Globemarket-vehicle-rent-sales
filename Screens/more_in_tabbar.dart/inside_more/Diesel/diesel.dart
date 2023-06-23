import 'package:flutter/material.dart';

class Diesel extends StatelessWidget {
  const Diesel({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("DIESEL"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                  height: 60,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // controller: Search3c,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
             ),
          ],
        ),
      ),
    );
  }
}