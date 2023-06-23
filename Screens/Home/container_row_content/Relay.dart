import 'dart:async';
import 'package:flutter/material.dart';
import '../../../Api/api.dart';

class Relay extends StatefulWidget {
  var vid;
  Relay({super.key, required this.vid});

  @override
  State<Relay> createState() => _RelayState();
}

class _RelayState extends State<Relay> {
  Color iconcolorred = Colors.red;
  Color iconcolorgreen = Colors.green;
  Color iconcolorgrey = Colors.grey;
  bool colorcondition = false;

  int _countdown = 25;
  Timer? _timer;
  bool isButtonDisabled = false;

  @override
  void initState() {
    super.initState();

  }

  

  void showrelaydDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          colorcondition == false;
          _countdown--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
      setState(() {
        isButtonDisabled = false;
        _countdown = 25;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        iconSize: 50,
                        onPressed: isButtonDisabled
                            ? null
                            : () {
                                setState(() {
                                  isButtonDisabled = true;
                                  Api.relaymessage(widget.vid, 3);

                                  showrelaydDialog(context,
                                      "$relaymes Relay Command is in queue");
                                  relaylist.clear();
                                  Api.Relay(widget.vid);
                                });
                                _startTimer();
                              },
                        icon: Icon(Icons.power_settings_new_rounded,
                            color: iconcolorred),
                      ),
                      Text(
                        "OFF",
                        style: TextStyle(
                            color: iconcolorred, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        iconSize: 50,
                        onPressed: isButtonDisabled
                            ? null
                            : () {
                                setState(() {
                                  isButtonDisabled = true;
                                  Api.relaymessage(widget.vid, 4);
                                  showrelaydDialog(context,
                                      "$relaymes Relay Command is in queue");
                                  relaylist.clear();
                                  Api.Relay(widget.vid);
                                });
                                _startTimer();
                              },
                        icon: Icon(
                          Icons.power_settings_new_rounded,
                          color: iconcolorgreen,
                        ),
                      ),
                      Text(
                        "ON",
                        style: TextStyle(
                            color: iconcolorgreen, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            isButtonDisabled && _countdown > 0
                ? Text("Please wait $_countdown seconds to access Command")
                : const SizedBox(),
            Expanded(
              child: ListView.builder(
                itemCount: relaylist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          relaylist[index]["commandName"],
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(relaylist[index]["initiatedOn"]),
                        trailing: Text(relaylist[index]["status"]),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
