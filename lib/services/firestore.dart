import 'package:calculator/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreDatabase{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Authentication auth = Authentication();
  int points = 0;

  addData() async {
    await firestore.collection('users').where('users', isEqualTo: auth.getCurrentUser()?.uid).get();
    await firestore.collection('users').doc(auth.getCurrentUser()?.uid).set({
      'points': 0
    });
  }

  Future<int> fetchData() async {
    CollectionReference collectionReference = await firestore.collection('users');
    DocumentSnapshot documentSnapshot = await collectionReference.doc(auth.getCurrentUser()?.uid).get();
    var data = documentSnapshot.data() as Map;
    points = await data['points'];
    return points;
  }
}