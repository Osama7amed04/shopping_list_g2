import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final usersRef = FirebaseFirestore.instance.collection('Users');
  final listRef = FirebaseFirestore.instance.collection('List');
  Future<void> addUser(String email) async {
    await usersRef.add({'email': email});
  }

  Stream<QuerySnapshot> getUsers() {
    return usersRef.snapshots();
  }

  Stream<QuerySnapshot> getLists() {
    return listRef.snapshots();
  }

  Future<void> addListItems(
      String creator, List<String> items, List<String> accessedUsers) async {
    await listRef.add({
      'creator': creator,
      'items': items,
      'accessedUsers': accessedUsers,
    });
  }

  Future<void> removeList(String id) async {
    await listRef.doc(id).delete();
  }

  Future<void> updateItem(String id, List<String> items) async {
    await listRef.doc(id).update({'items': items});
  }

  Future<void> updateAccessedUsers(String id, List<String> items) async {
    await listRef.doc(id).update({'items': items});
  }
}
