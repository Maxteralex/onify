
import 'package:flutter/cupertino.dart';

import 'driver.dart';

class BusModel extends ChangeNotifier{
  List<Bus> _buses = [];

  List<Bus> get buses {
    return _buses;
  }

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

  Map <String, dynamic> toDatabaseJson() => {
    "brand": this.brand,
    "plate": this.plate,
    "bus_number": this.busNumber,
  };

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      brand: json['brand'],
      plate: json['plate'],
      busNumber: json['bus_number'],
    );
  }

  // factory Bus.multipleFromJson(Map<String, dynamic> json) {
  //   List<Bus> buses
  //   return Bus(
  //     brand: json['brand'],
  //     plate: json['plate'],
  //     busNumber: json['bus_number'],
  //   );
  // }
}