import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SettingsPageMobileScaffold extends StatelessWidget {
  SettingsPageMobileScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
      title: PlatformText("Settings"),
    ));
  }
}
