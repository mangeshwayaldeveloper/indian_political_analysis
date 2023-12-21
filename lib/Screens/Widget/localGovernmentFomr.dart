import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/local_gov_add.dart';

class localGovernmentAddForm extends StatelessWidget {
  const localGovernmentAddForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.name,
    required this.party,
    required this.location,
    required this.ref,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController name;
  final TextEditingController party;
  final TextEditingController location;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 35,
          ),
          Text(
            "Local Government",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Image.asset("Assets/Images/image/localgovernment.png"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Add Your Local Government Name Below",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: "Name Of Person"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name Requried";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: party,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.group),
                        hintText: "Name of Political Party"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value Cannot Be Empty";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: location,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        hintText: "Name Of Your Area"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Value Cannot Be Empty";
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.red[900])),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final localFormData = LocalGovernmentAdd(
                          name: name.text,
                          party: party.text,
                          area: location.text);
                      ref.watch(localGovernmentProvider).add(localFormData);
                      ScaffoldMessenger(
                          child: SnackBar(
                            content: Text("Member Added"),
                            duration: Duration(seconds: 3),
                          ));
                      name.clear();
                      party.clear();
                      location.clear();
                    }
                  },
                  child: Text("Add Member")))
        ],
      ),
    );
  }
}