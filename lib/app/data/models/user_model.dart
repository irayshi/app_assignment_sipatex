class User {
  int? id;
  String? email;
  String? password;
  String? role;
  String? displayName;

  User({this.id, this.email, this.password, this.role, this.displayName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['displayName'] = displayName;
    return data;
  }
}
