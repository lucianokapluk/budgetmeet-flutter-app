import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'chat_tab.dart';
import 'events_list_tab.dart';

class GroupPage extends StatelessWidget {
  static final routeName = 'group';

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot groupDetails =
        ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(groupDetails['groupName']),
          bottom: TabBar(
            indicatorColor: Theme.of(context).selectedRowColor,
            tabs: [
              Tab(text: 'Eventos'),
              Tab(
                text: 'Chat',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListOfEvents(groupId: groupDetails['id']),
            ChatTab(groupId: groupDetails['id']),
          ],
        ),
      ),
    );
  }
}
