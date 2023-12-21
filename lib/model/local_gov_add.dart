import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalGovernmentAdd {
  String name;
  String party;
  String area;

  LocalGovernmentAdd(
      {required this.name, required this.party, required this.area});

  factory LocalGovernmentAdd.fromJson(Map<String, dynamic> json) {
    return LocalGovernmentAdd(
        name: json['name'], party: json['party'], area: json['area']);
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'party':party,
      'area':area
    };
    return data;
  }
}

final localGovernmentProvider=StateProvider<List<LocalGovernmentAdd>>((ref) {
  return [];
});