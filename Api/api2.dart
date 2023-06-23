import 'dart:convert';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/res/response.dart';
import 'package:http/http.dart' as http;

class Api2 {
  // API for RTO letter form
  //post
  static Future<Map> rtoletter(
      var vid,
      var engineNo,
      var chasisNo,
      var Permit,
      var rtoName,
      var rtoAddress,
      var make,
      var model,
      var manufactured,
      var registered,
      var lastFitnessDate) async {
    var res;
    var rto = await http.post(
      Uri.parse("http://globalgps.in:8089/api/v1/Vehicle/RTO_LetterForm"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<dynamic, dynamic>{
        "uid": finalUid,
        "vid": vid,
        "engineNo": engineNo,
        "chasisNo": chasisNo,
        "Permit": Permit,
        "rtoName": rtoName,
        "rtoAddress": rtoAddress,
        "make": make,
        "model": model,
        "manufactureDate": manufactured,
        "registrationDate": registered,
        "lastFitnessDate": lastFitnessDate
      }),
    );
    if (rto.statusCode == 200) {
      var rtoletter = jsonDecode(rto.body);

      res = rtoletter;

      return res;
    } else {
      return {};
    }
  }

//Get data

  static Future<List> getrtogetails(var vid) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Vehicle/RTOLetterView/$vid";
    List<dynamic> getrtogetails = [];

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      getrtogetails = reqres;
    }
    return getrtogetails;
  }

//API for  Driver details
//post
  static Future<List> Driverdetails(
      var name, var vehiclenum, var mobnumber) async {
    var res;
    var driverdetails = await http.post(
      Uri.parse(
          "http://globalgps.in:8089/api/v1/Driver/UpdateDriverDetails/$finalUid/$name/$vehiclenum/$mobnumber"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8'
      },
      // body: jsonEncode(<dynamic, dynamic>{
      //   "uid": finalUid,
      //   "vid": vid,
      //   "engineNo": engineNo,
      //   "chasisNo": chasisNo,
      //   "rtoName": rtoName,
      //   "rtoAddress": rtoAddress
      // }),
    );
    if (driverdetails.statusCode == 200) {
      var rtoletter = jsonDecode(driverdetails.body);

      res = rtoletter;
      return res;
    } else {
      return [];
    }
  }
  //getdata

  static Future<List> driverdetails(var vid) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Driver/GetDriverDetailsByUid/$finalUid/$vid";
    List<dynamic> getdriverdetails = [];

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      getdriverdetails = reqres;
    }
    return getdriverdetails;
  }

  // convert to pdf

  static Future converttopdf(var vid) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Vehicle/RtoCertificate/$finalUid/$vid";
    Map convertedfile = {};

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

   

    if (reqres != "Error occured failed") {
      convertedfile = reqres;
     
    }
    return convertedfile;
  }

//download the pdf which is releated to payment data
// http://globalgps.in:8089/api/v1/Vehicle/PaymentRecepit/716

  static Future converttopdfpayment(var paymentid) async {
    // ignore: non_constant_identifier_names
    String ApiUrl =
        "http://globalgps.in:8089/api/v1/Vehicle/PaymentRecepit/$paymentid";
    var convertedfilepayment = {};

    var reqres = await RequestAssistant.receiverRequest(ApiUrl);

    if (reqres != "Error occured failed") {
      convertedfilepayment = reqres;
    }
    return convertedfilepayment;
  }
}
