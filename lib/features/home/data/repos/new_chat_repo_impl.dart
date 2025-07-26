import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/core/error/firestore_error_handler.dart';
import 'package:chat_app/core/result/result.dart';
import 'package:chat_app/features/home/data/models/chat_model.dart';
import 'package:chat_app/features/home/data/repos/new_chat_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewChatRepoImpl extends NewChatRepo {
  @override
  Future<Result<SearchResult>> searchUsers(String query, {int limit = 10, DocumentSnapshot? lastDocument}) async {
    try {
      // Convert query to lowercase for case-insensitive search
      final searchQuery = query.toLowerCase();
      final endQuery = searchQuery + '\uf8ff';
      
      Query queryRef = FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: endQuery)
          .orderBy('name') // Important: Add explicit ordering
          .limit(limit);

      // Add pagination cursor if provided and valid
      if (lastDocument != null) {
        try {
          // Validate that the lastDocument has the required fields
          final lastDocData = lastDocument.data() as Map<String, dynamic>?;
          if (lastDocData != null && lastDocData.containsKey('name')) {
            queryRef = queryRef.startAfterDocument(lastDocument);
          } else {
            print('Warning: lastDocument is missing required fields, skipping pagination');
          }
        } catch (e) {
          print('Warning: Error with lastDocument, skipping pagination: $e');
          // Continue without pagination rather than failing
        }
      }

      final querySnapshot = await queryRef.get();
      List<UserModel> usersList = [];

      for (var doc in querySnapshot.docs) {
        try {
          final userData = doc.data() as Map<String, dynamic>;
          final user = UserModel.fromJson(userData);
          
          // Filter out current user and check if email also matches
          if (user.email != UserModel.instance!.email) {
            // If the query matches email, include it even if name doesn't match exactly
            if (user.email.toLowerCase().contains(searchQuery) ||
                user.name.toLowerCase().contains(searchQuery)) {
              usersList.add(user);
            }
          }
        } catch (e) {
          print('Warning: Error parsing user document ${doc.id}: $e');
          // Continue with other documents
        }
      }

      // Get the last document for pagination - ensure it's valid
      DocumentSnapshot? lastDoc;
      if (querySnapshot.docs.isNotEmpty) {
        final potentialLastDoc = querySnapshot.docs.last;
        try {
          // Validate the document before using it for pagination
          final docData = potentialLastDoc.data() as Map<String, dynamic>?;
          if (docData != null && docData.containsKey('name')) {
            lastDoc = potentialLastDoc;
          }
        } catch (e) {
          print('Warning: Last document validation failed: $e');
        }
      }

      return Result.success(SearchResult(users: usersList, lastDocument: lastDoc));
    } catch (e) {
      print('Error in searchUsers: $e');
      return Result.failure(FirestoreErrorHandler.handleError(e));
    }
  }

  @override
  Future<Result<String>> createChat(UserModel user) async {
    try {
      final chat = ChatModel(
        updatedAt: null,
        createdAt: null,
        participants: [UserModel.instance!.email, user.email],
        id: null,
        firstUser: UserModel.instance!,
        secondUser: user,
        profileImage: '',
      );

      final chatData = chat.toJson();
      chatData['updatedAt'] = FieldValue.serverTimestamp();
      chatData['createdAt'] = FieldValue.serverTimestamp();

      final docRef = await FirebaseFirestore.instance.collection('chats').add(chatData);
      final chatId = docRef.id;

      return Result.success(chatId);
    } catch (e) {
      return Result.failure(FirestoreErrorHandler.handleError(e));
    }
  }
}