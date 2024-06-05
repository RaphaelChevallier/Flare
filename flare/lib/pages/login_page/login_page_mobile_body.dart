import 'package:flare/auth/auth_service.dart';
import 'package:flare/components/my_button.dart';
import 'package:flare/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoginPageMobileScaffold extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPageMobileScaffold({super.key, required this.onTap});

  //tap to go to register page
  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    } catch (e) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) => PlatformAlertDialog(
                  title: PlatformText(e.toString()),
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.local_shipping_rounded,
                size: 60, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 50),
            //welcome message
            PlatformText("Welcome!", style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 25),
            //textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),
            //login button
            const SizedBox(height: 25),
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),
            //register now
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlatformText("Not a member? ",
                    style: TextStyle(color: Colors.grey[700])),
                GestureDetector(
                  onTap: onTap,
                  child: PlatformText(
                    "Register now",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
