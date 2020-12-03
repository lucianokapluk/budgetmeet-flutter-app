import 'package:budgetmeet/src/pages/drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static final String routeName = 'settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajustes'),
        ),
        drawer: CustomDrawer(),
        body: Center(
          child: Text('Paginas de Ajustes'),
        ));
  }
}
