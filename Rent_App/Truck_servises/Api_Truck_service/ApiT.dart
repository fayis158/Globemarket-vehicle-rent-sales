import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/gps_payment_api/api_payment.dart';
import 'package:http/http.dart' as http;

import '../Rent_Home_Page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// var vehdaaaaata;

class ApiT extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchData(1);


  }

  Rx<Map<String, dynamic>> addvehiclesupplyres = Rx<Map<String, dynamic>>({});

  Future<void> addvehiclesupply(
    var vehicletype,
    var fromaddreess,
    var toaddress,
    var typeofvehicle,
    var rate,
    var freekm,
    var freehr,
    var transportname,
    var customerName,
    var mobile,
    var vehicledetails,
    var vehiclenumber,
    var date,
    var supplyid,
    var vehiclemodel,
    var aadharcard,
    var pancard,
    var rcbook,
    var permit,
    var insurance,
    var vehfrontphoto,
    var vehbackphoto,
    var aadharpath,
    var pancardpath,
    var rcbookpath,
    var permitpath,
    var insurancepath,
    var vehfrontpath,
    var vehbackpath,
  ) async {
    var url =
        'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleCreate';

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_token',
      };

      var body = json.encode({
        "vehicleType": vehicletype,
        "fromAddress": fromaddreess,
        "toAddress": toaddress,
        "typeOfVehicle": typeofvehicle,
        "rate": rate,
        "freeKm": freekm,
        "freeHr": freehr,
        "transportName": transportname,
        "customerName": customerName,
        "mobile": mobile,
        "vehicleDetails": vehicledetails,
        "vehicleNo": vehiclenumber,
        "date": date,
        "status": 1,
        "uId": supplyid,
        "vehicleModel": vehiclemodel,
        "aadharCard": aadharcard,
        "panCard": pancard,
        "rcBook": rcbook,
        "permit": permit,
        "insurance": insurance,
        "vehiclePhoto_Front": vehfrontphoto,
        "vehiclePhoto_Back": vehbackphoto,
        "aadharFileName": aadharpath,
        "panFileName": pancardpath,
        "rcBookFileName": rcbookpath,
        "permitFileName": permitpath,
        "insuranceFileName": insurancepath,
        "frontVehPhotoFileName": vehfrontpath,
        "backVehPhotoFileName": vehbackpath
      });

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        var decodedData = json.decode(response.body);
        addvehiclesupplyres.value = decodedData;
        Get.snackbar(
            backgroundColor: Colors.black,
            titleText: const Text(
              "Succesfully Completed",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
            "",
            "");
      } else {
        addvehiclesupplyres.value = {'error': 'Error: ${response.statusCode}'};
        Get.snackbar("Failed", "Error Occured");
      }
    } catch (error) {
      addvehiclesupplyres.value = {'error': 'Error: $error'};
      Get.snackbar("Failed", "Error Occured");
    }
  }

  //get data supply

  // final vehicles = [].obs; // Observable list to hold the vehicles

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchData(); // Call the API when the controller is initialized
  // }

  // Future<void> fetchData() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleList'));
  //     if (response.statusCode == 200) {

  //       final jsonList = json.decode(response.body) as List<dynamic>;

  //       vehicles.value = jsonList;
  //       // Update the value of the observable list with the API response

  //     } else {
  //       // Handle API error
  //       print("myerror");
  //     }
  //   } catch (e) {
  //     print("habdle");
  //     // Handle exception/error
  //   }
  // }

  final vehicles = <dynamic>[].obs;

  Future<void> fetchData(var typeoftransport) async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleList/$typeoftransport'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        if (jsonResponse.isNotEmpty) {
          final detailsList = jsonResponse[0]['details'] as List<dynamic>;
          vehicles.value = detailsList;
          // vehdaaaaata = detailsList;
        }
      } else {}
    } catch (e) {
      vehicles.value = [];
    }
  }

  final sharecontents = <dynamic>[].obs;

  Future<void> sharecontentfn(var supplyid) async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleView/$supplyid'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;

        if (jsonResponse.isNotEmpty) {
          final sharelist = jsonResponse;

          sharecontents.value = sharelist;
        }
      } else {
        // Handle API error
        debugPrint("myerror");
      }
    } catch (e) {
      debugPrint("$e");
      // sharecontents.value = [];
      Get.snackbar("Failed", "Please contact us for further information");
    }
  }

  // Api Login otp

  Future<void> Otpmobilenumlogin(var mobilenumber, var name) async {
    var url = 'http://globalgps.in:8089/api/Account/SendOTP';

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_token',
      };

      var body = json.encode({"mobile": "$mobilenumber", "name": "$name"});

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        Get.snackbar("Succesfully Completed", "");
      } else {
        Get.snackbar("Failed", "Error Occured");
      }
    } catch (error) {
      Get.snackbar("$error", "Error Occured2");
    }
  }

  Future<void> verifyotp(var otp, var mobilenumber) async {
    var url = 'http://globalgps.in:8089/api/Account/VerifyOTP';

    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_token',
      };

      var body = json.encode({"mobile": mobilenumber, "otp": otp});

      var response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var apiResponse = responseData['result']['response'];

        if (apiResponse == "OTP Verified") {
          Get.to(() => Truck_services());
          Get.snackbar(
            "Successfully Logged in",
            "Welcome To Globe Market",
            messageText: const Text(
              "Welcome To Globe Market",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            titleText: const Text(
              "Successfully Logged in",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundGradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 89, 5, 67),
                Color.fromARGB(255, 36, 115, 194),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          );
          Get.snackbar(
            "",
            "",
            backgroundColor: Colors.black,
            messageText: const Text(
              "Succesfully Completed Mobile Number Verification",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          );
        } else {
          Get.snackbar(
            // snackPosition: SnackPosition.values[1],
            "",
            "",
            backgroundColor: Colors.black,
            titleText: const Text(
              "Invalid OTP",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
            messageText: const Text(
              "Please Enter Valid OTP",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          );
        }
      } else {
        Get.snackbar(
          // snackPosition: SnackPosition.values[1],
          "",
          "",
          backgroundColor: Colors.black,
          titleText: const Text(
            "Failed  Mobile Number Verification",
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold),
          ),
          messageText: const Text(
            "Enter Valid OTP",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        );
      }
    } catch (error) {
      Get.snackbar("$error", "Error Occured28");
    }
  }

  // main page Get api

  late final mainuserdata = <dynamic>[].obs;

  Future<void> MainPagedata() async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/User/UserDetailsByMobile/$rentmobilenum'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;

        if (jsonResponse.isNotEmpty) {
          final sharelist = jsonResponse;

          mainuserdata.value = sharelist;

          rentuid = mainuserdata[0]["uid"];
          expiredate = mainuserdata[0]["expiryDate"];
          typeofuser = mainuserdata[0]["userVerify"];

          SharedPreferences.getInstance().then((prefs) {
            prefs.setInt('rentuid', rentuid);
          });
          SharedPreferences.getInstance().then((prefs) {
            prefs.setString('expiredate', expiredate);
          });
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('typeofuser', typeofuser);
          });

          SharedPreferences prefs = await SharedPreferences.getInstance();
          rentuid = prefs.getInt("rentuid")!;
          typeofuser = prefs.getBool("typeofuser")!;
          expiredate = prefs.getString("expiredate")!;
        }
      } else {
        mainuserdata.value = [
          {
            "uid": 0,
            "mobile": "",
            "verified": false,
            "date": "",
            "name": "",
            "companyName": "",
            "emailId": "",
            "whatsApp": "",
            "path": ""
          }
        ];
      }
    } catch (e) {
      // sharecontents.value = [];
      mainuserdata.value = [
        {
          "uid": 0,
          "mobile": "",
          "verified": false,
          "date": "",
          "name": "",
          "companyName": "",
          "emailId": "",
          "whatsApp": "",
          "path": ""
        }
      ];
      Get.snackbar("Failed", "Please contact us for further information");
    }
  }

