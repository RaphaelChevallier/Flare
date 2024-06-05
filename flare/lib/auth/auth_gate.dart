import 'package:flare/auth/login_or_register.dart';
import 'package:flare/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Supabase.instance.client.auth.onAuthStateChange,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final event = snapshot.data!.event;
              final session = snapshot.data!.session;

              switch (event) {
                case AuthChangeEvent.signedIn:
                  return const HomePage();
                case AuthChangeEvent.signedOut:
                case AuthChangeEvent.initialSession:
                  return const LoginOrRegister();
                default:
                  return const LoginOrRegister();
              }
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
