import 'package:budgetmeet/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  static final String routeName = 'login';
  @override
  Widget build(BuildContext context) {
    final logginProvider = Provider.of<LoginProvider>(context);
    final textSizeStyle =
        TextStyle(fontSize: 25, color: Theme.of(context).accentColor);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: logginProvider.loading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ))
          : ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image.asset(
                    'assets/icon/budIcon.png',
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                Text('BudgetMeet',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center),
                SizedBox(height: 50.0),
                _loginButton(textSizeStyle, context, logginProvider),
                /*       Image.asset(
                  "assets/mett.gif",
                  height: 205.0,
                  width: 205.0,
                ), */
              ],
            ),
    );
  }

  /*  TextField userInput(TextStyle textSizeStyle) {
    return TextField(
      style: textSizeStyle,
      decoration: InputDecoration(
        icon: Icon(
          Icons.person_outline_outlined,
          size: 35.0,
          color: Colors.purpleAccent,
        ),
        labelText: 'Usuario',
        focusColor: Colors.red,
      ),
    );
  }

  TextField passwordInput(TextStyle textSizeStyle) {
    return TextField(
      style: textSizeStyle,
      decoration: InputDecoration(
        icon: Icon(
          Icons.vpn_key_outlined,
          size: 35.0,
          color: Colors.purpleAccent,
        ),
        labelText: 'Password',
      ),
    );
  }*/
}

Widget _loginButton(textSizeStyle, context, islogged) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      OutlineButton(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        onPressed: () {
          islogged.login();
        },
        splashColor: Colors.deepPurple[50],
        child: Container(
          child: Row(
            children: [
              Text(
                'Entrar con Google',
                style: textSizeStyle,
              ),
              SizedBox(
                width: 10,
              ),
              Image.asset(
                'assets/google.png',
                height: 30,
                width: 30,
              ),
            ],
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    ],
  );
}
