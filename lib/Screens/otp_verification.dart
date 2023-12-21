import 'dart:async';

import 'package:bhart_political_reports/Routes/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({
    Key? key,
    required this.verificationId,
    required this.auth,
  }) : super(key: key);
  final String verificationId;
  final FirebaseAuth auth;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  var otpController = TextEditingController();
  String otp = '';
  late StreamSubscription<String> otpStream;
  bool isLoading = false;
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
      await widget.auth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context,routes.homeRoute,(route)=>false);
      }
    } on FirebaseAuthException catch (e) {
      print("Error While Authenticaion: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verfication....",
          style: TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Enter OTP To Login",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Lottie.asset("Assets/animation/otp.json"),
                ),
                Pinput(
                  length: 6,
                  controller: otpController,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onChanged: (value){
                    setState(() {
                      otp=value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.height / 4,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (otp.isEmpty) {
                        // Display a warning if OTP is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter the OTP'),
                          ),
                        );
                      } else {
                        verify();
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text("Verify Mobile Number"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Edit Mobile Number",
                      style: TextStyle(color: Colors.black),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> verify() async {
    // Set isLoading to true when verification starts
    setState(() {
      isLoading = true;
    });

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }
}