import 'package:calculator/services/firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isSignedIn = false;

  Future<void> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await auth.signInWithCredential(credential);
    isSignedIn = true;
    FirestoreDatabase database = FirestoreDatabase();
    bool existance = await database.checkIfUserExists();
    if(existance){
      database.fetchData();
    }
    else{
      database.addData();
    }
  }

  signOut() async {
    await auth.signOut();
    isSignedIn = false;
  }

  User? getCurrentUser() {
    return auth.currentUser;
  }
}