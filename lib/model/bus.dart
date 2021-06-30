import 'package:flutter/cupertino.dart';
import 'package:onify_app/api_connection/bus_connection.dart';

class BusModel extends ChangeNotifier{
  List<Bus> _buses = [];

  void prepareList() async {
    _buses = await getBuses();
  }

  List<Bus> get buses {
    prepareList();
    return _buses;
  }

  void add(String brand, String plate, int busNumber) async {
    Map<String, dynamic> busJson = {
      'brand': brand,
      'plate': plate,
      'bus_number': busNumber
    };
    try {
      Bus bus = await createBus(busJson);
      _buses.add(bus);
    } catch(except, trace) {
      print(trace.toString());
    }
    notifyListeners();
  }

  void removeAt(int index) async{
    Bus bus = _buses.elementAt(index);
    try {
      await deleteBus(bus);
      _buses.removeAt(index);
    } catch (except, trace) {
      print(trace.toString());
    }
    notifyListeners();
  }

  void removeAll() {
    _buses.clear();
    notifyListeners();
  }
}


class Bus {
  String brand;
  String plate;
  int busNumber;
  int busId;

  Bus({this.brand, this.plate, this.busNumber, this.busId});

  String getBusBrand() {
    return brand;
  }

  String getBusPlate() {
    return plate;
  }

  int getBusNumber() {
    return busNumber;
  }

  int getBusId() {
    return busId;
  }

  void setBusBrand(String brand) {
    this.brand = brand;
  }

  void setBusPlate(String plate) {
    this.plate = plate;
  }

  void setBusNumber(int busNumber) {
    this.busNumber = busNumber;
  }

  void updateBusAttrs(String brand, String plate, int busNumber) async{
    try {
      Map<String, dynamic> busJson = {
        'brand': brand,
        'plate': plate,
        'bus_number': busNumber,
      };
      await updateBus(this, busJson);
    } catch(exception, trace) {
      print(trace.toString());
    }
  }

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      brand: json['brand'],
      plate: json['plate'],
      busNumber: json['bus_number'],
      busId: json['bus_id'],
    );
  }

  Map <String, dynamic> toJson() => {
    "brand": this.brand,
    "plate": this.plate,
    "bus_number": this.busNumber,
  };
}