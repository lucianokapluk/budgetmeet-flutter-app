import 'package:budgetmeet/src/pages/utils/button_decoration.dart';
import 'package:budgetmeet/src/pages/utils/input_decoration.dart';
import 'package:flutter/material.dart';

class SelectGroupNamePage extends StatefulWidget {
  static final String routeName = 'newGroup';

  @override
  _SelectGroupNamePageState createState() => _SelectGroupNamePageState();
}

class _SelectGroupNamePageState extends State<SelectGroupNamePage> {
  TextEditingController groupNameControlleer = TextEditingController();

  String inputText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear nuevo grupo',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: selectGroupName(context),
    );
  }

  Widget selectGroupName(context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Text(
                'Selecciona el nombre del grupo',
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: groupNameControlleer,
              maxLength: 25,
              decoration: inputDecoration('Nombre del grupo'),
              onChanged: (text) => {
                setState(() {
                  inputText = text;
                })
              },
            ),
            SizedBox(
              height: 20,
            ),
            inputText.length > 0 && inputText.length < 26
                ? nextButton(context)
                : nextDisableButton(),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Container nextDisableButton() {
    return Container(
        width: double.infinity * 0.9,
        height: 40.0,
        alignment: Alignment.center,
        decoration: buttonDecorationDisabled(),
        child: textButton('Siguente'));
  }

  GestureDetector nextButton(context) {
    return GestureDetector(
      child: Container(
        width: double.infinity * 0.9,
        height: 40.0,
        alignment: Alignment.center,
        decoration: buttonDecoration(),
        child: textButton('Siguente'),
      ),
      onTap: () => Navigator.pushNamed(context, 'search',
          arguments: groupNameControlleer.text),
    );
  }
}
