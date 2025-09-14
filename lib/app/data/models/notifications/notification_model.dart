// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import 'package:KIWOO/app/core/utils/enums.dart';

@gsp
class NotificationModel extends CommonDataClass<NotificationModel> {
  @override
  String id;
  final NotificationType type;
  final String? title;
  final String? body;
  final String? icon;
  final Map<String, dynamic>? data;
  List<String>? titleLocArgs;
  String? titleLocKey;
  List<String>? bodyLocArgs;
  String? bodyLocKey;
  bool read;
  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.icon,
    this.data,
    this.titleLocArgs,
    this.titleLocKey,
    this.bodyLocArgs,
    this.bodyLocKey,
    this.read = false,
  });

  NotificationModel copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? body,
    String? icon,
    Map<String, dynamic>? data,
    List<String>? titleLocArgs,
    String? titleLocKey,
    List<String>? bodyLocArgs,
    String? bodyLocKey,
    bool? read,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      icon: icon ?? this.icon,
      data: data ?? this.data,
      titleLocArgs: titleLocArgs ?? this.titleLocArgs,
      titleLocKey: titleLocKey ?? this.titleLocKey,
      bodyLocArgs: bodyLocArgs ?? this.bodyLocArgs,
      bodyLocKey: bodyLocKey ?? this.bodyLocKey,
      read: read ?? this.read,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'title': title,
      'body': body,
      'icon': icon,
      'data': data,
      'titleLocArgs': titleLocArgs,
      'titleLocKey': titleLocKey,
      'bodyLocArgs': bodyLocArgs,
      'bodyLocKey': bodyLocKey,
      'read': read,
    };
  }

  factory NotificationModel.fromRemoteMessage(RemoteMessage message) {
    return NotificationModel(
      id: message.data['id'],
      type: NotificationType.fromMap(message.data['type']),
      title: message.notification?.title,
      body: message.notification?.body,
      icon: message.notification?.android?.smallIcon,
      bodyLocArgs: message.notification?.bodyLocArgs,
      titleLocKey: message.notification?.titleLocKey,
      titleLocArgs: message.notification?.titleLocArgs,
      data: message.data,
      bodyLocKey: message.notification?.bodyLocKey,
    );
  }
  String getTitle() {
    if (title != null) {
      return title!;
    } else if (titleLocKey != null) {
      return titleLocKey!.trArgs(titleLocArgs ?? []);
    } else {
      return 'New Notification';
    }
  }

  String getBody() {
    if (body != null) {
      return body!;
    } else if (bodyLocKey != null) {
      return bodyLocKey!.trArgs(bodyLocArgs ?? []);
    } else {
      return 'New Notification';
    }
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      type: NotificationType.fromMap(map['type']),
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      data:
          map['data'] != null ? Map<String, dynamic>.from((map['data'])) : null,
      titleLocArgs: map['titleLocArgs'] != null
          ? List<String>.from((map['titleLocArgs']))
          : null,
      titleLocKey:
          map['titleLocKey'] != null ? map['titleLocKey'] as String : null,
      bodyLocArgs: map['bodyLocArgs'] != null
          ? List<String>.from((map['bodyLocArgs']))
          : null,
      bodyLocKey:
          map['bodyLocKey'] != null ? map['bodyLocKey'] as String : null,
      read: map['read'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, type: $type, title: $title, body: $body, icon: $icon, data: $data, titleLocArgs: $titleLocArgs, titleLocKey: $titleLocKey, bodyLocArgs: $bodyLocArgs, bodyLocKey: $bodyLocKey, read: $read)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.title == title &&
        other.body == body &&
        other.icon == icon &&
        mapEquals(other.data, data) &&
        listEquals(other.titleLocArgs, titleLocArgs) &&
        other.titleLocKey == titleLocKey &&
        listEquals(other.bodyLocArgs, bodyLocArgs) &&
        other.bodyLocKey == bodyLocKey &&
        other.read == read;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        title.hashCode ^
        body.hashCode ^
        icon.hashCode ^
        data.hashCode ^
        titleLocArgs.hashCode ^
        titleLocKey.hashCode ^
        bodyLocArgs.hashCode ^
        bodyLocKey.hashCode ^
        read.hashCode;
  }
}
