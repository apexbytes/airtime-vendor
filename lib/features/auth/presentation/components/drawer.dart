import 'package:antelope/features/auth/presentation/components/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:antelope/themes/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSettingsTap;
  final void Function()? onHelpTap;
  final void Function()? onLogoutTap;

  const MyDrawer({super.key, required this.onProfileTap, required this.onSettingsTap, required this.onHelpTap, this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
          thickness: 0, // Ensure thickness is zero
        ),
      ),
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'lib/assets/icons/icon.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              MyListTile(
                icon: Icons.home_outlined,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),
              ),

              // Profile
              MyListTile(
                  icon: Icons.person_2_outlined,
                  text: 'P R O F I L E',
                  onTap: onProfileTap),

              // Settings
              MyListTile(
                  icon: Icons.settings_outlined,
                  text: 'S E T T I N G S',
                  onTap: onSettingsTap),

              // Help
              MyListTile(
                  icon: Icons.question_mark_outlined,
                  text: 'H E L P',
                  onTap: onHelpTap),
            ],
            ),
            // Logout
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Row(
                children: [
                  // Logout
                  Expanded(
                    child: MyListTile(
                        icon: Icons.logout_outlined,
                        text: 'L O G O U T',
                        onTap: onLogoutTap),
                  ),
                  // Icon button
                  IconButton(
                    onPressed: () {
                      Provider.of<ThemeProvider>(context).toggleTheme();
                    },
                    icon: Icon(
                        Icons.lightbulb_outline,
                        color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
