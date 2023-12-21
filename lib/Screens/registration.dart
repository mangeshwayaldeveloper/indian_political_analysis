import 'package:bhart_political_reports/Screens/otp_verification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var verificationId = "";
  bool isVerificationCompleted = false;
  String code = "+91";

  // get verificationId => null;

  Future<void> signUpWithPhoneNumber(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval of verification code completed.
          // Sign the user in (or link) with the auto-retrieved credential.
          await _auth.signInWithCredential(credential);
          print("Auto-verification completed.");
          setState(() {
            isVerificationCompleted = true;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Invalid Phone Number Error:$e")));
          print("Phone number verification failed. Error: $e");
          // this.verificationId = verificationId;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => OtpVerification(
          //       verificationId: verificationId,
          //       auth: _auth,
          //     ),
          //   ),
          // );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Invalid Phone Number. Please enter a valid phone number.'),
            ),
          );
          print("Phone number verification failed. Error: $e");
        },
        codeSent: (String verificationId, int? resendToken) {
          // Save the verification ID for later use
          print("Code sent to $phoneNumber");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerification(
                verificationId: verificationId,
                auth: _auth,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timed out, handle the issue gracefully
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Auto-verification timed out. Please try again"),
            duration: Duration(seconds: 10),
          ));
          print("Verification timed out. Please try again.");
        },
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error while verifying phone number: $e'),
          duration: Duration(seconds: 3),
        ),
      );
      print("Error while verifying phone number: $e");
      return null;
    }
  }

  Future<void> storeUserNameInFirestore(String userName) async {
    final User user = _auth.currentUser!;
    final uid = user.uid;
    await _firestore.collection('users').doc(uid).set({
      'userName': userName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "IPA",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        fontFamily: 'ArchivoBlack'),
                  ),
                  Text("Indian Politician Analysis"),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Enter Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: "Enter Phone",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });

                          // Get values from the form
                          String enterPhone = phone.text.trim();
                          String enteredPassword = password.text.trim();
                          String enteredUsername = username.text.trim();
                          String phoneNumberWithCode = code + enterPhone;
                          try {
                            // Sign up the user with phone number
                            await signUpWithPhoneNumber(phoneNumberWithCode);

                            // Navigate to the OTP verification screen
                            if (verificationId != null) {
                              // Navigate to the OTP verification screen
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OtpVerification(
                                      verificationId: verificationId,
                                      auth: _auth),
                                ),
                              );
                            } else {
                              print(
                                  "Verification ID is null. OTP may not have been sent.");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('OTP have been sent.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Have an Account? Login",
                        style: TextStyle(color: Colors.green.shade900)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
