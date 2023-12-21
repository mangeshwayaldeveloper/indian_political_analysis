import 'package:bhart_political_reports/Screens/registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'otp_verification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  static String verify = "";
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController countryCode = TextEditingController();
  var phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var verificationId = "";
  var phone = "";
  bool simCardNumbersRequested = false;
  final _pinFocusNode = FocusNode();
  late String mobileNumber;
  bool isLoading = false;
  bool isSmsAutoFillEnabled = true;

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  void _listenForSms() async {
    if (!simCardNumbersRequested) {
      simCardNumbersRequested = true; // Set the flag to true to prevent further requests

      try {
        final autoFill = SmsAutoFill();
        final mobileNumber = await autoFill.hint;
        if (mobileNumber != null && mobileNumber.isNotEmpty) {
          if (mobileNumber != 'none') {
            // Auto-fill phone number if not "none"
            final numberWithoutCountryCode = mobileNumber.replaceFirst('+91', '');
            phoneNumberController.text = numberWithoutCountryCode;
            setState(() {
              phone=numberWithoutCountryCode;
            });
          } else {
            // Enable phone number text field if "none" is selected
            isSmsAutoFillEnabled = !isSmsAutoFillEnabled;
          }
        }
      } catch (e) {
        print('Error listening for SMS: $e');
      }
    }
  }
// Function to check if the mobile number exists in Firestore
  Future<bool> checkIfMobileNumberExists(mobileNumber) async {
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
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "IPA",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 50,fontFamily: 'ArchivoBlack'),
                              ),
                              Text("Indian Politician Analysis")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 200, // Reduced spacing
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Image.asset("Assets/Images/image/india.png",height: 35,),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: 30,
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
                              onTap: (){
                                setState(() {
                                  _listenForSms();
                                });
                              },
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Phone Number";
                                } else if (value.length < 10 ||
                                    value.length > 10) {
                                  return "Enter a valid mobile number";
                                }
                                return null;
                              },
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
                      width: MediaQuery.of(context).size.height / 4,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Construct the full mobile number
                          String Userphone = phoneNumberController.text;
                          String fullMobileNumber = countryCode.text + phone;

                          // Check if the mobile number exists in your database
                          bool isMobileNumberRegistered =
                          await checkIfMobileNumberExists(fullMobileNumber);
                          if (_formKey.currentState!.validate()) {
                            if (isMobileNumberRegistered) {
                              // The mobile number is registered, proceed with OTP verification
                              sendOtp();
                            } else {
                              // Display an error message that the mobile number is not registered
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text('Mobile number is not registered.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
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
                    SizedBox(height: MediaQuery.of(context).size.height/6,),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUp()));
                      },
                      child: Text(
                        "Don't Have Account ? Register",
                        style: TextStyle(color: Colors.green.shade900),
                      ),
                    ),
                    if (isLoading) CircularProgressIndicator(color: Colors.black,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> sendOtp() async {
    setState(() {
      isLoading = true; // Show loading indicator when sending OTP
    });

    List<String> errors = [];

    String fullMobileNumber = countryCode.text + phone;

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: fullMobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          errors.add(e.message ?? "Verification failed");
          setState(() {
            isLoading = false; // Set isLoading to false when verification fails
          });
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Do not set isLoading here, as OTP is sent successfully
          this.verificationId = verificationId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerification(
                verificationId: verificationId,
                auth: auth,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            isLoading = false; // Set isLoading to false when auto-retrieval times out
          });
        },
      );
    } catch (e) {
      if (e.toString().contains("blocked all requests from this device due to unusual activity")) {
        errors.add("We have blocked all requests from this device due to unusual activity. Try again later.");
      } else if (e.toString().contains("unknown status code: 17010")) {
        errors.add("SMS verification code request failed. Please check your phone number and try again.");
      } else {
        errors.add("An error occurred: $e");
      }
      setState(() {
        isLoading = false; // Set isLoading to false when an error occurs
      });
    }

    // Check if there are errors to show
    if (errors.isNotEmpty) {
      // Display errors in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: errors.map((error) {
              return Text(error);
            }).toList(),
          ),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  // Function to build the button child text based on loading state
  Widget buildButtonChild() {
    if (isLoading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Text("Get OTP");
    }
  }
}