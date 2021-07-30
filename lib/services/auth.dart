import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizmaker/models/my_user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInEmailAndPass(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseUser = authResult.user;
      return MyUser(uid: firebaseUser!.uid);
    } catch (e) {
      FirebaseAuthException exception = e as FirebaseAuthException;
      return exception.message.toString();
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = authResult.user;
      return MyUser(uid: firebaseUser!.uid);
    } catch (e) {
      FirebaseAuthException exception = e as FirebaseAuthException;
      return exception.message.toString();
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
