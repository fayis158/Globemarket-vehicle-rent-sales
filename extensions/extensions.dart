import 'package:flutter/material.dart';

extension Navigation on StatefulWidget {
  navigateTo(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => this));
  }
}