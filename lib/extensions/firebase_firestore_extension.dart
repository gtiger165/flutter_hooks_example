import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFirestoreX on FirebaseFirestore {
  CollectionReference<Map<String, dynamic>> usersListRef(String userId) =>
      collection('lists').doc(userId).collection('userList');
}
