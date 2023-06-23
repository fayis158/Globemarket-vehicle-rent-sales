// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class backplay extends StatefulWidget {
//     String vid;
//   String vehiclenum;
//    backplay({super.key, required this.vehiclenum, required this.vid});



//   @override
//   State<backplay> createState() => _backplayState();
// }

// class _backplayState extends State<backplay> {
//   GlobalKey actionKey = GlobalKey();


// void showMenuOptions() {
//     final RenderBox renderBox =
//         actionKey.currentContext!.findRenderObject() as RenderBox;
//     final position = renderBox.localToGlobal(Offset.zero);
//     final size = renderBox.size;

//     showMenu(
//       context: context,
//       position: RelativeRect.fromLTRB(
//           position.dx, position.dy + size.height, position.dx + size.width, 0),
//       items: [
//         PopupMenuItem(
//           child: Row(
//             children: const [
//               Icon(Icons.check,
//                   // color: selectedtoday == true ? Colors.green : Colors.grey,
//                   ),
//               Text("Today"),
//             ],
//           ),
//           onTap: () {
           
           
//           },
//         ),
//         PopupMenuItem(
//           child: Row(
//             children: const [
//               Icon(Icons.check,
//                   // color:
//                       // selectedyesterday == true ? Colors.green : Colors.grey,
//                       ),
//               Text("Yesterday"),
//             ],
//           ),
//           onTap: () {
            
           
//           },
//         ),
//         PopupMenuItem(
//           child: Row(
//             children: const [
//               Icon(Icons.check,
                
//                       ),
//               Text("Day Before Yesterday"),
//             ],
//           ),
//           onTap: () {
           
           
//           },
//         ),
//         PopupMenuItem(
//           onTap: () {
//             setState(() {
            
//             });
//           },
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//               setState(() {
             
//               });

//               setState(() {});
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.055,
//               color: const Color.fromARGB(0, 255, 255, 255),
//               child: Row(
//                 children: const [
//                   Icon(Icons.check,
//                       // color: selecteddayrandom == true
//                       //     ? Colors.green
//                       //     : Colors.grey
//                           ),
//                   Text('Userdefined'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }


// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//         title: Text(widget.vehiclenum),
//         actions: [
//           TextButton(
//               onPressed: () {
   
//               },
//               child: const Text("check")),
         
//           FocusedMenuHolder(
//             animateMenuItems: true,
//             openWithTap: true,
//             blurSize: 0,
//             menuWidth: MediaQuery.of(context).size.width * 0.50,
//             onPressed: () {},
//             menuItems: [
//               FocusedMenuItem(
//                   title: Row(
//                     children: const [
//                       Icon(
//                         Icons.check,
//                         size: 22,
//                       ),
//                       Text("   Very slow"),
//                     ],
//                   ),
//                   onPressed: () {
//                     setState(() {
            
//                     });
//                   }),
//               FocusedMenuItem(
//                   title: Row(
//                     children: const [
//                       Icon(
//                         Icons.check,
//                         size: 22,
//                       ),
//                       Text("   Slow"),
//                     ],
//                   ),
//                   onPressed: () {
//                     setState(() {
             
//                     });
//                   }),
//               FocusedMenuItem(
//                   title: Row(
//                     children: const [
//                       Icon(
//                         Icons.check,
//                         size: 22,
//                       ),
//                       Text("   Normal"),
//                     ],
//                   ),
//                   onPressed: () {
//                     setState(() {
          
//                     });
//                   }),
//               FocusedMenuItem(
//                   title: Row(
//                     children: const [
//                       Icon(
//                         Icons.check,
//                         size: 22,
//                       ),
//                       Text("    Fast"),
//                     ],
//                   ),
//                   onPressed: () {
//                     setState(() {
             
//                     });
//                   }),
//               FocusedMenuItem(
//                   title: Row(
//                     children: const [
//                       Icon(
//                         Icons.check,
//                         size: 22,
//                       ),
//                       Text("    Very fast"),
//                     ],
//                   ),
//                   onPressed: () {
//                     setState(() {
      
//                     });
//                   }),
//             ],
//             child: const Icon(
//               Icons.play_circle_outline,
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           GestureDetector(
//             onTap: showMenuOptions,
//             child: Container(
//               key: actionKey,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: const Icon(
//                 Icons.watch_later_outlined,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 12,
//           ),

//           FocusedMenuHolder(
//             animateMenuItems: true,
//             openWithTap: true,
//             blurSize: 0,
//             menuWidth: MediaQuery.of(context).size.width * 0.50,
//             onPressed: () {},
//             menuItems: [
//               FocusedMenuItem(
//                   title: const Text("30 ${'minutes'}"), onPressed: () {}),
//               FocusedMenuItem(
//                   title: const Text("2 ${'hour'}"), onPressed: () {}),
//               FocusedMenuItem(
//                   title: const Text("4 ${'hour'}"), onPressed: () {}),
//               FocusedMenuItem(
//                   title: const Text("8 ${'hour'}"), onPressed: () {}),
//               FocusedMenuItem(
//                   title: const Text("12 ${'hour'}"), onPressed: () {}),
//               FocusedMenuItem(
//                   title: const Text("24 ${'hour'}"), onPressed: () {}),
//               FocusedMenuItem(title: const Text('custom'), onPressed: () {}),
//             ],
//             child: const Icon(
//               Icons.share,
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//         ],
//       ),
//       body: const GoogleMap(initialCameraPosition: CameraPosition(
//                     target: LatLng(19.0759837, 72.8776559),
//                     zoom: 16,
//                   ),),
//     );
//   }
// }