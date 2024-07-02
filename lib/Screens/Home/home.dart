import 'package:chat_app/Constants/constants.dart';
import 'package:chat_app/Cupits/auth/auth_cubit.dart';
import 'package:chat_app/Models/message_model.dart';
import 'package:chat_app/Screens/Home/Components/chatbubble.dart';
import 'package:chat_app/Screens/Home/Components/otherschatbubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
   Home({super.key});
  CollectionReference messages=FirebaseFirestore.instance.collection("messages"); 
  TextEditingController controller=new TextEditingController();
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
              Text(
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
                
              return messageList[index].email==BlocProvider.of<AuthCubit>(context).user!.user!.email? CusttomChatBubble(text: messageList[index].message):OthersChatBubble(text: messageList[index].message);
              },),
            ),
            Container(
            height: 70.h,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: TextField(
              controller:  controller,
              onSubmitted: (value) {
                messages.add({
                  'email':BlocProvider.of<AuthCubit>(context).user!.user!.email,
                  'message':value,
                  'createdAt': DateTime.now()
                });
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              autocorrect: true,
              decoration: InputDecoration(
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.purple,
                  
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(15.r)),
                   ), 
               border: OutlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.purple,
                  
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(15.r)),
                   ),
                   suffixIcon: IconButton(onPressed: (){},icon: Icon(Icons.send,color: Colors.purple,))
              ),
            ),
            )
      
          ],
        )
      );
      }
      else{
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      }
    );
  }
}

