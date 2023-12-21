import 'package:bhart_political_reports/Screens/Widget/localGovernmentFomr.dart';
import 'package:bhart_political_reports/model/local_gov_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalGovernment extends ConsumerStatefulWidget {
  const LocalGovernment({super.key});

  @override
  ConsumerState<LocalGovernment> createState() => _LocalGovernmentState();
}

class _LocalGovernmentState extends ConsumerState<LocalGovernment> {
  TextEditingController name = TextEditingController();
  TextEditingController party = TextEditingController();
  TextEditingController location = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<LocalGovernmentAdd> localGovernmentList =
        ref.watch(localGovernmentProvider);
    return Scaffold(
        body: localGovernmentList.isEmpty
            ? SingleChildScrollView(
                child: localGovernmentAddForm(
                    formKey: _formKey,
                    name: name,
                    party: party,
                    location: location,
                    ref: ref),
              )
            : ListView.builder(
                itemCount: localGovernmentList.length,
                itemBuilder: (context, index) {
                  LocalGovernmentAdd localListData = localGovernmentList[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text("Name : ${localListData.name}"),
                        subtitle: Text("Party :${(localListData.party)}"),
                      ),
                    ],
                  );
                }));
  }
}
