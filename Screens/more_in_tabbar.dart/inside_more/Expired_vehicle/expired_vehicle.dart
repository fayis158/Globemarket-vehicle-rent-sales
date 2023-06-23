import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';


class Expired_vehicle extends StatelessWidget {
  @override

  // const Expired_vehicle({super.key});
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:expiredvehicledata.isEmpty?const Center(child: Text("No Expired Vehicle",style: TextStyle(fontWeight: FontWeight.bold),),): ListView.builder(
      itemCount: expiredvehicledata.length,
      itemBuilder: (context, index) {
        return expiredvehicledata.isEmpty?Container(): Expired_vehcle(
          Name: expiredvehicledata[index]["userName"],
          Vehicle: expiredvehicledata[index]["vehicle"],
          Vehiclenum: expiredvehicledata[index]["vehicleNo"],
          amount: expiredvehicledata[index]["duePayment"],
          Expirydate: expiredvehicledata[index]["expiryDate"],
          
          installeddate: expiredvehicledata[index]["installedDate"],
         
        );
      },
    ));
  }
}

class Expired_vehcle extends StatelessWidget {
  Expired_vehcle(
      {super.key,
      required this.Name,
      required this.Vehiclenum,
      required this.Vehicle,
      required this.amount,
      required this.installeddate,
      required this.Expirydate,

  
      
      });
  String Name;
  String Vehiclenum;
  String Vehicle;
  String amount;
  String installeddate;
  String Expirydate;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.18,
      width: double.infinity,
      // color: Color.fromARGB(255, 219, 219, 219),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                // color: Color.fromARGB(255, 226, 221, 221),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        Name,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(Vehiclenum),
                      Text(Vehicle),
                      Row(
                        children: [
                          Text("installeddate".tr()),
                          Text(" : $installeddate "),
                        ],
                      ),
                      Row(
                        children: [
                          Text("expirydate".tr()),
                          Text(" : $Expirydate "),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              child: Container(
            // color: Color.fromARGB(255, 209, 211, 212),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "RS : $amount",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Expired",
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
