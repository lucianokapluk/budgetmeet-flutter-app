import 'package:animate_do/animate_do.dart';
import 'package:budgetmeet/providers/user_provider.dart';
import 'package:budgetmeet/services/grups_bloc.dart';
import 'package:budgetmeet/src/pages/create_group/search_user_page/provider/search_provider.dart';
import 'package:budgetmeet/src/pages/create_group/search_user_page/users_result_list.dart';
import 'package:budgetmeet/src/pages/create_group/search_user_page/users_selected_list.dart';

import 'package:budgetmeet/src/pages/utils/input_decoration.dart';

import 'package:flutter/material.dart';

import 'package:budgetmeet/services/users_blco.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Stream<QuerySnapshot> eventList;
  bool onTapLupa = false;
  @override
  void initState() {
    super.initState();
    BlocUsers().getUsers('').then((events) {
      setState(() {
        eventList = events;
      });
    });
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String groupName = ModalRoute.of(context).settings.arguments;
    final usersSelected = Provider.of<SearchUserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.of(context).pop();
              usersSelected.clearList();
            },
          ),
          actions: [
            IconButton(
                onPressed: () => setState(() {
                      if (onTapLupa) {
                        onTapLupa = false;
                      } else {
                        onTapLupa = true;
                      }
                    }),
                icon: Icon(
                  Icons.search_outlined,
                  size: 30.0,
                )),
          ],
          title: onTapLupa
              ? _searchInput()
              : Text(
                  'Elige los miembros del grupo',
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 16),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: OutlineButton(
          textColor: Colors.orange,
          borderSide: BorderSide(color: Colors.orange),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            createGroup(usersSelected, groupName);
            print('created');
          },
          child: Text('Crear Grupo'),
        ),
        body: Column(
          children: [
            usersSelected.selectedUsers.length > 0
                ? Container(
                    height: 100.0,
                    child: UsersSelected(),
                  )
                : SizedBox(),
            Expanded(
              child: UsersList(textSearchs: eventList),
            ),
          ],
        ));
  }

  createGroup(usersSelected, groupName) {
    String admin = Provider.of<UserProvider>(context, listen: false).uid;
    List ls = [];
    usersSelected.selectedUsers.forEach((e) => ls.add(e['uid']));

    BlocGroups().createGroup(admin, groupName, ls).then((value) {
      usersSelected.clearList();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
    });
  }

  Widget _searchInput() {
    return SlideInUp(
      duration: Duration(milliseconds: 300),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Container(
          color: Colors.amberAccent[50],
          child: TextFormField(
            decoration: inputDecoration('Nombre o email'),
            controller: searchController,
            onChanged: (text) {
              BlocUsers().getUsers(text).then((events) {
                setState(() {
                  eventList = events;
                });
              });
            },
          ),
        ),
      ),
    );
  }
}
