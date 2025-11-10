// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:kiwoo/app/core/utils/dateTime_Utility.dart';
import 'package:kiwoo/app/data/models/contact_list_model.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage_pro/get_storage_pro.dart';

import 'message_model.dart';

List<ChatModel> listChatModelFromMap(data) =>
    List<ChatModel>.from((data as List).map((el) => ChatModel.fromMap(el)));

@gsp
class ChatModel extends CommonDataClass<ChatModel> {
  @override
  String id;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Message> messages;
  List<ContactData> members;
  RxBool isTyping = false.obs;
  int count;

  ChatModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    required this.messages,
    required this.members,
    this.count = 0,
  });

  ChatModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Message>? messages,
    List<ContactData>? members,
    int? count,
  }) {
    return ChatModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messages: messages ?? this.messages.map((el) => el.copyWith()).toList(),
      members: members ?? this.members.map((el) => el.copyWith()).toList(),
      count: count ?? this.count,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'messages': messages.map((x) => x.toMap()).toList(growable: true),
      'members': members
          .map((x) => {"member": x.toMap()})
          .toList(growable: true),
      '_count': {'messages': count},
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    var model = ChatModel(
      id: map['id'],
      createdAt: map['created_at'] != null
          ? DateTimeUtility.convertDateFromString(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTimeUtility.convertDateFromString(map['updated_at'])
          : null,
      messages: List.from(
        (map['messages']).map(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
      count: map['_count'] != null ? map['_count']['messages'] : 0,
      members: List.from(
        (map['members']).map(
          (x) => ContactData.fromMap(x['member'] as Map<String, dynamic>),
        ),
      ),
    );
    return model;
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, messages: $messages, members: $members, count: $count)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.count == count &&
        listEquals(other.messages, messages) &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        messages.hashCode ^
        count.hashCode ^
        members.hashCode;
  }
}
