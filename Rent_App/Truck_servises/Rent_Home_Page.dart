
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';

import 'package:gpsglobe/Rent_App/Truck_servises/Supply/add_my_vehicle.dart';
import 'package:gpsglobe/global/global.dart';

import 'Demand.dart/add_demand_vehicle.dart';
import 'Supply/Supply.dart';
import 'comingsoon.dart';

class Truck_services extends StatefulWidget {
  @override
  _Truck_servicesState createState() => _Truck_servicesState();
}

class _Truck_servicesState extends State<Truck_services> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Supply(),
    Comingsoon(title: "Demand"),
    Comingsoon(title: "Vehicle for sale"),
    Comingsoon(
      title: "Site's",
    )
    // Demand(),
    // Sales(),
    // const Sites(),
    // Container(
    //   color: Colors.red,
    //   child: const Center(
    //     child: Text('Page 4'),
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          if (finalUid == 0) {
            SystemNavigator.pop();
            return Future.value(true);
          } else {
            navigator!.pop(context);
            return Future.value(false);
          }
        },
        child: Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _selectedIndex == 0
                  ? Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: FloatingActionButton(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Add_my_vehicle(),
                              ));
                            },
                            child: const Text(
                              "+ Add Vehicle",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    )
                  : _selectedIndex == 1
                      ? SizedBox(
                          height: 50,
                          width: 60,
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 75, 8, 3),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Add_demand_vehicles(),
                              ));
                            },
                            child: const Text(
                              "+Add",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
              const SizedBox(width: 10),
            ],
          ),

          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,`
          body: _pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            backgroundColor: Colors.grey,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: const Color.fromRGBO(158, 158, 158, 1),
                label: "Rent",
                icon: Icon(
                  FontAwesomeIcons.truck,
                  color: _selectedIndex == 0
                      ? const Color.fromARGB(255, 174, 54, 244)
                      : Colors.white,
                ),
                // title: Text('Home'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey,
                label: "Demand",
                icon: Icon(
                  Icons.menu,
                  color: _selectedIndex == 1
                      ? const Color.fromARGB(255, 174, 54, 244)
                      : Colors.white,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey,
                label: "Sales",
                icon: Icon(
                  Icons.shopping_cart,
                  color: _selectedIndex == 2
                      ? const Color.fromARGB(255, 174, 54, 244)
                      : Colors.white,
                ),
                // icon: Text('Notifications'),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.grey,
                label: "Site's",
                icon: Icon(
                  Icons.landscape,
                  color: _selectedIndex == 3
                      ? const Color.fromARGB(255, 174, 54, 244)
                      : Colors.white,
                ),
                // title: Text('Search'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
