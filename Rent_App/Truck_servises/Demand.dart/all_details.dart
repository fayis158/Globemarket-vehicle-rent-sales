import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constant.dart';
import '../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../Supply/supply_container_details.dart';

class All_Setails_demand extends StatelessWidget {
  const All_Setails_demand({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: rentappbarcolor,
        title: const Text("Demand"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Rowwithtwotext(
                name: "Name",
                details: "Edison",
              ),
              const SizedBox(
                height: 12,
              ),
              const Rowwithtwotext(
                name: "From",
                details: "Dasarahalli bangaluru",
              ),
              const SizedBox(
                height: 12,
              ),
              const Rowwithtwotext(
                name: "To",
                details: "Dasarahalli bangaluru",
              ),
              const SizedBox(
                height: 12,
              ),
              const Rowwithtwotext(
                name: "Details",
                details: "Truck ",
              ),
              const SizedBox(
                height: 12,
              ),
              const Rowwithtwotext(
                name: "Date",
                details: "12/10/2012",
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.phone),
                    color: Colors.green,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.whatsapp),
                    color: Colors.green,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share),
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.48,
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(const Buy_GPS()),
                        child: BoxWidget(
                            color: const Color.fromARGB(255, 39, 45, 44),
                            subject: "BUY GPS",
                            icon: const Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                            )),
                      ),
                      BoxWidget(
                          color: Colors.blue,
                          subject: "BASKET",
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  TableRow(
                    children: [
                      GestureDetector(
                          onTap: () {
                            launch("tel://$numberbuygps");
                          },
                          child: BoxWidget(
                              color: Colors.green,
                              subject: "HELP LINE",
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ))),
                      BoxWidget(
                          color: const Color.fromARGB(255, 80, 73, 11),
                          subject: "RECORD",
                          icon: const Icon(
                            Icons.record_voice_over,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//

class Rowwithtwotext extends StatelessWidget {
  const Rowwithtwotext({Key? key, required this.details, required this.name})
      : super(key: key);

  final String details;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$name :",
          style: const TextStyle(
              color: Color.fromARGB(255, 1, 50, 64), fontSize: 18),
        ),
        Text(
          details,
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
        ),
      ],
    );
  }
}
