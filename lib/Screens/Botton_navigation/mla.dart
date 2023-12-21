import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

final selectedMLAProvider = StateProvider<String?>((ref) => null);

class MLA extends ConsumerStatefulWidget {
  const MLA({Key? key}) : super(key: key);

  @override
  ConsumerState<MLA> createState() => _MLAState();
}

class _MLAState extends ConsumerState<MLA> {
  List<String> mlaList = ["MLA1", "MLA2", "MLA3"];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "MLA",
              style: TextStyle(fontSize: 18),
            ),
            SelectMLA(ref: ref, mlaList: mlaList),
            SelectedMLAInfo(),
          ],
        ),
      ),
    );
  }
}

class SelectMLA extends StatelessWidget {
  const SelectMLA({
    super.key,
    required this.ref,
    required this.mlaList,
  });

  final WidgetRef ref;
  final List<String> mlaList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                prefixIcon: Icon(
                  LineAwesomeIcons.list,
                  color: Colors.orange,
                ),
                hintText: "--Select--",
                fillColor: Colors.orange[50],
              ),
              value: ref.read(selectedMLAProvider.notifier).state,
              onChanged: (newValue) {
                ref.read(selectedMLAProvider.notifier).state = newValue as String?;
              },
              items: mlaList.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final selectedMLA = ref.watch(selectedMLAProvider.notifier).state;
            if (selectedMLA != null) {
              // Show Snackbar with selected MLA name
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 5),
                  content: Text("Selected MLA: $selectedMLA"),
                ),
              );
            } else {
              // Show an alert or handle the case when no MLA is selected
            }
          },
          child: Text("Select"),
        ),
      ],
    );

  }
}

class SelectedMLAInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMLA = ref.watch(selectedMLAProvider);

    return Text(
      "Your MLA Is: ${selectedMLA ?? 'None'}",
      style: TextStyle(fontSize: 18),
    );
  }
}
