import 'package:flare/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  //sign in
  Future<AuthResponse> signInWithEmailPassword(String email, password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
      return res;
    } on AuthException catch (error) {
      throw Exception(error.message);
    }
  }

  //signup
  Future<AuthResponse> signUpWithEmailPassword(
      String email, password, name) async {
    try {
      final AuthResponse res = await supabase.auth
          .signUp(email: email, password: password, data: {"name": name});
      final Session? session = res.session;
      final User? user = res.user;
      return res;
    } on AuthException catch (error) {
      throw Exception(error.message);
    }
  }
  //signout

  Future<void> signOut() async {
    return supabase.auth.signOut();
  }
  //errors
}
