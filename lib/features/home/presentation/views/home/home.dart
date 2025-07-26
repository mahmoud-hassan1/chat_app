import 'package:chat_app/core/constants.dart';
import 'package:chat_app/core/user_model.dart';
import 'package:chat_app/features/home/data/models/message_model.dart';
import 'package:chat_app/features/home/presentation/views/home/components/chatbubble.dart';
import 'package:chat_app/features/home/presentation/views/home/components/otherschatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
   Home({super.key});
  CollectionReference messages=FirebaseFirestore.instance.collection("messages"); 
  TextEditingController controller= TextEditingController();
  final _controller=ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt',descending: true).snapshots(),
      builder:(context,snapshot){
        if(snapshot.hasData){
          List<Message>messageList=[];
          for(int i=0;i<snapshot.data!.docs.length;i++){
              messageList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
        return Scaffold(
        appBar: AppBar(
          title:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/image/scholar.png',
              height: 60.h,
              ),
              const Text(
                'Chat',
                style: TextStyle(
                  color: Colors.white
                ),
                ),
            ],
          ),
          backgroundColor: kPriamryColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: _controller,
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                
              return messageList[index].email==UserModel.instance!.email? CusttomChatBubble(text: messageList[index].message):OthersChatBubble(text: messageList[index].message);
              },),
            ),
            Container(
            height: 70.h,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller:  controller,
              onSubmitted: (value) {
                messages.add({
                  'email':UserModel.instance!.email,
                  'message':value,
                  'createdAt': DateTime.now()
                });
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              autocorrect: true,
              decoration: InputDecoration(
                enabledBorder:OutlineInputBorder(
                  borderSide: const BorderSide(
                  color: Colors.purple,
                  
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(15.r)),
                   ), 
               border: OutlineInputBorder(
                  borderSide: const BorderSide(
                  color: Colors.purple,
                  
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(15.r)),
                   ),
                   suffixIcon: IconButton(onPressed: (){},icon: const Icon(Icons.send,color: Colors.purple,))
              ),
            ),
            )
      
          ],
        )
      );
      }
      else{
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      }
    );
  }
}

