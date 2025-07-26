import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/core/result/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Create a class to hold both users and last document
class SearchResult {
  final List<UserModel> users;
  final DocumentSnapshot? lastDocument;
  
  SearchResult({required this.users, this.lastDocument});
}

abstract class NewChatRepo{
  Future<Result<SearchResult>> searchUsers(String query, {int limit = 10, DocumentSnapshot? lastDocument});
  Future<Result<String>> createChat(UserModel user);
}