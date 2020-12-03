import 'package:budgetmeet/src/pages/event/event_provider.dart';
import 'package:budgetmeet/src/pages/event/tabs/bought_tab.dart';
import 'package:budgetmeet/src/pages/event/tabs/resume_tab.dart';

import 'package:budgetmeet/src/pages/event/tabs/toBuy_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  static final routeName = 'eventpage';
  final int selectedPage;
  final String eventId;
  final eventName;
  final String groupId;
  EventPage(
      {Key key, this.eventId, this.groupId, this.selectedPage, this.eventName});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  @override
  void initState() {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    eventProvider.tabEventController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
        bottom: TabBar(
          controller: eventProvider.tabEventController,
          indicatorColor: Theme.of(context).selectedRowColor,
          tabs: [
            Tab(
              text: 'Comprar',
            ),
            Tab(
              text: 'Comprado',
            ),
            Tab(
              text: 'Resumen',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: eventProvider.tabEventController,
        children: [
          ListOfProducts(
            eventId: widget.eventId,
            groupId: widget.groupId,
          ),
          ListOfProductsBought(
            eventId: widget.eventId,
            groupId: widget.groupId,
          ),
          ResumeTab(
            eventId: widget.eventId,
            groupId: widget.groupId,
          )
        ],
      ),
    );
  }
}
