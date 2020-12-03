import 'package:budgetmeet/src/pages/create_group/search_user_page/provider/search_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  final Stream<QuerySnapshot> textSearchs;
  UsersList({this.textSearchs});
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.textSearchs,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Wrap(children: [
                    UserTile(userDetails: snapshot.data.docs[index])
                  ]);
                });
          } else {
            print('aasdasds${snapshot.connectionState}');
            return Center(child: Text('No se encontraron usuarios'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class UserTile extends StatelessWidget {
  final DocumentSnapshot userDetails;
  UserTile({@required this.userDetails});

  @override
  Widget build(BuildContext context) {
    var usersSelectedList = Provider.of<SearchUserProvider>(context);

    return ListTile(
      onTap: () {
        bool isUserSelected = usersSelectedList.isInSelectedList(
            usersSelectedList.selectedUsers, userDetails['email']);

        if (isUserSelected == true) {
          usersSelectedList.removeFromListSelected = userDetails['email'];
        } else {
          usersSelectedList.addToListSelected = userDetails;
        }
      },
      title: Text(userDetails['displayName']),
      leading:
          CircleAvatar(backgroundImage: NetworkImage(userDetails['photoURL'])),
    );
  }
}
