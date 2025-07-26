class Message {
  Message(this.email,this.message);
  String message;
  String email ;
  factory Message.fromjson(jsonData){
    return Message(jsonData['email'], jsonData['message']);
  }
}