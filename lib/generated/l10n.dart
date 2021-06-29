// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Bus List`
  String get busTitle {
    return Intl.message(
      'Bus List',
      name: 'busTitle',
      desc: '',
      args: [],
    );
  }

  /// `Plate`
  String get plate {
    return Intl.message(
      'Plate',
      name: 'plate',
      desc: '',
      args: [],
    );
  }

  /// `the bus belongs to the route`
  String get routeBelongs {
    return Intl.message(
      'the bus belongs to the route',
      name: 'routeBelongs',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Route Number`
  String get routeNumber {
    return Intl.message(
      'Route Number',
      name: 'routeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Create Bus`
  String get createBus {
    return Intl.message(
      'Create Bus',
      name: 'createBus',
      desc: '',
      args: [],
    );
  }

  /// `Edit Bus`
  String get editBus {
    return Intl.message(
      'Edit Bus',
      name: 'editBus',
      desc: '',
      args: [],
    );
  }

  /// `Please add your plate!`
  String get plateNull {
    return Intl.message(
      'Please add your plate!',
      name: 'plateNull',
      desc: '',
      args: [],
    );
  }

  /// `Please add your vehicle branch!`
  String get branchNull {
    return Intl.message(
      'Please add your vehicle branch!',
      name: 'branchNull',
      desc: '',
      args: [],
    );
  }

  /// `Please add your vehicle route!`
  String get routeNull {
    return Intl.message(
      'Please add your vehicle route!',
      name: 'routeNull',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Driver's List`
  String get driverTitle {
    return Intl.message(
      'Driver\'s List',
      name: 'driverTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name:`
  String get name {
    return Intl.message(
      'Name:',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date:`
  String get birthDate {
    return Intl.message(
      'Birth Date:',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `CPF`
  String get cpf {
    return Intl.message(
      'CPF',
      name: 'cpf',
      desc: '',
      args: [],
    );
  }

  /// `Civil Status`
  String get civilStatus {
    return Intl.message(
      'Civil Status',
      name: 'civilStatus',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Driver's license`
  String get driverLicense {
    return Intl.message(
      'Driver\'s license',
      name: 'driverLicense',
      desc: '',
      args: [],
    );
  }

  /// `Add Driver`
  String get addDriver {
    return Intl.message(
      'Add Driver',
      name: 'addDriver',
      desc: '',
      args: [],
    );
  }

  /// `Edit Driver`
  String get editDriver {
    return Intl.message(
      'Edit Driver',
      name: 'editDriver',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the driver's name!`
  String get nameNull {
    return Intl.message(
      'Please enter the driver\'s name!',
      name: 'nameNull',
      desc: '',
      args: [],
    );
  }

  /// `Please enter date of birth!`
  String get birthNull {
    return Intl.message(
      'Please enter date of birth!',
      name: 'birthNull',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the cpf!`
  String get cpfNull {
    return Intl.message(
      'Please enter the cpf!',
      name: 'cpfNull',
      desc: '',
      args: [],
    );
  }

  /// `Please enter marital status!`
  String get licenseNull {
    return Intl.message(
      'Please enter marital status!',
      name: 'licenseNull',
      desc: '',
      args: [],
    );
  }

  /// `Please insert your driver's license!`
  String get civilNull {
    return Intl.message(
      'Please insert your driver\'s license!',
      name: 'civilNull',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the gender!`
  String get genderNull {
    return Intl.message(
      'Please enter the gender!',
      name: 'genderNull',
      desc: '',
      args: [],
    );
  }

  /// `Route Name:`
  String get routeName {
    return Intl.message(
      'Route Name:',
      name: 'routeName',
      desc: '',
      args: [],
    );
  }

  /// `Route List`
  String get routeTitle {
    return Intl.message(
      'Route List',
      name: 'routeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bus Created successfuly!`
  String get busCreatedNotif {
    return Intl.message(
      'Bus Created successfuly!',
      name: 'busCreatedNotif',
      desc: '',
      args: [],
    );
  }

  /// `bus edited successfully!`
  String get busEditedNotif {
    return Intl.message(
      'bus edited successfully!',
      name: 'busEditedNotif',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'br'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}