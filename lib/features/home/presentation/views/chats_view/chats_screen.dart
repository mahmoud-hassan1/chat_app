import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/features/home/data/models/chat_model.dart';
import 'package:chat_app/features/home/presentation/cubits/new_chat_cubit/new_chat_cubit.dart';
import 'package:chat_app/features/home/presentation/views/new_chat/new_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('participants', arrayContains: UserModel.instance!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No chats found'),
              );
            } else {
              List<ChatModel> chats = [];
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                chats.add(ChatModel.fromJson(
                    snapshot.data!.docs[i].data() as Map<String, dynamic>));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Text(
                      chats[index].firstUser.email == UserModel.instance!.email
                          ? chats[index].secondUser.name
                          : chats[index].firstUser.name);
                },
                itemCount: chats.length,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider(
                        create: (context) => NewChatCubit(),
                        child: const NewChatScreen(),
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
