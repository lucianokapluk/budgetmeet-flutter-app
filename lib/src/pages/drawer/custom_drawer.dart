import 'package:budgetmeet/providers/login_provider.dart';
import 'package:budgetmeet/src/pages/drawer/theme_provider.dart';

import 'package:budgetmeet/src/pages/settings/settings_page.dart';
import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final preferences = new UserPreference();
    final loginprovider = Provider.of<LoginProvider>(context);
    final darkModeProvider = Provider.of<DarkModeProvider>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: NetworkImage(preferences.photoURL ??
                      'https://picsum.photos/id/1/200/300'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(preferences.displayName ?? ''),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Dark mode'),
            trailing: Switch(
              value: preferences.darkMode ?? false,
              activeColor: Colors.orange,
              focusColor: Colors.orange,
              onChanged: (value) {
                if (value) {
                  preferences.darkMode = value;
                  setState(() {
                    darkModeProvider.darkMode = value;
                  });
                  print(value);
                } else {
                  setState(() {
                    darkModeProvider.darkMode = value;
                  });
                  print(value);
                  preferences.darkMode = value;
                }
              },
            ),
            onTap: () => Navigator.pushNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.pages),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () => Navigator.pushNamed(context, SettingsPage.routeName),
          ),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesion'),
              onTap: () {
                Navigator.pop(context);
                loginprovider.logout();
              }),
        ],
      ),
    );
  }
}
