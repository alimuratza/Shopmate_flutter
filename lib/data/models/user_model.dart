// User Model - represents user data
class UserModel {
  String uid;
  String email;
  String? name;

  UserModel({
    required this.uid,
    required this.email,
    this.name,
  });

  // Create UserModel from Firebase User
  factory UserModel.fromFirebase(user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName,
    );
  }
}
