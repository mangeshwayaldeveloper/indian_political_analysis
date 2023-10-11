class UserModel {
  final String? id;
  final String email;
  final String phone;

  UserModel({required this.id, required this.email, required this.phone});

  toJson() {
    return {"email": email, "phone": phone};
  }
}
