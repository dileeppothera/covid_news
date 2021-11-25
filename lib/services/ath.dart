import 'package:covid_news/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //create user
  User? userFind(FirebaseUser fuser) {
    return fuser != null ? User(fuser.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return auth.onAuthStateChanged
        .map((FirebaseUser user) => userFind(user) as User);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await auth.signInAnonymously();
      FirebaseUser user = result.user;
      return userFind(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email
  Future signInEmail(String email, String pwd) async {
    try {
      AuthResult result =
          await auth.signInWithEmailAndPassword(email: email, password: pwd);
      FirebaseUser user = result.user;
      return userFind(user);
    } catch (e) {}
  }

  //register
  Future registerEmail(String email, String pwd) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      FirebaseUser user = result.user;
      return userFind(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
