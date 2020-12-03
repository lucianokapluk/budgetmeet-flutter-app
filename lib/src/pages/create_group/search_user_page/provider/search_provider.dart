import 'package:flutter/material.dart';

class SearchUserProvider with ChangeNotifier {
  List<dynamic> _selectedUsers = [];

  List<dynamic> get selectedUsers {
    return _selectedUsers;
  }

  set addToListSelected(value) {
    this._selectedUsers.add(value);
    notifyListeners();
  }

/* set cleasr(value) {
    this._selectedUsers.add(value);
    notifyListeners();
  } */
  clearList() {
    this._selectedUsers.clear();
    notifyListeners();
  }

  set removeFromListSelected(String email) {
    this._selectedUsers.removeWhere((item) => item['email'] == email);
    notifyListeners();
  }

  isInSelectedList(selectedUsers, email) {
    bool isUserSelected;
    selectedUsers.map(
      (user) {
        if (user['email'] == email) {
          isUserSelected = true;
        } else {
          isUserSelected = false;
        }
      },
    ).toList();
    return isUserSelected;
  }
}
