import 'package:flare/components/my_drawer.dart';
import 'package:flare/components/my_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
          backgroundColor: Colors.transparent,
          material: (_, __) =>
              MaterialAppBarData(forceMaterialTransparency: true),
          cupertino: (_, __) => CupertinoNavigationBarData(
                backgroundColor: Colors.transparent,
                border: null,
              )),
      material: (_, __) => MaterialScaffoldData(
        extendBodyBehindAppBar: true,
        body: const MyMap(),
        drawer: const MyDrawer(),
      ),
      cupertino: (_, __) => CupertinoPageScaffoldData(body: const MyMap()),
    );
  }
}
