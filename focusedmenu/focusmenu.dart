import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class MyWidget extends StatefulWidget {
  final List<String> items;

  MyWidget({required this.items});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return FocusedMenuHolder(
            menuWidth: MediaQuery.of(context).size.width * 0.50,
            blurSize: 5.0,
            menuItemExtent: 45,
            menuBoxDecoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            duration: const Duration(milliseconds: 100),
            animateMenuItems: true,
            blurBackgroundColor: Colors.black54,
            openWithTap: true,
            menuOffset: 10.0,
            onPressed: () {},
            menuItems: <FocusedMenuItem>[
              FocusedMenuItem(
                title: const Text("Open"),
                onPressed: () {},
              ),
              FocusedMenuItem(
                title: const Text("Share"),
                onPressed: () {},
              ),
            ],
            child: ListTile(
              title: Text(widget.items[index]),
            ),
          );
        },
      ),
    );
  }
}
