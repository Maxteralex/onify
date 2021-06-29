

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'generated/l10n.dart';
import 'model/driver.dart';


class CreateDriver extends StatefulWidget {
  @override
  _CreateDriverState createState() => _CreateDriverState();
}

class _CreateDriverState extends State<CreateDriver> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String cpf;
  String driversLicenseType;
  String civilState;
  String sex;
  TextEditingController _dataNewDriver = TextEditingController();
  DateTime dtSelected = DateTime.now();

  //Validação e Salvamento na lista
  FlutterLocalNotificationsPlugin localNotification;
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
    await localNotification.show(0, 'Driver created successfully!', "Driver added to database!", generalNotifications);

  }
  void _salvarForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _showNotifications();
      Navigator.pop(
        context,
        Driver(name: name, birthDate: dtSelected, cpf: cpf, driversLicenseType: driversLicenseType, civilState: civilState, sex: sex ),
      );
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime choosed = await showDatePicker(
        context: context,
        initialDate: dtSelected,
        firstDate: DateTime.utc(1900),
        lastDate: DateTime.now());
    if (choosed != null && choosed != dtSelected)
      setState(() {
        dtSelected = choosed;
        var date =
            "${choosed.toLocal().day}/${choosed.toLocal().month}/${choosed.toLocal().year}";
        _dataNewDriver.text = date;
      });
  }

//Buildar a Segunda tela referente ao cadastro do Novo Usuario
  @override
  Widget build(BuildContext context) {
    final Driver driver = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            driver == null? S.of(context).addDriver: S.of(context).editDriver,
            style: TextStyle(color: Colors.white),
          ),
          leadingWidth: 90,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "${S.of(context).cancel}",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
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
                    initialValue: driver == null ?  null : driver.name,
                    onSaved: (val) => name = val,
                    decoration: InputDecoration(
                      labelText: '${S.of(context).name}',
                      icon: Icon(
                        Icons.person_add,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) return "${S.of(context).nameNull}";
                      return null;
                    }),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      onSaved: (val) {
                        dtSelected = dtSelected;
                      },
                      controller: _dataNewDriver,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "${S.of(context).birthDate}",
                        icon: Icon(
                          Icons.celebration,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty)
                          return "${S.of(context).birthNull}";
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [

                    Expanded(child: TextFormField(
                      initialValue: driver == null ? null : driver.cpf,
                      onSaved: (val) => cpf = val,
                      decoration: InputDecoration(
                        labelText: '${S.of(context).cpf}',
                        icon: Icon(
                          Icons.assignment_turned_in,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value.isEmpty || value.length != 11) return "${S.of(context).cpf}";
                        return null;
                      }),),
                    Expanded(child: TextFormField(
                        initialValue: driver == null ? null : driver.driversLicenseType,
                        onSaved: (val) => driversLicenseType = val ,
                        decoration: InputDecoration(
                          labelText: '${S.of(context).driverLicense}',
                          icon: Icon(
                            Icons.account_balance_wallet,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^[A-F]$')),
                        ],
                        validator: (value) {
                          if (value.length != 1) return "${S.of(context).licenseNull}";
                          return null;
                        }),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextFormField(
                      initialValue: driver == null ? null : driver.civilState,
                      onSaved: (val) => civilState = val,
                      decoration: InputDecoration(
                        labelText: '${S.of(context).civilStatus}',
                        icon: Icon(
                          Icons.supervisor_account_sharp,
                          color: Colors.black,
                          size: 24.0,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) return "${S.of(context).civilNull}";
                        return null;
                      }),),
                    Expanded(child: TextFormField(
                        initialValue: driver == null ? null : driver.sex,
                        onSaved: (val) => sex = val,
                        decoration: InputDecoration(
                          labelText: '${S.of(context).gender}',
                          icon: Icon(
                            Icons.add_circle_outline_outlined,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^[MFO]$')),
                        ],
                        validator: (value) {
                          if (value.isEmpty) return "${S.of(context).genderNull}";
                          return null;
                        }),),
                  ],
                ),
                Container(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _salvarForm,
                    label: Text('${S.of(context).confirm}'),
                    icon: Icon(Icons.check),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}