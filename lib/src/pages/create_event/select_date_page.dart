import 'package:budgetmeet/services/grups_bloc.dart';
import 'package:budgetmeet/src/pages/create_event/select_descriptionEvent_page.dart';

import 'package:budgetmeet/src/pages/utils/button_decoration.dart';
import 'package:budgetmeet/src/pages/utils/format_date.dart';
import 'package:budgetmeet/src/pages/utils/linear_gradient.dart';
import 'package:flutter/material.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key key}) : super(key: key);

  @override
  _SelectDatePageState createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final ScreenArguments arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar fecha del evento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            EventTiles(
              eventName: arguments.eventName,
              description: arguments.eventDescription,
              date: selectedDate,
              time: selectedTime,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.calendar_today,
                          size: 35,
                          color: Colors.orange,
                        ),
                        onPressed: () => _selectDate(context)),
                    Text('Seleccionar fecha'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.watch_later_outlined,
                          size: 35,
                          color: Colors.orange,
                        ),
                        onPressed: () => _selectTime(context)),
                    Text('Seleccionar hora'),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: nextButton(context, selectedDate, selectedTime),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector nextButton(context, date, time) {
    final ScreenArguments event = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
        child: Container(
          width: double.infinity * 0.9,
          height: 40.0,
          alignment: Alignment.center,
          decoration: buttonDecoration(),
          child: textButton('Siguente'),
        ),
        onTap: () {
          BlocGroups().addEvents(event.groupId, {
            'eventName': event.eventName,
            'eventDescription': event.eventDescription,
            'eventDay': date.day.toString(),
            'eventMonth': date.month.toString(),
            'eventYear': date.year.toString(),
            'eventTime': time.format(context).toString(),
            'date': DateTime(
                date.year, date.month, date.day, time.hour, time.minute)
          }).then((value) =>
              Navigator.of(context).popUntil(ModalRoute.withName('group')));
        });
  }

  Future<void> _selectDate(BuildContext context) async {
/*     final groupPreference = new GroupPreference(); */
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2028));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
/*         groupPreference.date = picked.toString(); */
      });
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay timePicked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (timePicked != null && timePicked != selectedDate)
      setState(() {
        selectedTime = timePicked;
      });
  }
}

class EventTiles extends StatelessWidget {
  final String eventName;
  final String description;
  final DateTime date;
  final TimeOfDay time;

  EventTiles(
      {@required this.eventName, this.date, this.time, this.description});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(gradient: linearCustomGradient()),
              height: 50,
              width: double.maxFinite,
              child: Center(
                child: Text(
                  date.day.toString() +
                      ' DE ' +
                      formatMonthComplete(date.month),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                eventName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(description),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Colors.orange,
                  ),
                  Text(time.format(context) + 'hs'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
