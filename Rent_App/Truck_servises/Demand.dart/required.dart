import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/supply_container_details.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Constant.dart';
import 'all_details.dart';
import '../Drawers/Drawers_for_rent.dart/Drawer_for_Rent.dart';



class Required_vehicle extends StatelessWidget {
  const Required_vehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>  All_Setails_demand(),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: width(context),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 4),
                    blurRadius: 2,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
                color: const Color.fromARGB(255, 233, 231, 231),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 1, bottom: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 21),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("Packers & Movers"),
                        
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Column(
                          children: const [
                            Icon(
                              FontAwesomeIcons.truck,
                              color: Color.fromARGB(255, 36, 6, 159),
                              size: 40,
                            ),
                              Text("Truck",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                        const Text(
                          "Required ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Column(
                          children: [
                             const Text(
                              "Manjunath s ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                             Row(
                               children: [
                                 MaterialButton(
                            color: Colors.green,
                            height: 30,minWidth: 60,
                            onPressed: () {
                                 launch("tel://$numberaccrelated");
                          },
                          child: const Text("Call",style: TextStyle(color: Colors.white),),
                          ),
                           SizedBox(
                          width: width(context) * 0.1,
                        ),
                        const Icon(
                          Icons.whatsapp,
                          color: Colors.green,
                        ),
                               ],
                             ),
                          ],
                        ),
                        SizedBox(width: width(context)*0.1,)
                      ],
                    ),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "18 Type    ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "35-38 Ton",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(" - "),
                        Container(
                            width: width(context) * 0.8,
                            child: const Text(
                              "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 175, 76, 149),
                                  fontSize: 12),
                            )),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "To     ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(" - "),
                        Container(
                            width: width(context) * 0.8,
                            child: const Text(
                              "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 76, 104, 175),
                                  fontSize: 12),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: const [
                            Text("Date :  ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(
                              "12/02/2022",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        ),
                       
                         SizedBox(
                          width: width(context) * 0.03,
                        ),
                        const Icon(
                          Icons.share,
                          color: Colors.green,
                        ),
                      ],
                    ),
                    Row(
                      children:  const [
                        SizedBox(width: 20,),
                          // MaterialButton(
                          //   color: Colors.green,
                          //   height: 30,minWidth: 60,
                          //   onPressed: () {
                          //    launch("tel://$numberaccrelated");
                          // },
                          // child: Text("Call",style: TextStyle(color: Colors.white),),
                          // ),
                        // Text("Time :  ",style: TextStyle(fontWeight: FontWeight.bold),),
                        // Text(
                        //   "05:50",
                        //   style: TextStyle(color: Colors.green),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
