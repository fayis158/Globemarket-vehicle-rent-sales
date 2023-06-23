import 'dart:convert';
import 'package:gpsglobe/global/global.dart';
import 'package:http/http.dart' as http;
import '../res/response.dart';

class PaymentApi {
  static Future<List>? getDuePaymentDetails() async {
    List finalList = [];
    DateTime now = DateTime.now();
    String formattedDate = now.toString().substring(0, 10);
    String url =
        "http://globalgps.in:8089/api/v1/Vehicle/ExpiredVehicles/$finalUid/$formattedDate";
    final reqres = await RequestAssistant.receiverRequest(url);

    if (reqres != "Error occured failed") {
      finalList = reqres;

      return finalList;
    }
    return finalList;
  }

  static Future<dynamic>? postpayment(
    String vehs,
    String amount,
    String paymentId,
  ) async {
   
    Map result = {};
    var res = await http.post(
      Uri.parse("http://globalgps.in:8089/api/v1/Vehicles/OnlinePayment"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<dynamic, dynamic>{
        "vehs": vehs,
        "totalAmount": amount.toString(),
        "paymentID": paymentId
      }),
    );
   

    if (res.statusCode == 200) {
      var paymentdone = jsonDecode(res.body);

      result = paymentdone;
      

      return result;
    } else {
      return {};
    }
  }

  // static Future<dynamic>? orderid(String vehs, String amount) async {
  //   Map result1 = {};
  //   var res = await http.post(
  //     Uri.parse("http://www.globalgps.in:8089/api/v1/Vehicles/OrderCreation"),
  //     headers: <String, String>{
  //       'Content-type': 'application/json; charset=UTF-8'
  //     },
  //     body: jsonEncode(<dynamic, dynamic>{"vehs": vehs, "totalAmount": amount}),
  //   );
  //   if (res.statusCode == 200) {
  //     var paymentdone = jsonDecode(res.body);

  //     result1 = paymentdone;

  //     return result1;
  //   } else {
  //     return {};
  //   }
  // }

  //the last one is already callling in ui itself

}
