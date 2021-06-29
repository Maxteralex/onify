

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'bus.page.dart';
import 'generated/l10n.dart';
import 'model/bus.dart';


class CreateBus extends StatefulWidget {
  @override
  _CreateBusState createState() => _CreateBusState();
}

class _CreateBusState extends State<CreateBus> {

  final _formKey = GlobalKey<FormState>();
  String plate;
  String brand;
  int busNumber;
  final busNumerController = TextEditingController();
  FlutterLocalNotificationsPlugin localNotification;
  //Validação e Salvamento na lista

  @override void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotifications() async {
    var androidDetails = new AndroidNotificationDetails("channelId", "Local Notification", "With localization ON, we can ", importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalNotifications = new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, "Bus created successfully!", "Bus added to your database!", generalNotifications);

  }

  void _salvarForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _showNotifications();
      Navigator.pop(
        context,
        Bus(plate: plate, brand: brand, busNumber: busNumber),
      );
    }
  }


//Buildar a Segunda tela referente ao cadastro do Novo Usuario
  @override
  Widget build(BuildContext context) {
    final Bus bus = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          textTheme: TextTheme(headline1: TextStyle(fontSize: 54.0, fontWeight: FontWeight.normal, fontFamily: 'Cinzel', decorationColor: Colors.blueGrey),
            headline6: TextStyle(fontStyle: FontStyle.normal, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),),
          title: Text(
            bus == null? S.of(context).createBus: S.of(context).editBus,
            style: TextStyle(color: Colors.white),

          ),
          leadingWidth: 90,
        ),
        body: SingleChildScrollView(child: SafeArea(
          minimum: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                ),
                TextFormField(
                    initialValue: bus == null ?  null : bus.plate,
                    onSaved: (val) => plate = val,
                    decoration: InputDecoration(
                      labelText: S.of(context).plate,
                      icon: Icon(
                        Icons.map,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Placa do veículo',
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return S.of(context).plateNull;
                      return null;
                    }),
                TextFormField(
                   initialValue: bus == null ? null : bus.brand,
                    onSaved: (val) => brand = val,
                    decoration: InputDecoration(
                      labelText: S.of(context).brand,
                      icon: Icon(
                        Icons.branding_watermark,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: 'Marca do veículo',
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) return S.of(context).branchNull;
                      return null;
                    }),
                TextFormField(
                    initialValue: bus == null ? null : bus.busNumber.toString(),
                    onSaved: (val) => busNumber = int.parse(val) ,
                    decoration: InputDecoration(
                      labelText: S.of(context).routeNumber,
                      icon: Icon(
                        Icons.branding_watermark,
                        color: Colors.black,
                        size: 24.0,
                        semanticLabel: S.of(context).routeNull,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    validator: (value) {
                      if (value.isEmpty) return S.of(context).routeNull;
                      return null;
                    }),
                Container(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _salvarForm,
                    label: Text(S.of(context).confirm),
                    icon: Icon(Icons.check),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}