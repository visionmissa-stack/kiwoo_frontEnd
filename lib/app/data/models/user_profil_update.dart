// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/utils/enums.dart';

class UserProfilUpdate {
  String? name;
  String? avatar;
  String? phone;
  String? password;
  String? oldPassword;
  Map<IdentityType, String>? idDoc;
  UserProfilUpdate({
    this.name,
    this.avatar,
    this.phone,
    this.password,
    this.oldPassword,
    this.idDoc,
  });

  UserProfilUpdate copyWith({
    String? name,
    String? avatar,
    String? phone,
    String? password,
    String? oldPassword,
    Map<IdentityType, String>? idDoc,
  }) {
    return UserProfilUpdate(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      oldPassword: oldPassword ?? this.oldPassword,
      idDoc: idDoc ?? this.idDoc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'avatar': avatar,
      'phone': phone,
      'password': password,
      'old_password': oldPassword,
      'id_doc': idDoc?.map((key, value) => MapEntry(key.name, value))
    };
  }

  factory UserProfilUpdate.fromMap(Map<String, dynamic> map) {
    return UserProfilUpdate(
      name: map['name'] != null ? map['name'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      oldPassword:
          map['old_password'] != null ? map['old_password'] as String : null,
      idDoc: map['id_doc'] != null
          ? Map<IdentityType, String>.from({
              IdentityType.front: map['id_doc'][IdentityType.front.name],
              IdentityType.back: map['id_doc'][IdentityType.back.name],
              IdentityType.face: map['id_doc'][IdentityType.face.name],
            })
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfilUpdate.fromJson(String source) =>
      UserProfilUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfilUpdate(name: $name, avatar: $avatar, phone: $phone, password: $password, oldPassword: $oldPassword, idDoc: $idDoc)';
  }

  @override
  bool operator ==(covariant UserProfilUpdate other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.avatar == avatar &&
        other.phone == phone &&
        other.password == password &&
        other.oldPassword == oldPassword &&
        mapEquals(other.idDoc, idDoc);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        avatar.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        oldPassword.hashCode ^
        idDoc.hashCode;
  }
}
