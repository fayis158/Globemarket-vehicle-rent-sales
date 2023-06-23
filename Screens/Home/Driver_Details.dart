import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Api/api2.dart';

class Driver_Details extends StatefulWidget {
  Driver_Details({super.key, required this.vehiclenum, required this.vid});
  String vehiclenum;
  String vid;

  @override
  State<Driver_Details> createState() => _Driver_DetailsState();
}

class _Driver_DetailsState extends State<Driver_Details> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  TextEditingController vehiclenumberc = TextEditingController();
  TextEditingController drivernamec = TextEditingController();
  TextEditingController driverphonenumberc = TextEditingController();

  @override
  void initState() {
    super.initState();
    vehiclenumberc = TextEditingController(text: widget.vehiclenum);
    driverdetails();
  }

  List driverdet = [];
  driverdetails() async {
    driverdet = await Api2.driverdetails(widget.vid);

    drivernamec = TextEditingController(text: driverdet[0]["driverName"]);
    driverphonenumberc =
        TextEditingController(text: driverdet[0]["mobileNumber"]);
    setState(() {});
  }

  bool enabled = true;

  @override
  void dispose() {
    super.dispose();
    vehiclenumberc.dispose();
    drivernamec.dispose();
    driverphonenumberc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Globe GPS"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey1,
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: false,
                  controller: vehiclenumberc,
                  decoration: InputDecoration(
                    labelText: 'Vehicle Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the field';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: enabled,
                  controller: drivernamec,
                  decoration: InputDecoration(
                    labelText: 'Enter Driver Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the field';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: enabled,
                  controller: driverphonenumberc,
                  decoration: InputDecoration(
                    labelText: 'Enter Driver Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the field';
                    }
                    return null;
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey1.currentState!.validate()) {
                    Api2.Driverdetails(drivernamec.text, widget.vehiclenum,
                        driverphonenumberc.text);
                    enabled = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successful')),
                    );
                    driverdetails();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please Enter all required field')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(141, 1, 131, 8)),
                    child: const Center(
                        child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
