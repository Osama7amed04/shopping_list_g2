import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference listRef =
      FirebaseFirestore.instance.collection('List');

 
  Future<void> addUser(String uid, String email) async {
    await usersRef.doc(uid).set({
      'uid': uid,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

 
  Stream<QuerySnapshot> getUsersSnapshot() {
    return usersRef.snapshots();
  }

 
  Future<List<Map<String, dynamic>>> getUsersList() async {
    final ref = await usersRef.get();
    return ref.docs.map((e) => e.data() as Map<String, dynamic>).toList();
  }


  Stream<QuerySnapshot> getListsSnapshot() {
    return listRef.snapshots();
  }


  Future<void> addListItems(
    String listName,
    String creator, // UID
    List<String> items,
    List<String> accessedUsers, // UIDs
  ) async {
    await listRef.add({
      'listName': listName,
      'creator': creator,
      'items': items,
      'accessedUsers': accessedUsers,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }


  Future<void> removeList(String id) async {
    await listRef.doc(id).delete();
  }

  
  Future<Map<String, dynamic>?> getList(String id) async {
    final doc = await listRef.doc(id).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  Future<void> updateList({
    required String id,
    required String listName,
    required List<String> items,
    required List<String> accessedUsers,
  }) async {
    await listRef.doc(id).update({
      'listName': listName,
      'items': items,
      'accessedUsers': accessedUsers,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
