import 'package:booku/exports.dart';

class AuthApi extends BaseApi {
  Future<UserCredential> login(String email, pwd) async {
    return await auth
        .signInWithEmailAndPassword(email: email, password: pwd)
        .then((UserCredential user) => credential = user)
        .catchError((object, stacktrace) {});
  }

  Future<UserCredential> signup(String email, pwd) async {
    return await auth
        .createUserWithEmailAndPassword(email: email, password: pwd)
        .then((UserCredential user) => credential = user)
        .catchError((object, stacktrace) {});
  }

  Future<UserCredential> anon() async {
    return await auth
        .signInAnonymously()
        .then((UserCredential user) => credential = user)
        .catchError((e) {});
  }

  User? user() => auth.currentUser;

  Stream<User?> authState() => auth.authStateChanges();

  Future setup() async {}
}
