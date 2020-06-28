import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreInstance = Firestore.instance;

  Future getUserID() async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      final userId = user.uid;
      return userId;
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  Stream<QuerySnapshot> getCourseByType(String type) {
    return _firestoreInstance.collection('Courses')
                            .where('type', isEqualTo: type)
                            .snapshots();
  }

  void enrollCourse(String uid, String courseID) {
    _firestoreInstance.collection('User Course').add({
      "uid": uid,
      "course_id": courseID
    });
  }
}
