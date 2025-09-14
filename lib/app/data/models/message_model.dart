import 'dart:convert';

import '../../core/utils/dateTime_Utility.dart';
import '../../core/utils/enums.dart';

List<Message> listMessageFromMap(data) =>
    List<Message>.from((data as List).map((el) => Message.fromMap(el)));

class Message {
  final int? id;
  String? content;
  final int? senderId;
  final String? chatId;
  MessageStatus status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Message({
    this.id,
    this.content,
    this.senderId,
    this.chatId,
    this.status = MessageStatus.sending,
    this.createdAt,
    this.updatedAt,
  });

  Message copyWith({
    int? id,
    String? content,
    int? senderId,
    String? chatId,
    MessageStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      chatId: chatId ?? this.chatId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'sender_id': senderId,
      'chat_id': chatId,
      'status': status.name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as int : null,
      content: map['content'] != null ? map['content'] as String : null,
      senderId: map['sender_id'] != null ? map['sender_id'] as int : null,
      chatId: map['chat_id'] != null ? map['chat_id'] as String : null,
      status: MessageStatus.fromMap(map['status']),
      createdAt: map['created_at'] != null
          ? DateTimeUtility.convertDateFromString(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTimeUtility.convertDateFromString(map['updated_at'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, content: $content, senderId: $senderId, chatId: $chatId, status: ${status.name}, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.senderId == senderId &&
        other.chatId == chatId &&
        other.status == status &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        senderId.hashCode ^
        chatId.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
