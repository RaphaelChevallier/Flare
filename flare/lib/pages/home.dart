import 'package:flare/components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(),
      material: (_, __) => MaterialScaffoldData(drawer: const MyDrawer()),
    );
  }
}
