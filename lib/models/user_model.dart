class UserModel {
  final String id;
  final String userName;
  final String email;

  UserModel({required this.id, required this.userName, required this.email});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
    );
  }
}
