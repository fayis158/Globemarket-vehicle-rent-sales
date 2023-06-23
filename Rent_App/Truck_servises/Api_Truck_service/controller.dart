import 'package:get/get.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/ApiT.dart';

class ApiController extends GetxController {
  final ApiT apiController = Get.find<ApiT>();

  Future<void> callpostaddvehicleSupply(
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
     var  vehfrontphoto,
     var vehbackphoto,
     var aadharpath,
     var pancardpath,
     var rcbookpath,
     var permitpath,
     var insurancepath,
     var vehfrontpath,
     var vehbackpath,
      ) async {
    await apiController.addvehiclesupply(
        vehicletype,
        fromaddreess,
        toaddress,
        typeofvehicle,
        rate,
        freekm,
        freehr,
        transportname,
        customerName,
        mobile,
        vehicledetails,
        vehiclenumber,
        date,
        supplyid,
         vehiclemodel,
       aadharcard,
       pancard,
       rcbook,
       permit,
       insurance,
       vehfrontphoto,
      vehbackphoto,
      aadharpath,
      pancardpath,
      rcbookpath,
      permitpath,
      insurancepath,
      vehfrontpath,
      vehbackpath,
        );
  }

  Future<void> callloginotp(var loginotp, var name) async {
    await apiController.Otpmobilenumlogin(loginotp, name);
  }

  Future<void> otpverify(var otpverify, var mobilenum) async {
    await apiController.verifyotp(otpverify, mobilenum);
  }

  //main user api(profilke)
  Future<void> mainpageapi() async {
    await apiController.MainPagedata();
  }

  // post api for profile

  Future<void> profilepost(var Uidrent, var name, var companyName, var emailId,
      var whatsappnum, var address, var filename , var base64, var termsandcondition) async {
    await apiController.postprofiledata(
        Uidrent, name, companyName, emailId, whatsappnum, address,filename,base64,termsandcondition);
  }

//cancel api

  Future<void> cancelrentbooking(
    var supplyid,
    var status
  ) async {
    await apiController.cancelbookings(
      supplyid,
      status
    );
  }
  //accept the trip post api call

  Future<void> accepttrip(
    var supplyid,
    var date,
    var uid,
  ) async {
    await apiController.acceptedthetrip(supplyid, date, uid);
  }

  //payment api

  Future<void> paymentapirent(var amount, var paymentid, var days) async {
    await apiController.paymentApi(amount, paymentid, days);
  }


}
