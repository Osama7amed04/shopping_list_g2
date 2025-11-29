import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  final usersRef = FirebaseFirestore.instance.collection('Users');
  final listRef = FirebaseFirestore.instance.collection('List');
  Future<void> addUser(String email) async {
    await usersRef.add({'email': email});
  }

  Stream<QuerySnapshot> getUsersSnapshot() {
    return usersRef.snapshots();
  }

  Future<List<Map<String, dynamic>>> getUsersList() async {
    try {
      final ref = await usersRef.get();
      final data = ref.docs
          .map(
            (e) => e.data(),
          )
          .toList();
      return data;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> getListsSnapshot() {
    return listRef.snapshots();
  }

  Future<void> addListItems(String listName, String creator, List<String> items,
      List<String> accessedUsers) async {
    await listRef.add({
      'listName': listName,
      'creator': creator,
      'items': items,
      'accessedUsers': accessedUsers,
    });
  }

  Future<void> removeList(String id) async {
    await listRef.doc(id).delete();
  }

  Future<Map<String, dynamic>?> getList(String id) async {
    final doc = await listRef.doc(id).get();
    return doc.exists ? doc.data() : null;
  }

  Future<void> updateList(
      {required String id,
      required String listName,
      required List<String> items,
      required List<String> accessedUsers}) async {
    await listRef.doc(id).update({
      'listName': listName,
      'items': items,
      'accessedUsers': accessedUsers,
    });
  }
}
