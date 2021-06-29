import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onify_app/model/route.dart';

final _baseURL = "onify-rest.herokuapp.com";
final _viewEndpoint = "rest_api/route/view";
final _createEndpoint = "rest_api/route/create";
final _updateEndpoint = "rest_api/route/update/";
final _deleteEndpoint = "rest_api/route/delete/";

Future<List<Route>> getRoutes() async {
  final http.Response response = await http.get(
      Uri.https(_baseURL, _viewEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );
  if (response.statusCode == 200) {
    final routesJson = json.decode(response.body);
    print(json.decode(response.body).toString());
    List<Route> routes = [];
    for (final routeJson in routesJson) {
      routes.add(Route.fromJson(routeJson));
    }
    return routes;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Route> createRoute(Map<String, dynamic> routeJson) async {
  final http.Response response = await http.post(
    Uri.https(_baseURL, _createEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(routeJson),
  );
  if (response.statusCode == 200) {
    Route route = Route.fromJson(json.decode(response.body));
    print(route.toString());
    return route;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<void> updateRoute(Route route, Map<String, dynamic> updateRouteJson) async {
  final http.Response response = await http.post(
    Uri.https(_baseURL, _updateEndpoint + route.getRouteId().toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updateRouteJson),
  );
  if (response.statusCode == 200) {
    route.setRouteName(updateRouteJson['name']);
    route.setRouteNumber(updateRouteJson['route_number']);
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<void> deleteRoute(Route route) async {
  final http.Response response = await http.get(
    Uri.https(_baseURL, _deleteEndpoint + route.getRouteId().toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
  if (response.statusCode != 200) {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}