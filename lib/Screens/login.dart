import 'package:bhart_political_reports/Screens/Home/home.dart';
import 'package:bhart_political_reports/Screens/registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otp_verification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  static String verify = "";
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController countryCode = TextEditingController();
  var phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var verificationId = "";
  var phone = "";


  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

// Function to check if the mobile number exists in Firestore
  Future<bool> checkIfMobileNumberExists(String mobileNumber) async {
    try {
      final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

      print('Querying Firestore for mobile number: $mobileNumber');

      QuerySnapshot querySnapshot = await usersCollection
          .where('phone', isEqualTo: mobileNumber) // Use 'phone' here
          .get();

      print('Query result: ${querySnapshot.docs.isNotEmpty}');

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking mobile number: $e');
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              // Reduced vertical padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Center vertically
                crossAxisAlignment: CrossAxisAlignment.center,
                // Center horizontally
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Text(
                        "Login Using Mobile Number",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset("Assets/Images/image/loginpageimage.jpg"),
                    ],
                  ),
                  SizedBox(
                    height: 10, // Reduced spacing
                  ),
                  SizedBox(
                    height: 10, // Reduced spacing
                  ),
                  Container(
                    height: 55,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextFormField(
                            controller: countryCode,
                            decoration:
                            InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 40, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: phoneNumberController,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Mobile Number",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    width: MediaQuery
                        .of(context)
                        .size
                        .height / 4,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Construct the full mobile number
                        String Userphone = phoneNumberController.text;
                        String fullMobileNumber = countryCode.text + phone;

                        // Check if the mobile number exists in your database
                        bool isMobileNumberRegistered =
                        await checkIfMobileNumberExists(fullMobileNumber);

                        if (isMobileNumberRegistered) {
                          // The mobile number is registered, proceed with OTP verification
                          sendOtp();
                        } else {
                          // Display an error message that the mobile number is not registered
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mobile number is not registered.'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: Text("Get OTP"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      "Don't Have Account ? Register",
                      style: TextStyle(color: Colors.green.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> sendOtp() async {
    String fullMobileNumber=countryCode.text+phone;
    await auth.verifyPhoneNumber(
      phoneNumber: fullMobileNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print("The provided phone number is invalid");
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId = verificationId;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    OtpVerification(
                        verificationId: verificationId, auth: auth)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
