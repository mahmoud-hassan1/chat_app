import 'package:bloc/bloc.dart';
import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/features/home/data/repos/new_chat_repo.dart';
import 'package:chat_app/features/home/data/repos/new_chat_repo_impl.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'new_chat_state.dart';

class NewChatCubit extends Cubit<NewChatState> {
  NewChatCubit() : super(NewChatInitial());
  
  final NewChatRepo newChatRepo = NewChatRepoImpl();
  
  List<UserModel> users = [];
  DocumentSnapshot? lastDocument;
  bool hasMoreData = true;
  bool isLoadingMore = false;
  String currentQuery = '';
  
  Future<void> searchUsers(String query) async {
    // Update current query
    currentQuery = query;
    
    // Reset pagination state for new search
    lastDocument = null;
    hasMoreData = true;
    users.clear();
    isLoadingMore = false;
    
    emit(NewChatSearchLoading());
    
    try {
      final result = await newChatRepo.searchUsers(query);
      if (result.isSuccess) {
        final searchResult = result.value;
        users = searchResult.users;
        lastDocument = searchResult.lastDocument;
        hasMoreData = searchResult.users.length >= 9;
        emit(NewChatSearchSuccess(users: users));
      } else {
        emit(NewChatSearchFailure(error: result.errorMessage));
      }
    } catch (e) {
      emit(NewChatSearchFailure(error: e.toString()));
    }
  }

  Future<void> loadMoreUsers([String? query]) async {
    // Use provided query or current query
    final searchQuery = query ?? currentQuery;
    
    if (!hasMoreData || isLoadingMore || users.isEmpty || searchQuery.isEmpty) return;
    
    isLoadingMore = true;
    emit(NewChatSearchLoadingMore(users: users));
    
    try {
      final result = await newChatRepo.searchUsers(searchQuery, lastDocument: lastDocument);
      if (result.isSuccess) {
        final searchResult = result.value;
        if (searchResult.users.isNotEmpty) {
          // Add new users to existing list
          users.addAll(searchResult.users);
          lastDocument = searchResult.lastDocument;
          hasMoreData = searchResult.users.length >= 9;
          emit(NewChatSearchSuccess(users: users));
        } else {
          hasMoreData = false;
          emit(NewChatSearchSuccess(users: users));
        }
      } else {
        // On pagination error, don't fail completely - just stop loading more
        print('Pagination error: ${result.errorMessage}');
        hasMoreData = false;
        emit(NewChatSearchSuccess(users: users));
      }
    } catch (e) {
      // On pagination error, don't fail completely - just stop loading more
      print('Pagination exception: $e');
      hasMoreData = false;
      emit(NewChatSearchSuccess(users: users));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> createChat(UserModel user) async {
    emit(NewChatLoading());
    try {
      final result = await newChatRepo.createChat(user);
      if (result.isSuccess) {
        emit(NewChatSuccess());
      } else {
        emit(NewChatFailure(error: result.errorMessage));
      }
    } catch (e) {
      emit(NewChatFailure(error: e.toString()));
    }
  }

  // Helper method to check if we can load more
  bool get canLoadMore => hasMoreData && !isLoadingMore && users.isNotEmpty && currentQuery.isNotEmpty;
  
  // Method to handle scroll events
  void handleScroll(double pixels, double maxScrollExtent) {
    print('pixels: $pixels');
    print('maxScrollExtent: $maxScrollExtent');
    print('canLoadMore: $canLoadMore');
    print('users.length: ${users.length}');
    print('currentQuery: $currentQuery');
    // Load more when user is within 200 pixels of bottom
    if (pixels >= maxScrollExtent - 200 && canLoadMore) {
      print('loading more users');
      loadMoreUsers();
    }
  }
}