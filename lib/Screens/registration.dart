import 'package:bhart_political_reports/Screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class Register extends StatefulWidget {
  const Register({Key? key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController countryCode = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  final RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  var phone = "";

  String? verificationId;
  bool manualOtpEntry = false;

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  Future<void> _registerUser() async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String phone = countryCode.text + phoneNumberController.text;
    final String password = passwordController.text;

    setState(() {
      _isLoading = true; // Show loading indicator
    });
    // Check if the phone number exists in Firestore
    bool isPhoneNumberExists = await checkIfPhoneNumberExists(phone);

    if (isPhoneNumberExists) {
      // Phone number already exists, show a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Phone number already exists.'),
          duration: Duration(seconds: 3),
        ),
      );
      setState(() {
        _isLoading = false; // Hide loading indicator in case of an error
      });
      return;
    }

    try {
      // Step 1: Create a user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
      });
      // Step 2: Store additional user information in Firestore
      await _storeUserData(userCredential.user!.uid, name, phone);
      nameController.clear();
      emailController.clear();
      phoneNumberController.clear();
      passwordController.clear();
      // Show a dialog indicating that registration is successful
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text(
              'You have successfully registered with email and password.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle registration errors
      setState(() {
        _isLoading = false; // Hide loading indicator in case of an error
      });
      print('Registration Error: $e');
      // You can display an error message to the user here
    }
  }

  Future<bool> checkIfPhoneNumberExists(String phoneNumber) async {
    try {
      final CollectionReference usersCollection =
          _firestore.collection('users');

      QuerySnapshot querySnapshot =
          await usersCollection.where('phone', isEqualTo: phoneNumber).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking phone number: $e');
      setState(() {
        _isLoading = false; // Hide loading indicator in case of an error
      });
      return false;
    }
  }

  Future<void> _storeUserData(String userId, String name, String phone) async {
    try {
      // Reference to the Firestore collection where user data is stored
      final CollectionReference usersCollection =
          _firestore.collection('users');

      // Create a document with the user's ID and store user information
      await usersCollection.doc(userId).set({
        'name': name,
        'phone': phone,
        // Add more fields as needed
      });
    } catch (e) {
      // Handle any errors here
      setState(() {
        _isLoading = false; // Hide loading indicator in case of an error
      });
      print('Error storing user data: $e');
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
            child: Center(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          "Login Using Mobile Number",
                          style: TextStyle(fontSize: 15),
                        ),
                        Image.asset(
                          "Assets/Images/image/fingerprinteditbg.png",
                        ),
                      ],
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
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              onChanged: (value) {
                                phone = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Full Name",
                                  prefixIcon: Icon(Icons.person)),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your name";
                                } else if (nameController.length > 50) {
                                  return "Too long name not allowed";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                      height: 20,
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
                          Expanded(
                            child: TextFormField(
                              controller: emailController,
                              onChanged: (value) {
                                phone = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter Email",
                                  prefixIcon: Icon(Icons.email)),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Email";
                                } else if (!emailValid.hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
                          Expanded(
                            child: TextFormField(
                              controller: passwordController,
                              onChanged: (value) {
                                phone = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.password)),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Password";
                                } else if (value.length < 6) {
                                  return "Password is too short";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                // Verify phone number
                                // Verify email
                                // Enable manual OTP entry and register user
                                _registerUser();
                              }
                            },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Visibility(
                            visible: !_isLoading,
                            // Show the CircularProgressIndicator when not loading
                            child: Text("Sign Up"),
                          ),
                          Visibility(
                            visible: _isLoading,
                            // Show the CircularProgressIndicator when loading
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Already Have Account? Login",
                        style: TextStyle(color: Colors.green.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
