class login {
  String? message;
  String? token;
  User? user;

  login({this.message, this.token, this.user});

  login.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? username;
  String? email;       // ⬅ WAJIB ADA
  String? role;
  int? roleId;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.role,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];           // ⬅ PARSING JSON DI SINI
    role = json['role'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;           // ⬅ MASUKIN KE TO JSON
    data['role'] = role;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
