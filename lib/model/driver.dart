import 'package:flutter/cupertino.dart';


class DriverModel extends ChangeNotifier{
  List<Driver> _drivers = [];

  List<Driver> get drivers {
    return _drivers;
  }

  void add(Driver driver) {
    _drivers.add(driver);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _drivers.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

class Driver {
  String name;
  DateTime birthDate;
  String cpf;
  String driversLicenseType;
  String civilState;
  String sex;

  Driver({this.name, this.birthDate, this.cpf, this.driversLicenseType, this.civilState,this.sex});
}