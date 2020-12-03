import 'dart:ui';

import 'package:budgetmeet/providers/login_provider.dart';
import 'package:budgetmeet/services/grups_bloc.dart';

import 'package:budgetmeet/src/pages/create_group/select_groupName_page.dart';
import 'package:budgetmeet/src/pages/drawer/custom_drawer.dart';
import 'package:budgetmeet/src/pages/utils/linear_gradient.dart';
import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    final logginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Groupos',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            iconSize: 30.0,
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: SelectGroupNamePage(),
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: logginProvider.loading
          ? Center(child: CircularProgressIndicator())
          : GroupsList(),
    );
  }
}

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userPreference = UserPreference();
    final Stream<QuerySnapshot> gruops =
        BlocGroups().getGroups(userPreference.uid);
    return StreamBuilder<QuerySnapshot>(
        stream: gruops,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'group',
                          arguments: snapshot.data.docs[index]),
                      child: Column(
                        children: [
                          GroupTile(groupDetails: snapshot.data.docs[index]),
                          Divider(
                            endIndent: 20,
                            indent: 20,
                            height: 1,
                            color: Colors.black45,
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('No estas en ningun grupo',
                    style: TextStyle(color: Colors.black)),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class GroupTile extends StatelessWidget {
  final DocumentSnapshot groupDetails;
  GroupTile({Key key, @required this.groupDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: linearCustomGradient(),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 27,
                  child: Icon(Icons.group_outlined),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupDetails['groupName'],
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text('Hay ${groupDetails['members'].length} miembros'),
              ],
            ),
          ],
        ),
      ),
    );

    /* Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          gradient: linearCustomGradient(),
        ),
        child: ListTile(
            title: Text(groupDetails['groupName'],
                style: TextStyle(
                  color: Colors.white,
                )),
            subtitle: Text('Hay ${groupDetails['members'].length} miembros'),
            leading: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.group_outlined),
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () =>
                Navigator.pushNamed(context, 'group', arguments: groupDetails)),
      ),
    ); */
  }
}
