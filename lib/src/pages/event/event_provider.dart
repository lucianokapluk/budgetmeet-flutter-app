import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  TabController _tabEventController;

  TabController get tabEventController {
    return _tabEventController;
  }

  set tabEventController(TabController value) {
    this._tabEventController = value;
  }
}
