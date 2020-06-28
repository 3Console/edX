import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class CourseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreInstance = Firestore.instance;

  Future<String> getUserID() async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      final userId = user.uid;
      return userId;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<QuerySnapshot> getCourseByType(String type) {
    return _firestoreInstance
        .collection('Courses')
        .where('type', isEqualTo: type)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserCourseByType(String uid, String type) {
    return _firestoreInstance
        .collection('User Course')
        .where('uid', isEqualTo: uid)
        .where('type', isEqualTo: type)
        .snapshots();
  }

  void enrollCourse(String uid, Map course) {
    _firestoreInstance.collection('User Course').add({
      "uid": uid,
      "name": course['name'],
      "url": course['url'],
      "publisher": course['publisher'],
      'type': course['type']
    });
  }

  Stream<QuerySnapshot> getCourseIDByUser(String uid) {
    return _firestoreInstance
        .collection('User Course')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
