
import 'package:flutter/cupertino.dart';

import 'driver.dart';

class BusModel extends ChangeNotifier{
  List<Bus> _buses = [];

  void add(Bus bus) {
    _buses.add(bus);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _buses.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}


class Bus {
  String brand;
  String plate;
  int busNumber;

  Bus({this.brand, this.plate, this.busNumber});
}