import 'package:flutter/material.dart';

import 'Api_Truck_service/ApiT.dart';
import 'Supply/Supply.dart';

class ScrollableDropdownloading extends StatefulWidget {
  ScrollableDropdownloading({required this.onItemSelected});

  final Function(String?) onItemSelected;
  @override
  _ScrollableDropdownloadingState createState() =>
      _ScrollableDropdownloadingState();
}

class _ScrollableDropdownloadingState extends State<ScrollableDropdownloading> {
  String? selectedItem;
  String? selectedId2;
  List<DropdownItem> items = [
    DropdownItem(
        text: 'All Vehicles',
        imagePath: 'rentimages/white.png',
        idvehicel: "0"),
    DropdownItem(
        text: 'Tempoo  (3-4 Wheeler 300kg-1 Ton)',
        imagePath: 'rentimages/tempoo.png',
        idvehicel: "10"),
    DropdownItem(
        text: 'Bolero  (4 wheeeler) 1.5 Ton',
        imagePath: 'rentimages/bolero.png',
        idvehicel: "11"),
    DropdownItem(
        text: 'Tata 407 (4 wheeeler 2.5 Ton)',
        imagePath: 'rentimages/tata407.png',
        idvehicel: "12"),
    DropdownItem(
        text: 'Truck (14 FT 4 Ton)',
        imagePath: 'rentimages/truck14.png',
        idvehicel: "13"),
    DropdownItem(
        text: 'Truck (17 FT 5 Ton)',
        imagePath: 'rentimages/17ft.png',
        idvehicel: "14"),
    DropdownItem(
        text: 'Truck (19 FT 6-9 Ton)',
        imagePath: 'rentimages/19ft.png',
        idvehicel: "15"),
    DropdownItem(
        text: 'Truck (6 TYPE 9-12 Ton)',
        imagePath: 'rentimages/6type.png',
        idvehicel: "16"),
    DropdownItem(
        text: 'Truck (10 TYPE 16-20 Ton)',
        imagePath: 'rentimages/1620t.png',
        idvehicel: "17"),
    DropdownItem(
        text: 'Truck (12 TYPE 21-25 Ton)',
        imagePath: 'rentimages/12type.png',
        idvehicel: "18"),
    DropdownItem(
        text: 'Truck (14 TYPE 25-30 Ton)',
        imagePath: 'rentimages/14type.png',
        idvehicel: "19"),
    DropdownItem(
        text: 'Truck (16 TYPE 31-34 Ton)',
        imagePath: 'rentimages/16.png',
        idvehicel: "20"),
    DropdownItem(
        text: 'Truck (18 TYPE 35-38 Ton)',
        imagePath: 'rentimages/18.png',
        idvehicel: "21"),
    DropdownItem(
        text: 'Truck (22 TYPE 38-42 Ton)',
        imagePath: 'rentimages/22.png',
        idvehicel: "22"),
    DropdownItem(
        text: 'Trailer (High Bed 20-50 Ton)',
        imagePath: 'rentimages/highbed.png',
        idvehicel: "23"),
    DropdownItem(
        text: 'Trailer (Flat Bed 20-50 Ton)',
        imagePath: 'rentimages/flatbed.png',
        idvehicel: "24"),
    DropdownItem(
        text: 'Trailer (Semi Bed 20-50 Ton)',
        imagePath: 'rentimages/semibed.png',
        idvehicel: "25"),
    DropdownItem(
        text: 'Container (20 FT 5-10 Ton)',
        imagePath: 'rentimages/510container.png',
        idvehicel: "26"),
    DropdownItem(
        text: 'Container (24 FT 9-14 Ton)',
        imagePath: 'rentimages/914.png',
        idvehicel: "27"),
    DropdownItem(
        text: 'Container (32 FT 7-20 Ton)',
        imagePath: 'rentimages/32.png',
        idvehicel: "28"),
    DropdownItem(
        text: 'Container (33 FT)',
        imagePath: 'rentimages/32ft.png',
        idvehicel: "29"),
    DropdownItem(
        text: 'Container (Above 33 FT)',
        imagePath: 'rentimages/33ft.png',
        idvehicel: "30"),
    DropdownItem(
        text: 'Crane', imagePath: 'rentimages/crane.png', idvehicel: "31"),
    DropdownItem(
        text: 'Tipper', imagePath: 'rentimages/tipper.png', idvehicel: "32"),
    DropdownItem(
        text: 'Tanker', imagePath: 'rentimages/tanker.png', idvehicel: "33"),
    DropdownItem(
        text: 'refrigerator', imagePath: 'rentimages/ref.png', idvehicel: "34"),
    DropdownItem(
        text: 'Tractor', imagePath: 'rentimages/tract.png', idvehicel: "35"),
    DropdownItem(text: 'JCB', imagePath: 'rentimages/jcb.png', idvehicel: "36"),
    DropdownItem(
        text: 'Packers And Movers',
        imagePath: 'rentimages/pakmov.png',
        idvehicel: "337"),
    DropdownItem(
        text: 'Brokers And transporters',
        imagePath: 'rentimages/co.png',
        idvehicel: "38"),
    DropdownItem(
        text: 'Hitachi', imagePath: 'rentimages/hitachi.png', idvehicel: "39"),
    DropdownItem(
        text: 'Courier', imagePath: 'images/bell1.png', idvehicel: "40"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      // color: Colors.red,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: DropdownButtonFormField<String>(
          menuMaxHeight: 400,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: selectedId2,
          hint: const Text('Select a Vehicle Type'),
          onChanged: (String? value) {
            setState(() {
              selectedId2 = value;
            });

            widget.onItemSelected(selectedId2);
          },
          items: items.map((DropdownItem item) {
            return DropdownMenuItem<String>(
              value: item.idvehicel,
              child: Row(
                children: [
                  Image.asset(
                    item.imagePath,
                    width: 55,
                    height: 55,
                  ),
                  const SizedBox(width: 8),
                  Text(item.text),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      // SingleChildScrollView(
      //   physics: const ScrollPhysics(),
      //   child: DropdownButtonFormField<DropdownItem>(
      //     menuMaxHeight: 400,
      //     decoration: const InputDecoration(
      //       border: OutlineInputBorder(),
      //     ),
      //     value: selectedItem,
      //     hint: const Text('Select an Vehicle Type'),
      //     onChanged: (String? value) {
      //       selectedItem = value;
      //        widget.onItemSelected(selectedItem);
      //     },
      //     items: items.map((DropdownItem item) {
      //       return DropdownMenuItem<DropdownItem>(
      //         value: item,
      //         child: Row(
      //           children: [
      //             Image.asset(
      //               item.imagePath,
      //               width: 55,
      //               height: 55,
      //             ),
      //             const SizedBox(width: 8),
      //             Text(item.text),
      //           ],
      //         ),
      //       );
      //     }).toList(),
      //   ),
      // ),
    );
  }
}

// class ScrollableDropdown extends StatefulWidget {
//   final Function(DropdownItem?) onItemSelected;

//   ScrollableDropdown({required this.onItemSelected});
//   @override
//   _ScrollableDropdownState createState() => _ScrollableDropdownState();
// }

// class _ScrollableDropdownState extends State<ScrollableDropdown> {
//   DropdownItem? selectedItem;
//   List<DropdownItem> items = [
//     DropdownItem(
//         text: 'Auto(3 Seats)',
//         imagePath: 'rentimages/auto.zip',
//         idvehicel: "1"),
//     DropdownItem(
//         text: '2 Wheeler(2 Seater)',
//         imagePath: 'rentimages/twowheeler.png',
//         idvehicel: "2"),
//     DropdownItem(
//         text: 'seden car(4-5 seats)',
//         imagePath: 'rentimages/sedan.png',
//         idvehicel: "3"),
//     DropdownItem(
//         text: 'Luxury Car(5-6 seats)',
//         imagePath: 'rentimages/luxurycar.png',
//         idvehicel: "4"),
//     DropdownItem(
//         text: 'SUV (6-9 seats)',
//         imagePath: 'rentimages/suv.png',
//         idvehicel: "5"),
//     DropdownItem(
//         text: 'Tempo Traveller(9-16 seats)',
//         imagePath: 'rentimages/traveller.png',
//         idvehicel: "6"),
//     DropdownItem(
//         text: 'Mini Bus(16-39 seats)',
//         imagePath: 'rentimages/minibus.png',
//         idvehicel: "7"),
//     DropdownItem(
//         text: 'Big Bus (39-54 seats)',
//         imagePath: 'rentimages/bigbus.png',
//         idvehicel: "8"),
//     DropdownItem(
//         text: 'Ambulance',
//         imagePath: 'rentimages/ambulance.png',
//         idvehicel: "9"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       // color: Colors.red,
//       child: SingleChildScrollView(
//         physics: const ScrollPhysics(),
//         child: DropdownButtonFormField<DropdownItem>(
//           menuMaxHeight: 400,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//           ),
//           value: selectedItem,
//           hint: const Text('Select an Vehicle Type'),
//           onChanged: (DropdownItem? value) {
//             selectedItem = value;

//             widget.onItemSelected(selectedItem);

//           },
//           items: items.map((DropdownItem item) {
//             return DropdownMenuItem<DropdownItem>(
//               value: item,
//               child: Row(
//                 children: [
//                   Image.asset(
//                     item.imagePath,
//                     width: 55,
//                     height: 55,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(item.text),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

class ScrollableDropdown extends StatefulWidget {
  final Function(String?) onItemSelected;

  ScrollableDropdown({required this.onItemSelected});

  @override
  _ScrollableDropdownState createState() => _ScrollableDropdownState();
}

class _ScrollableDropdownState extends State<ScrollableDropdown> {
  String? selectedId;

  List<DropdownItem> items = [
    DropdownItem(
        text: 'All Vehicles',
        imagePath: 'rentimages/white.png',
        idvehicel: "0"),
    DropdownItem(
        text: 'Auto(3 Seats)',
        imagePath: 'rentimages/auto.zip',
        idvehicel: "1"),
    DropdownItem(
        text: '2 Wheeler(2 Seater)',
        imagePath: 'rentimages/twowheeler.png',
        idvehicel: "2"),
    DropdownItem(
        text: 'seden car(4-5 seats)',
        imagePath: 'rentimages/sedan.png',
        idvehicel: "3"),
    DropdownItem(
        text: 'Luxury Car(5-6 seats)',
        imagePath: 'rentimages/luxurycar.png',
        idvehicel: "4"),
    DropdownItem(
        text: 'SUV (6-9 seats)',
        imagePath: 'rentimages/suv.png',
        idvehicel: "5"),
    DropdownItem(
        text: 'Tempo Traveller(9-16 seats)',
        imagePath: 'rentimages/traveller.png',
        idvehicel: "6"),
    DropdownItem(
        text: 'Mini Bus(16-39 seats)',
        imagePath: 'rentimages/minibus.png',
        idvehicel: "7"),
    DropdownItem(
        text: 'Big Bus (39-54 seats)',
        imagePath: 'rentimages/bigbus.png',
        idvehicel: "8"),
    DropdownItem(
        text: 'Ambulance',
        imagePath: 'rentimages/ambulance.png',
        idvehicel: "9"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: DropdownButtonFormField<String>(
          menuMaxHeight: 400,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: selectedId,
          hint: const Text('Select a Vehicle Type'),
          onChanged: (String? value) {
            setState(() {
              selectedId = value;
            });
            widget.onItemSelected(selectedId);
          },
          items: items.map((DropdownItem item) {
            return DropdownMenuItem<String>(
              value: item.idvehicel,
              child: Row(
                children: [
                  Image.asset(
                    item.imagePath,
                    width: 55,
                    height: 55,
                  ),
                  const SizedBox(width: 8),
                  Text(item.text),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
