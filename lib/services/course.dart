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

  Stream<QuerySnapshot> getUserCourseByUser(String uid) {
    return _firestoreInstance
        .collection('User Course')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<DocumentSnapshot> getCourseDetail(String courseID) {
    return _firestoreInstance
        .collection('Courses')
        .document(courseID)
        .snapshots();
  }

  void enrollCourse(String uid, Map course) {
    _firestoreInstance.collection('User Course').add({
      "uid": uid,
      "course_id": course['course_id'],
    });
  }

  Stream<QuerySnapshot> getCourseIDByUser(String uid) {
    return _firestoreInstance
        .collection('User Course')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future<QuerySnapshot> checkEnroll(String uid, String courseID) {
    Stream<QuerySnapshot> result = _firestoreInstance
        .collection('User Course')
        .where('uid', isEqualTo: uid)
        .where('course_id', isEqualTo: courseID)
        .snapshots();
    return result.first;
  }

  Stream<QuerySnapshot> getLesson(String courseID) {
    return _firestoreInstance
        .collection('Lessons')
        .where('course_id', isEqualTo: courseID)
        .snapshots();
  }
}
