// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class ForgotPasswordResponseModel extends RegisterModel {
  ForgotPasswordResponseModel({super.email, super.message});

  factory ForgotPasswordResponseModel.fromMap(json) {
    var registerModel = RegisterModel.fromMap(json);
    return ForgotPasswordResponseModel(
      email: registerModel.email,
      message: registerModel.message,
    );
  }

  @override
  String toString() => super
      .toString()
      .replaceFirst("RegisterModel", "ForgotPasswordResponseModel");
}

class RegisterModel {
  String? email;
  String? message;

  RegisterModel({
    this.email,
    this.message,
  });

  RegisterModel copyWith({
    String? email,
    String? message,
  }) {
    return RegisterModel(
      email: email ?? this.email,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'message': message,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      email: map['email'] != null ? map['email'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegisterModel(email: $email, message: $message)';

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.message == message;
  }

  @override
  int get hashCode => email.hashCode ^ message.hashCode;
}

class OTPModel extends RegisterModel {
  OTPModel({super.email, super.message, this.otpValidity});

  double? otpValidity;

  @override
  OTPModel copyWith({
    String? email,
    String? message,
    double? otpValidity,
  }) {
    return OTPModel(
      email: email ?? this.email,
      message: message ?? this.message,
      otpValidity: otpValidity ?? this.otpValidity,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'message': message,
      'otpValidity': otpValidity,
    };
  }

  factory OTPModel.fromMap(Map<String, dynamic> map) {
    return OTPModel(
      email: map['email'] != null ? map['email'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      otpValidity: map['otpValidity'] != null
          ? double.parse('${map['otpValidity'] ?? "3"}')
          : 3,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory OTPModel.fromJson(String source) =>
      OTPModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OTPModel(email: $email, message: $message, otpValidity: $otpValidity)';

  @override
  bool operator ==(covariant OTPModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.message == message &&
        other.otpValidity == otpValidity;
  }

  @override
  int get hashCode => email.hashCode ^ message.hashCode ^ otpValidity.hashCode;
}
