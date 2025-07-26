class Message {
  Message(this.senderEmail,this.message,this.createdAt);
  String message;
  String senderEmail ;
  String createdAt;

  factory Message.fromjson(jsonData){
    return Message(jsonData['email'], jsonData['message'],jsonData['createdAt']);
  }
  
  Map<String,dynamic> tojson(){
    return {
      'email':senderEmail,
      'message':message,
      'createdAt':createdAt,
    };
  }
}