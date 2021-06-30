
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onify_app/api_connection/route_connection.dart';
import 'bus.dart';

class RouteModel extends ChangeNotifier{
  List<Route> _routes = [];
  // [
  //   Route(routeName: 'Lagoa-Barra', routeNumber: 1),
  //   Route(routeName: 'Rio-Niteroi', routeNumber: 2),
  //   Route(routeName: 'Copacabana-Ipanema', routeNumber: 3),
  //   Route(routeName: 'Centro', routeNumber: 4),
  // ];

  Future<void> prepareList() async {
    _routes = await getRoutes();
  }

  Future <List<Route>> get routes async {
    await prepareList();
    return _routes;
  }

  Future<List> getRoutes1() async {
    return await getRoutes();
  }

  void add(String routeName, int routeNumber) async {
    Map<String, dynamic> routeJson = {
      'name': routeName,
      'route_number': routeNumber
    };
    try {
      Route route = await createRoute(routeJson);
      _routes.add(route);
    } catch(except, trace) {
      print(trace.toString());
    }
    notifyListeners();
  }

  void removeAt(int index) async{
    Route route = _routes.elementAt(index);
    try {
      await deleteRoute(route);
      _routes.removeAt(index);
    } catch (except, trace) {
      print(trace.toString());
    }
    notifyListeners();
  }

  void removeAll() {
    _routes.clear();
    notifyListeners();
  }

}

class Route {
  String routeName;
  int routeNumber;
  int routeId;
  Set<Marker> busStops = {};
  List<Bus> buses = [];

  Route({this.routeName, this.routeNumber, this.routeId});

  String getRouteName() {
    return routeName;
  }

  int getRouteNumber() {
    return routeNumber;
  }

  int getRouteId() {
    return routeId;
  }

  void updateRouteAttrs(String routeName, int routeNumber) {
    try {
      Map<String, dynamic> routeJson = {
        'name': routeName,
        'route_number': routeNumber
      };
      updateRoute(this, routeJson);
    } catch(exception, trace) {
      print(trace.toString());
    }
  }

  void setRouteName(String routeName) {
    this.routeName = routeName;
  }

  void setRouteNumber(int routeNumber) {
    this.routeNumber = routeNumber;
  }

  Set<Marker> getBusStops() {
    print(busStops);
    return busStops;
  }

  void addBusStop(Marker marker) {
    busStops.add(marker);
  }

  void addAllBusStops(List<Marker> markers) {
    busStops.addAll(markers);
  }

  void removeBusStop(Marker marker) {
    busStops.remove(marker);
  }

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
        routeName: json['name'],
        routeNumber: json['route_number'],
        routeId: json['route_id']
    );
  }

  Map<String, dynamic> toJson() => {
    "name": this.routeName,
    "route_number": this.routeNumber,
  };

}
