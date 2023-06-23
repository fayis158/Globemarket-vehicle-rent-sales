import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/global/global.dart';



bool functionobscureText = true;
bool functionobscureText2 = true;
bool functionobscureText3 = true;

class Changepasswordpage extends StatefulWidget {
  // const Changepasswordpage({super.key});


  @override
  State<Changepasswordpage> createState() => _ChangepasswordpageState();
}

class _ChangepasswordpageState extends State<Changepasswordpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionobscureText = true;
    functionobscureText2 = true;
    functionobscureText3 = true;
  }

  TextEditingController Currentpasswordcontroller = TextEditingController();
  TextEditingController _Newpasswordcontroller = TextEditingController();
  TextEditingController _Confirmpasswordcontroller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');

  @override
  void dispose() {
    super.dispose();
    Currentpasswordcontroller.dispose();
    _Newpasswordcontroller.dispose();
    _Confirmpasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
        title: Text("changepassword".tr(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Form(
        key: _form,
        child: Column(
          children: [
            marquee(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: Currentpasswordcontroller,
                obscureText: functionobscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        functionobscureText = !functionobscureText;
                      });
                    },
                    icon: functionobscureText
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  ),
                  labelText: 'Current Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) return 'Please Enter the field';
                  if (val.length < 4) return 'Must Need 4 or more characters';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _Newpasswordcontroller,
                validator: (val) {
                  if (val!.isEmpty) return 'Please Enter the field';
                  if (val.length < 4) return 'Must Need 4 or more characters';
                  if (val != _Newpasswordcontroller.text) return 'Not Match';
                  return null;
                },
                // controller: Currentpasswordcontroller,
                obscureText: functionobscureText2,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        functionobscureText2 = !functionobscureText2;
                      });
                    },
                    icon: functionobscureText2
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  ),
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _Confirmpasswordcontroller,
                validator: (val) {
                  if (val!.isEmpty) return 'Please Enter the field';
                  if (val.length < 4) {
                    return 'Must Need 4 or more characters';
                  }
                  if (val != _Newpasswordcontroller.text) return 'Not Match';
                  // if (!regex.hasMatch(val))
                  //   return 'Please Enter a valid Password';

                  return null;
                },
                obscureText: functionobscureText3,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        functionobscureText3 = !functionobscureText3;
                      });
                    },
                    icon: functionobscureText2
                        ? const Icon(
                            Icons.visibility,
                          )
                        : const Icon(
                            Icons.visibility_off,
                          ),
                  ),
                  labelText: 'Confirm  Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  //post api

                  // var myresponse = await changepassword;

                  if (_form.currentState!.validate()) {
                    var changepass = await Api.postchangepass(
                        finalUid,
                        Currentpasswordcontroller.text,
                        _Newpasswordcontroller.text,
                        _Confirmpasswordcontroller.text);
                   
                    if(changepass=="Update Successfully.."){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Updated succesfuly')),
                    );
                    }else{
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('password is wrong')),
                    );
                    } 
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please Enter all required field')),
                    );
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color.fromARGB(255, 13, 122, 31)),
                  child: const Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Floatingaction_button(),
    );
  }
}
