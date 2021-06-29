import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onify_app/model/bus.dart';

// final _protocol = "https://";
final _baseURL = "onify-rest.herokuapp.com/";
final _createEndpoint = "/bus/create/";
// final _tokenURL = _protocol + _base + _tokenEndpoint;

// Future<List<Bus>> getBuses() async {
//   final http.Response response = await http.post(
//     Uri.https(_baseURL, _createEndpoint),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     }
//   );
//   if (response.statusCode == 200) {
//     print(json.decode(response.body).toString());
//     return Bus.multipleFromJson(json.decode(response.body));
//   } else {
//     print(json.decode(response.body).toString());
//     throw Exception(json.decode(response.body));
//   }
// }

// Future<Bus> createBus() async {
//   final http.Response response = await http.post(
//     Uri.https(_baseURL, _createEndpoint),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(Bus.toDatabaseJson()),
//   );
//   if (response.statusCode == 200) {
//     return Token.fromJson(json.decode(response.body));
//   } else {
//     print(json.decode(response.body).toString());
//     throw Exception(json.decode(response.body));
//   }
// }
//
// Future<Bus> updateBus() async {
//   final http.Response response = await http.post(
//     Uri.https(_baseURL, _createEndpoint),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(userLogin.toDatabaseJson()),
//   );
//   if (response.statusCode == 200) {
//     return Token.fromJson(json.decode(response.body));
//   } else {
//     print(json.decode(response.body).toString());
//     throw Exception(json.decode(response.body));
//   }
// }
//
// Future deleteBus() async {
//   final http.Response response = await http.post(
//     Uri.https(_baseURL, _createEndpoint),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(userLogin.toDatabaseJson()),
//   );
//   if (response.statusCode == 200) {
//     return Token.fromJson(json.decode(response.body));
//   } else {
//     print(json.decode(response.body).toString());
//     throw Exception(json.decode(response.body));
//   }
// }