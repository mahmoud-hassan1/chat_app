class UserModel {
  final String name;
  final String email;
  final String id;  

  UserModel({required this.name,required this.email,required this.id});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      id: json['id'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  static void fillInstanceWithJson(Map<String, dynamic> json) {
    _instance = UserModel.fromJson(json);
  }
    // Singleton pattern
  static UserModel? _instance;

  // Getter to access the current instance
  static UserModel? get instance => _instance;
  
  // Method to clear the instance (useful for logout)
  static void clearInstance() {
    _instance = null;
  }
}
