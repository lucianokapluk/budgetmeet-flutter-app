import 'package:flutter/material.dart';

import 'package:budgetmeet/src/pages/create_group/search_user_page/provider/search_provider.dart';
import 'package:provider/provider.dart';

class UsersSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersSelectedList = Provider.of<SearchUserProvider>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: usersSelectedList.selectedUsers.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => usersSelectedList.removeFromListSelected =
                usersSelectedList.selectedUsers[index]['email'],
            child: Container(
              width: 70,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        usersSelectedList.selectedUsers[index]['photoURL']),
                  ),
                  Text(
                    usersSelectedList.selectedUsers[index]['displayName'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
