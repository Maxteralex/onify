import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_t1/map.page.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _show = true;
  double bottomBarHeight = 75; // set bottom bar height


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: bottomBarHeight,
        width: MediaQuery.of(context).size.width,
        child: _show
            ?BottomNavigationBar(
          currentIndex: 2, // this will be set when a new tab is tapped
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
      ),

      body: MapPage(),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

