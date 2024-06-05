import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.obscureText,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: PlatformTextField(
          material: (_, __) => MaterialTextFieldData(
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary)),
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  filled: true,
                  hintText: hintText,
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary))),
          cupertino: (_, __) => CupertinoTextFieldData(),
        ));
  }
}
