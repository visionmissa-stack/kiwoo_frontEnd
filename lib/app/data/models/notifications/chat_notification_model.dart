// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatNotificationModel {
  final String chatId;
  final String avatar;
  final String senderId;
  String senderName;
  String message;
  int count;

  bool read = false;
  ChatNotificationModel({
    required this.chatId,
    required this.avatar,
    required this.senderId,
    required this.senderName,
    required this.message,
    this.count = 0,
    this.read = false,
  });

  ChatNotificationModel copyWith({
    String? chatId,
    String? avatar,
    String? senderId,
    String? senderName,
    String? message,
    int? count,
    bool? read,
  }) {
    return ChatNotificationModel(
      chatId: chatId ?? this.chatId,
      avatar: avatar ?? this.avatar,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      count: count ?? this.count,
      read: read ?? this.read,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'avatar': avatar,
      'senderId': senderId,
      'senderName': senderName,
      'message': message,
      'count': count,
      'read': read,
    };
  }

  factory ChatNotificationModel.fromMap(Map<String, dynamic> map) {
    return ChatNotificationModel(
      chatId: map['chatId'] as String,
      avatar: map['avatar'] as String,
      senderId: map['senderId'] as String,
      senderName: map['senderName'] as String,
      message: map['message'] as String,
      count: map['count'] as int,
      read: map['read'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatNotificationModel.fromJson(String source) =>
      ChatNotificationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatNotificationModel(chatId: $chatId, avatar: $avatar, senderId: $senderId, senderName: $senderName, message: $message, count: $count, read: $read)';
  }

  @override
  bool operator ==(covariant ChatNotificationModel other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.avatar == avatar &&
        other.senderId == senderId &&
        other.senderName == senderName &&
        other.message == message &&
        other.count == count &&
        other.read == read;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        avatar.hashCode ^
        senderId.hashCode ^
        senderName.hashCode ^
        message.hashCode ^
        count.hashCode ^
        read.hashCode;
  }
}
