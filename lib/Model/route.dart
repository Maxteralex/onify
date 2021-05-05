
import 'package:flutter_t1/Model/bus.dart';

class Route {
  String routeName;
  int routeNumber;
  List<Bus> buses;
  bool isActive;

  Route({this.routeName, this.routeNumber, this.buses, this.isActive});
}