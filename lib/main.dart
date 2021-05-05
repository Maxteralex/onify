import 'package:flutter/material.dart';
import 'package:flutter_t1/map.page.dart';
import 'package:flutter_t1/route.page.dart';

Widget navigationBar(BuildContext context) {
  double bottomBarHeight = 75; // set bottom bar height
  bool _show = true;
  
  return Container(
    height: bottomBarHeight,
    width: MediaQuery.of(context).size.width,
    child: _show
        ?BottomNavigationBar(
      currentIndex: 2,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.directions_bus_outlined),
          label: 'Bus',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.person),
          label: 'Driver',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_road), label: 'Route'),
      ],
    )
        : Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
    ),
  );
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      // '/routes/': (context) => RoutePage(),
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(context),
      body: MapPage(),
    );
  }
}

class Route extends StatefulWidget {
  @override
  _RouteState createState() => _RouteState();
}

class _RouteState extends State<Route> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(context),
      body: RoutePage(),
    );
  }
}

