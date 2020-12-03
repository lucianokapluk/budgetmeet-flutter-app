import 'package:budgetmeet/services/grups_bloc.dart';

import 'package:budgetmeet/src/pages/event/event_page.dart';
import 'package:budgetmeet/src/pages/event/widgets/total_price.dart';
import 'package:budgetmeet/src/pages/utils/format_date.dart';
import 'package:budgetmeet/src/pages/utils/linear_gradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ListOfEvents extends StatelessWidget {
  final String groupId;
  ListOfEvents({Key key, this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, 'select-event-name',
              arguments: groupId),
          child: Icon(Icons.add),
        ),
        body: EventsList(groupIds: groupId));
  }
}

class EventsList extends StatelessWidget {
  final String groupIds;
  EventsList({Key key, this.groupIds});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> eventList = BlocGroups().getEvents(groupIds);
    return StreamBuilder<QuerySnapshot>(
      stream: eventList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: EventTile(
                        eventDetails: snapshot.data.docs[index],
                        groupId: groupIds),
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: EventPage(
                            eventId: snapshot.data.docs[index].id,
                            eventName: snapshot.data.docs[index]['eventName'],
                            groupId: groupIds),
                      ),
                    ),
                  );
                });
          } else {
            print('aasdasds${snapshot.connectionState}');
            return Center(child: Text('No tienes eventos'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class EventTile extends StatelessWidget {
  final DocumentSnapshot eventDetails;
  final String groupId;
  EventTile({Key key, @required this.eventDetails, this.groupId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
                gradient: linearCustomGradient(),
              ),
              height: 76.0,
              width: 76.0,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    eventDetails['eventDay'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatMonth(eventDetails['eventMonth']),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventDetails['eventName'],
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 50.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                eventDetails['eventDescription'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            TotalPrice(
                              groupId: groupId,
                              eventId: eventDetails.id,
                              fontSize: 15.0,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Icon(Icons.watch_later_outlined),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(eventDetails['eventTime'] + ' hs')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
