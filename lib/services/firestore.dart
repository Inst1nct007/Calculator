import 'package:calculator/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase{
  int points = 0;
  Authentication auth = Authentication();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> checkIfUserExists() async {
    CollectionReference collectionReference = firestore.collection('users');
    DocumentSnapshot documentSnapshot = await collectionReference.doc(auth
        .getCurrentUser()
        ?.uid).get();
    return documentSnapshot.exists;
  }

  addData() async {
    await firestore.collection('users').doc(auth.getCurrentUser()?.uid).set({
      'points': 1
    });
    points = await fetchData();
  }

  Future<int> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionReference = firestore.collection('users');
    DocumentSnapshot documentSnapshot = await collectionReference.doc(auth.getCurrentUser()?.uid).get();
    var data = documentSnapshot.data() as Map;
    points = await data['points'];
    return points;
  }

  removePoint(int point) async {
    points = await fetchData();
    CollectionReference collectionReference = firestore.collection('users');
    await collectionReference.doc(auth.getCurrentUser()?.uid).update({'points': points - point});
  }

  addAdPoint() async {
    points = await fetchData();
    CollectionReference collectionReference = firestore.collection('users');
    await collectionReference.doc(auth.getCurrentUser()?.uid).update({'points': points + 5});
  }
}