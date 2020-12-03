import 'package:budgetmeet/services/grups_bloc.dart';
import 'package:budgetmeet/src/pages/utils/input_decoration.dart';

import 'package:budgetmeet/src/preferences/user_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ChatTab extends StatelessWidget {
  final String groupId;
  ChatTab({Key key, this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ChatList(groupIds: groupId)),
          InputMessageChat(groupid: groupId),
        ],
      ),
    );
  }
}

class InputMessageChat extends StatelessWidget {
  final String groupid;
  InputMessageChat({Key key, this.groupid});

  final userPreference = UserPreference();

  @override
  Widget build(BuildContext context) {
    final TextEditingController inputTextMessage = new TextEditingController();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: inputTextMessage,
                  decoration: inputDecorationIcon(
                    'Escribir un mensaje...',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final lastUser = await BlocGroups().getLastChat(groupid);
                  if (inputTextMessage.text != '') {
                    if (lastUser != 0) {
                      if (lastUser == userPreference.uid) {
                        BlocGroups().addMessage(groupid, {
                          'user': '',
                          'uid': userPreference.uid,
                          'text': inputTextMessage.text,
                          'type': 'message',
                          'created': DateTime.now()
                        });
                        inputTextMessage.text = '';
                      } else {
                        BlocGroups().addMessage(groupid, {
                          'user': userPreference.displayName,
                          'uid': userPreference.uid,
                          'text': inputTextMessage.text,
                          'type': 'message',
                          'created': DateTime.now()
                        });
                        inputTextMessage.text = '';
                      }
                    }
                  } else {
                    inputTextMessage.text = '';
                  }
                },
                icon: Icon(Icons.done),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final String groupIds;
  ChatList({Key key, this.groupIds});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> chatsList = BlocGroups().getChats(groupIds);
    return StreamBuilder<QuerySnapshot>(
      stream: chatsList,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.connectionState);
          return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot message = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BubleMessage(
                      text: message['text'],
                      user: message['user'],
                      uid: message['uid'],
                      type: message['type'],
                      created: message['created']),
                );
              });
        } else {
          print(snapshot.connectionState);
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class BubleMessage extends StatefulWidget {
  final Timestamp created;
  final String text;
  final String type;
  final String uid;
  final String user;

  BubleMessage(
      {Key key, this.created, this.text, this.type, this.uid, this.user});

  @override
  _BubleMessageState createState() => _BubleMessageState();
}

class _BubleMessageState extends State<BubleMessage> {
  final userPreference = UserPreference();
  String hour;
  @override
  void initState() {
    super.initState();
    var createdPars =
        DateTime.parse(widget.created.toDate().toString()).toString();
    List split = createdPars.split(" ");
    hour = split[1].substring(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'info') {
      return BubleCenter(text: widget.text, user: widget.user);
    }
    if (widget.uid == userPreference.uid) {
      return Buble(
        text: widget.text,
        user: widget.user,
        hour: hour,
        mainAxis: MainAxisAlignment.end,
      );
    } else {
      return Buble(
        text: widget.text,
        user: widget.user,
        hour: hour,
        mainAxis: MainAxisAlignment.start,
      );
    }
  }
}

class BubleCenter extends StatelessWidget {
  final DateTime created;
  final String text;
  final String type;
  final String uid;
  final String user;
  BubleCenter(
      {Key key, this.created, this.text, this.type, this.uid, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        user,
        style: TextStyle(color: Colors.orange),
      ),
      Text(text)
    ]);
  }
}

class Buble extends StatelessWidget {
  final String hour;
  final String text;
  final String type;
  final String uid;
  final String user;

  final mainAxis;
  Buble(
      {Key key,
      this.hour,
      this.text,
      this.type,
      this.uid,
      this.user,
      this.mainAxis});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: mainAxis,
        children: [
          Container(
            constraints: BoxConstraints(minWidth: 25.0),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                user != ''
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            user,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    : SizedBox(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.90),
                      child: Text(text,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      hour,
                      style: TextStyle(color: Colors.blueGrey, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
