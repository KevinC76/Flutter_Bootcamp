import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Map? currentUser;

  final String USER_COLLECTION = 'users';
  final String POST_COLLECTION = 'posts';

  FirebaseService();

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String _userId = _userCredential.user!.uid;

      await _db.collection(USER_COLLECTION).doc(_userId).set({
        "name": name,
        "email": email,
        "image": "https://i.pravatar.cc/300",
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _db.collection(USER_COLLECTION).doc(uid).get();

    return _doc.data() as Map;
  }

  Future<bool> postImage(File _image) async {
    String _userId = _auth.currentUser!.uid;
    String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
        p.extension(_image.path);

    if (_fileName.isNotEmpty) {
      try {
        await _db.collection(POST_COLLECTION).add({
          "userId": _userId,
          "timestamp": Timestamp.now(),
          "image":
              "https://fastly.picsum.photos/id/974/1920/1080.jpg?hmac=KAfv-iO95FWfAS9tKHoNq_cqVtDFas1rmZCuS2tgDi0"
        });
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  Stream<QuerySnapshot> getPostsForUser() {
    String _userId = _auth.currentUser!.uid;
    return _db
        .collection(POST_COLLECTION)
        .where('userId', isEqualTo: _userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getLatestPost() {
    return _db
        .collection(POST_COLLECTION)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