//profile page

  Future<void> postprofiledata(
      var Uidrent,
      var name,
      var companyName,
      var emailId,
      var whatsappnum,
      var address,
      var filename,
      var base64,
      var termsandcondition) async {
    final url = 'http://globalgps.in:8089/api/User/ProfileDetails';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body = json.encode({
      "uid": Uidrent,
      "name": name,
      "companyName": companyName,
      "emailId": emailId,
      "whatsApp": whatsappnum,
      "address": address,
      "fileName": filename,
      "base64string": base64,
      "termsCondition": termsandcondition
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }

  //Posted bookings

  final postedbookings = <dynamic>[].obs;

  Future<void> postedbooking() async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleListWithUId/$rentuid'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        if (jsonResponse.isNotEmpty) {
          final detailsList = jsonResponse[0]['details'] as List<dynamic>;
          postedbookings.value = detailsList;
        }
      } else {
        // Handle API error

      }
    } catch (e) {
      postedbookings.value = [];
      // Handle exception/error
    }
  }

  //cancel the booking

  Future<void> cancelbookings(var supplyid, var status) async {
    const url =
        'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleStatus';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body = json.encode({"supplyId": supplyid, "status": status});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }
  //accept the trip

  Future<void> acceptedthetrip(
    var supplyid,
    var date,
    var uid,
  ) async {
    const url = 'http://globalgps.in:8089/api/v1/SupplyVehicle/Accept';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body = json.encode({
      "supplyId": supplyid,
      "date": date,
      "status": 3,
      "uId": rentuid,
      "ownerId": uid,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }

  //received Bookings

  final receivedbookings = <dynamic>[].obs;

  Future<void> receivedbooking() async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleReceivedBookingListWIthUser/$rentuid'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        if (jsonResponse.isNotEmpty) {
          final detailsList = jsonResponse[0]['details'] as List<dynamic>;
          receivedbookings.value = detailsList;
        }
      } else {}
    } catch (e) {
      receivedbookings.value = [];
    }
  }

