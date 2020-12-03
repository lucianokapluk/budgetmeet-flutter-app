import 'package:budgetmeet/src/pages/create_event/select_date_page.dart';
import 'package:budgetmeet/src/pages/create_event/select_descriptionEvent_page.dart';
import 'package:budgetmeet/src/pages/create_event/select_eventName_page.dart';
import 'package:budgetmeet/src/pages/create_group/select_groupName_page.dart';
import 'package:budgetmeet/src/pages/create_group/search_user_page/provider/search_provider.dart';
import 'package:budgetmeet/src/pages/create_group/search_user_page/search_users_page.dart';
import 'package:budgetmeet/src/pages/drawer/theme_provider.dart';
import 'package:budgetmeet/src/pages/event/event_page.dart';
import 'package:budgetmeet/src/pages/event/event_provider.dart';

import 'package:budgetmeet/src/pages/group/group_page.dart';
import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:budgetmeet/providers/login_provider.dart';
import 'package:budgetmeet/providers/user_provider.dart';
import 'package:budgetmeet/src/pages/auth/login_page.dart';
import 'package:budgetmeet/src/pages/auth/register_page.dart';
import 'package:budgetmeet/src/pages/home/home_page.dart';
import 'package:budgetmeet/src/pages/settings/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/pages/landing/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final preferences = new UserPreference();
  await preferences.initPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<SearchUserProvider>(
          create: (context) => SearchUserProvider(),
        ),
        ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider(),
        ),
        ChangeNotifierProvider<DarkModeProvider>(
          create: (context) => DarkModeProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    Provider.of<DarkModeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: userPreference.darkMode ?? false ? themeDark : themeLight,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => LandingPage(),
        'home': (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'settings': (BuildContext context) => SettingsPage(),
        'newGroup': (BuildContext context) => SelectGroupNamePage(),
        'group': (BuildContext context) => GroupPage(),
        'search': (BuildContext context) => Search(),
        'eventdate': (BuildContext context) => SelectDatePage(),
        'select-event-name': (BuildContext context) => SelectEventNamePage(),
        'eventDescription': (BuildContext context) => SelectDescriptionPage(),
        'eventpage': (BuildContext context) => EventPage()
      },
    );
  }
}

final ThemeData themeLight = ThemeData(
  timePickerTheme: TimePickerThemeData(
      dialHandColor: Colors.orange,
      hourMinuteTextColor: Colors.orange,
      entryModeIconColor: Colors.orange),
  // Define el Brightness y Colores por defecto
  brightness: Brightness.light,
  primaryColor: Colors.white,
  shadowColor: Colors.orange,
  accentColor: Colors.black,
  selectedRowColor: Colors.orange,

  scaffoldBackgroundColor: Colors.white,
  // Define la Familia de fuente por defecto
  fontFamily: 'Montserrat',
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.orange),

  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.orange),
    iconTheme: IconThemeData(color: Colors.orange),
    textTheme: TextTheme(headline1: TextStyle(color: Colors.red)),
    elevation: 0,
    centerTitle: true,
  ),

  // Define el TextTheme por defecto. Usa esto para espicificar el estilo de texto por defecto
  // para cabeceras, títulos, cuerpos de texto, y más.
  textTheme: TextTheme(
    headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(
        fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.black),
  ),
);

final ThemeData themeDark = ThemeData(
  // Define el Brightness y Colores por defecto
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  accentColor: Colors.white,
  selectedRowColor: Colors.orange,

  scaffoldBackgroundColor: Colors.black,
  // Define la Familia de fuente por defecto
  fontFamily: 'Montserrat',
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.orange),

  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.orange),
    iconTheme: IconThemeData(color: Colors.orange),
    textTheme: TextTheme(headline1: TextStyle(color: Colors.red)),
    elevation: 0,
    centerTitle: true,
  ),

  // Define el TextTheme por defecto. Usa esto para espicificar el estilo de texto por defecto
  // para cabeceras, títulos, cuerpos de texto, y más.
  textTheme: TextTheme(
    headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(
        fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.black),
  ),
);
