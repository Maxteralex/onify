import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'driver.page.dart';
import 'model/driver.dart';
import 'route.page.dart';
import 'bus.page.dart';
import 'map.page.dart';
import 'model/bus.dart';
import 'model/bus.stop.dart';
import 'model/route.dart';

Widget navigationBar(BuildContext context, int selectedIndex) {
  double bottomBarHeight = 75; // set bottom bar height
  bool _show = true;

  void _onItemTapped(int index) {
    if (selectedIndex != index) {
      // Navigator.pop(context);
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/');
          break;
        case 1:
          Navigator.pushNamed(context, '/bus');
          break;
        case 2:
          Navigator.pushNamed(context, '/driver');
          break;
        case 3:
          Navigator.pushNamed(context, '/route');
          break;
      }
      selectedIndex = index;
    }
  }

  return Container(
    height: bottomBarHeight,
    width: MediaQuery.of(context).size.width,
    child: _show
        ? BottomNavigationBar(
            backgroundColor: Colors.blueGrey,
            currentIndex: selectedIndex,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.lightGreenAccent,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.map),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.directions_bus_outlined),
                label: 'Bus',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                label: 'Driver',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_road), label: 'Route'),
            ],
            onTap: _onItemTapped,
          )
        : Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
          ),
  );
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BusStopModel()),
      ChangeNotifierProvider(create: (context) => RouteModel()),
      ChangeNotifierProvider(create: (context) => BusModel()),
      ChangeNotifierProvider(create: (context) => DriverModel()),
    ],
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/bus': (context) => Bus(),
        '/driver': (context) => Driver(),
        '/route': (context) => Route(),
      },
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(context, selectedIndex),
      body: MapPage(),
    );
  }
}

class Bus extends StatefulWidget {
  @override
  _BusState createState() => _BusState();
}

class _BusState extends State<Bus> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(context, selectedIndex),
      body: BusPage(),
    );
  }
}

class Driver extends StatefulWidget {
  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(context, selectedIndex),
      body: DriverPage(),
    );
  }
}

class Route extends StatefulWidget {
  @override
  _RouteState createState() => _RouteState();
}

class _RouteState extends State<Route> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: navigationBar(context, selectedIndex),
      body: RoutePage(),
    );
  }
}
