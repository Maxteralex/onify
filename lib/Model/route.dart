
import 'package:flutter/cupertino.dart';
import 'package:flutter_t1/Model/bus.dart';
import 'package:flutter_t1/Model/bus.stop.dart';

class RouteModel extends ChangeNotifier{
  List<Route> _routes = [];

  void add(Route route) {
    _routes.add(route);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _routes.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}



class Route {
  String routeName;
  int routeNumber;
  List<BusStop> busStops;
  List<Bus> buses;

  Route({this.routeName, this.routeNumber, this.busStops, this.buses});
}