// count api for touching user
//post
  Future<void> counttouchbyuser(var count) async {
    const url = 'http://globalgps.in:8089/api/v1/SupplyVehicle/ViewsCount';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body = json.encode({"uId": rentuid, "viewsCount": count});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }
  //get

  final RxInt getcountuser = RxInt(0);
  final RxInt gettotalcountuser = RxInt(0);

  Future<void> getUserTouchCount() async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/LimitCount/$rentuid'));
      print("getu va ${response.statusCode} ");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final count = jsonResponse['limitCount'];
        getcountuser.value = count;

        final count2 = jsonResponse['touchCount'];
        gettotalcountuser.value = count2;
      } else {}
    } catch (e) {
      // postedbookings.value = [];
    }
  }

// PaymentAPIs for subscription

  Future<void> paymentApi(var amount, var paymentid, var days) async {
    const url = 'http://globalgps.in:8089/api/v1/GlobeMarket/OnlinePayment';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body = json.encode({
      "uid": rentuid,
      "totalAmount": amount,
      "paymentID": paymentid,
      "days": days
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }

  //get tranaction history

  final paymenthistory = <dynamic>[].obs;

  Future<void> getpaymenthistory() async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/GlobeMarket/PaymentDeatilsByUID/$rentuid'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        if (jsonResponse.isNotEmpty) {
          final detailsList = jsonResponse as List<dynamic>;
          paymenthistory.value = detailsList;
        }
      } else {}
    } catch (e) {
      paymenthistory.value = [];
    }
  }

// convert to pdf

  final convertion = <dynamic>[].obs;

  Future<void> convertrentpaymentbill(var paymentid) async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/GlobeMarket/PaymentRecepit/$paymentid'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;

        if (jsonResponse.isNotEmpty) {
          final detailsList = jsonResponse as List<dynamic>;
          convertion.value = detailsList;
        }
      } else {}
    } catch (e) {
      convertion.value = [];
    }
  }
//check vehicle excist or not

  RxBool checkvehexcist = false.obs;
  Future<void> checkexcistingveh(var vehiclenumber) async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/VehicleExists/$vehiclenumber'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        checkvehexcist.value = jsonResponse["vehExists"];
      } else {}
    } catch (e) {}
  }

  //update edit part

  // http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleEdit

  Future<void> upodateedit(var supplyid, var fromaddress, var toaddress,
      var rate, var freekm, var freehr, var date) async {
    const url =
        'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleEdit';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body = json.encode({
      "supplyId": supplyid,
      "fromAddress": fromaddress,
      "toAddress": toaddress,
      "rate": rate,
      "freeKm": freekm,
      "freeHr": freehr,
      "date": date,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }

  //accepted bookings (me which and all vehicle accepted)

  final acceptedbookings = <dynamic>[].obs;

  Future<void> acceptedbooking() async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/SupplyVehicleAcceptBookingListWIthUser/$rentuid'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as List<dynamic>;
        if (jsonResponse.isNotEmpty) {
          final detailsList = jsonResponse[0]['details'] as List<dynamic>;
          acceptedbookings.value = detailsList;
        }
      } else {}
    } catch (e) {
      acceptedbookings.value = [];
    }
  }

//payment rate list

// http://globalgps.in:8089/api/User/MasterPriceList

  RxInt days30 = 0.obs;
  RxInt days90 = 0.obs;
  RxInt days180 = 0.obs;
  RxInt days365 = 0.obs;

  Future<void> pricelist() async {
    try {
      final response = await http
          .get(Uri.parse('http://globalgps.in:8089/api/User/MasterPriceList'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final detailsList = jsonResponse;
        days30.value = detailsList["days30"];
        days90.value = detailsList["days90"];
        days180.value = detailsList["days180"];
        days365.value = detailsList["days365"];
      } else {}
    } catch (e) {}
  }


  //accepte api


  // http://globalgps.in:8089/api/v1/SupplyVehicle/UserAcceptExists/uid/1

// fin al acceptapi = <dynamic>[].obs;
RxBool acceptapi=false.obs;
  Future<void> acceptapiforbutton(var supplyid) async {
    try {
      final response = await http.get(Uri.parse(
          'http://globalgps.in:8089/api/v1/SupplyVehicle/UserAcceptExists/$rentuid/$supplyid'));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
      
          final accept = jsonResponse;
          acceptapi.value = accept["acceptExists"];
        
      } else {}
    } catch (e) {
      // acceptedbookings.value = [];
    }
  }
}

// different class
//number taking api for rent
class Rentingps {
  static Future<void> gpstorentnumberinsert(
    var mobilenum,
  ) async {
    const url = 'http://globalgps.in:8089/api/Account/InsertGPSUserMobileNo';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token',
    };

    final body =
        json.encode({"mobile": "$mobilenum", "name": "$finalUserName"});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
      } else {}
    } catch (e) {
      Get.snackbar("$e", "");
    }
  }
}
