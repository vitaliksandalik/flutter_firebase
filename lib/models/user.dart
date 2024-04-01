class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final int age;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
  });

  factory UserModel.fromFirestore(
      Map<String, dynamic> firestoreData, String uid) {
    return UserModel(
      uid: uid,
      firstName: firestoreData['first name'] ?? '',
      lastName: firestoreData['last name'] ?? '',
      email: firestoreData['email'] ?? '',
      age: firestoreData['age'] ?? 0,
    );
  }
}
