import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';

class ChatModel {
  final String? id;
  final UserModel firstUser;
  final UserModel secondUser;
  final Message? lastMessage;
  final String profileImage;
  final List<String> participants;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  ChatModel( { required this.updatedAt, required this.createdAt,required this.participants, this.id, required this.firstUser, required this.secondUser,  this.lastMessage, required this.profileImage});

  factory ChatModel.fromJson(Map<String,dynamic> json){
    return ChatModel(updatedAt: json['updatedAt'], createdAt: json['createdAt'], participants: json['participants'], id: json['id'], firstUser: UserModel.fromJson(json['firstUser']), secondUser: UserModel.fromJson(json['secondUser']), lastMessage: Message.fromjson(json['lastMessage']), profileImage: json['profileImage']);
  }
  Map<String,dynamic> toJson(){
    return {
      'firstUser':firstUser.toJson(),
      'secondUser':secondUser.toJson(),
      'lastMessage':lastMessage?.tojson(), 
      'profileImage':profileImage,
      'participants':participants,
    };
  }
}