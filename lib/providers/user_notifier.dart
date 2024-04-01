import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  Future<void> loadUserData(String uid) async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      if (userSnapshot.docs.isEmpty) {
        state = null;
        return;
      }

      var userData = userSnapshot.docs.first;

      state = UserModel(
        uid: uid,
        firstName: userData.get('first name'),
        lastName: userData.get('last name'),
        email: userData.get('email'),
        age: userData.get('age'),
      );
    } catch (e) {
      state = null;
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }
}
