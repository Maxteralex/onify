import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onify_app/model/bus.dart';

final _baseURL = "onify-rest.herokuapp.com";
final _viewEndpoint = "rest_api/bus/view";
final _createEndpoint = "rest_api/bus/create";
final _updateEndpoint = "rest_api/bus/update/";
final _deleteEndpoint = "rest_api/bus/delete/";

Future<List<Bus>> getBuses() async {
  final http.Response response = await http.get(
      Uri.https(_baseURL, _viewEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );
  if (response.statusCode == 200) {
    final busesJson = json.decode(response.body);
    print(json.decode(response.body).toString());
    List<Bus> buses = [];
    for (final busJson in busesJson) {
      buses.add(Bus.fromJson(busJson));
    }
    return buses;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<Bus> createBus(Map<String, dynamic> busJson) async {
  final http.Response response = await http.post(
    Uri.https(_baseURL, _createEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(busJson),
  );
  if (response.statusCode == 200) {
    Bus bus = Bus.fromJson(json.decode(response.body));
    print(bus.toString());
    return bus;
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<void> updateBus(Bus bus, Map<String, dynamic> updateBusJson) async {
  final http.Response response = await http.post(
    Uri.https(_baseURL, _updateEndpoint + bus.getBusId().toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updateBusJson),
  );
  if (response.statusCode == 200) {
    bus.setBusBrand(updateBusJson['brand']);
    bus.setBusPlate(updateBusJson['plate']);
    bus.setBusNumber(updateBusJson['bus_number']);
  } else {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}

Future<void> deleteBus(Bus bus) async {
  final http.Response response = await http.get(
      Uri.https(_baseURL, _deleteEndpoint + bus.getBusId().toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
  );
  if (response.statusCode != 200) {
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}