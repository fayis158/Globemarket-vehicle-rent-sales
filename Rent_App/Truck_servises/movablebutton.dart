import 'package:flutter/material.dart';

class MovableButton extends StatefulWidget {
  @override
  _MovableButtonState createState() => _MovableButtonState();
}

class _MovableButtonState extends State<MovableButton> {
  Offset _position = const Offset(0, 0);

  //  late final DragController? dragController;
  // final dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movable Button'),
      ),
      body: Stack(
        children: [
          // Positioned(
          //   left: _position.dx,
          //   top: _position.dy,
          //   child: Draggable(
          //     child: Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.blue,
          //       child: const Center(
          //         child: Text(
          //           'Button',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //           ),
          //         ),
          //       ),
          //     ),
          //     feedback: Container(
          //       height: 50,
          //       width: 50,
          //       color: Colors.blue.withOpacity(0.5),
          //       child: const Center(
          //         child: Text(
          //           'Button',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //           ),
          //         ),
          //       ),
          //     ),
          //     onDraggableCanceled: (_, draggableDetails) {
          //       setState(() {
          //         // _position = draggableDetails.offset;
          //       });
          //     },
          //   ),
          // ),
          // DraggableFab(
          //   child: FloatingActionButton(
          //     onPressed: () {},
          //     child: Icon(Icons.add),
          //   ),
          // ),

          Draggable(
              feedback: Container(color: Colors.red),
              child: const Text("data")),

          // DraggableWidget(
          //   bottomMargin: 110,
          //   topMargin: 110,
          //   intialVisibility: true,
          //   horizontalSpace: 20,
          //   shadowBorderRadius: 50,
          //   initialPosition: AnchoringPosition.bottomLeft,
          //   dragController: dragController,
          //   child: Container(
          //     height: 50,
          //     width: 50,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.blue,
          //     ),
          //   ),
          // ),
        ],
      ),
      // floatingActionButton: Draggable(
      //   feedback: Container(color: Colors.red),
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     child: const Icon(Icons.add),
      //   ),
      // ),
      floatingActionButton: Draggable(
          feedback: FloatingActionButton(
              child: const Icon(Icons.drag_handle), onPressed: () {}),
          child: FloatingActionButton(
              child: const Icon(Icons.drag_handle), onPressed: () {}),
          childWhenDragging: Container(),
          onDragEnd: (details) => print(details.offset)),
    );
  }
}

// class ggggg extends StatefulWidget {
//   const ggggg({Key? key}) : super(key: key);

//   @override
//   State<ggggg> createState() => _gggggState();
// }

// class _gggggState extends State<ggggg> {
//   Offset position = const Offset(20.0, 20.0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Stack(
//         children: <Widget>[
//           // Add other content here
//           ListView.builder(
//             itemBuilder: (context, index) {
//               return Container();
//             },
//           ),

//           Positioned(
//             left: position.dx,
//             top: position.dy,
//             child: Draggable(
//               feedback: Container(
//                 child: FloatingActionButton(
//                   child: const Icon(Icons.add),
//                   onPressed: () {},
//                 ),
//               ),
//               childWhenDragging: Container(),
//               onDragEnd: (details) {
//                 setState(() {
//                   position = details.offset;
//                 });
//               },
//               child: Container(
//                 child: FloatingActionButton(
//                   child: const Icon(Icons.add),
//                   onPressed: () {},
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
