// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:flutter/foundation.dart';

// part 'user.freezed.dart';

// part 'user.g.dart';

// @freezed
// class User with _$User {
//   const factory User({
//     required int id,
//     required String firstName,
//     required String lastName,
//     required String address,
//   }) = _User;

//   factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
// }

class User {
  String? access;
  String? refresh;
  UserInfo? user;

  User({this.access, this.refresh, this.user});

  User.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    user = json['user'] != null ? UserInfo.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  String? email;
  String? phone;
  String? name;

  UserInfo({this.id, this.email, this.phone, this.name});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['name'] = name;
    return data;
  }
}
