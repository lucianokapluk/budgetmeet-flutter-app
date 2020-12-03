import 'package:budgetmeet/src/pages/create_event/select_eventName_page.dart';
import 'package:budgetmeet/src/pages/utils/button_decoration.dart';
import 'package:budgetmeet/src/pages/utils/input_decoration.dart';
import 'package:flutter/material.dart';

class SelectDescriptionPage extends StatefulWidget {
  static final String routeName = 'select-event-name';

  @override
  _SelectDescriptionPageState createState() => _SelectDescriptionPageState();
}

class _SelectDescriptionPageState extends State<SelectDescriptionPage> {
  TextEditingController eventNameController = TextEditingController();
  String inputText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Descripcion del evento',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: typeDescriptionEvent(context),
    );
  }

  Widget typeDescriptionEvent(context) {
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
                'Escribe una breve descripcion del evento',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            TextFormField(
              controller: eventNameController,
              maxLength: 200,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              decoration: inputDecoration('Descripcion del evento'),
              onChanged: (text) => {
                setState(() {
                  inputText = text;
                })
              },
            ),
            SizedBox(
              height: 20,
            ),
            inputText.length > 0 && inputText.length < 200
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
    final EventArgument event = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
      child: Container(
        width: double.infinity * 0.9,
        height: 40.0,
        alignment: Alignment.center,
        decoration: buttonDecoration(),
        child: textButton('Siguente'),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        'eventdate',
        arguments: ScreenArguments(
            event.groupId, event.eventName, eventNameController.text),
      ),
    );
  }
}

class ScreenArguments {
  final String groupId;
  final String eventName;
  final String eventDescription;

  ScreenArguments(this.groupId, this.eventName, this.eventDescription);
}
