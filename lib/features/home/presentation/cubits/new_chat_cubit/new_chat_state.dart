part of 'new_chat_cubit.dart';

@immutable
abstract class NewChatState {}

class NewChatInitial extends NewChatState {}

// Search states
class NewChatSearchLoading extends NewChatState {}

class NewChatSearchLoadingMore extends NewChatState {
  final List<UserModel> users;
  
  NewChatSearchLoadingMore({required this.users});
}

class NewChatSearchSuccess extends NewChatState {
  final List<UserModel> users;
  
  NewChatSearchSuccess({required this.users});
}

class NewChatSearchFailure extends NewChatState {
  final String error;
  
  NewChatSearchFailure({required this.error});
}

// Chat creation states
class NewChatLoading extends NewChatState {}

class NewChatSuccess extends NewChatState {}

class NewChatFailure extends NewChatState {
  final String error;
  
  NewChatFailure({required this.error});
}