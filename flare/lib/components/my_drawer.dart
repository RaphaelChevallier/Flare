import 'package:flare/auth/auth_service.dart';
import 'package:flare/pages/settings_page/settings_page_desktop_body.dart';
import 'package:flare/pages/settings_page/settings_page_mobile_body.dart';
import 'package:flare/pages/settings_page/settings_page_tablet_body.dart';
import 'package:flare/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerHeader(
                      child: Center(
                    child: Icon(Icons.local_shipping_rounded,
                        color: Theme.of(context).colorScheme.primary, size: 40),
                  )),
                  Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: PlatformListTile(
                        title: PlatformText("H O M E"),
                        leading: const Icon(Icons.home),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: PlatformListTile(
                        title: PlatformText("S E T T I N G S"),
                        leading: const Icon(Icons.settings),
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResponsiveLayout(
                                    mobileBody: SettingsPageMobileScaffold(),
                                    tabletBody:
                                        const SettingsPageTabletScaffold(),
                                    desktopBody:
                                        const SettingsPageDesktopScaffold()),
                              ));
                        },
                      )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 25),
                  child: PlatformListTile(
                    title: PlatformText("L O G O U T"),
                    leading: const Icon(Icons.logout),
                    onTap: logout,
                  ))
            ]));
  }
}
