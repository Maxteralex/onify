import 'package:flutter_t1/Model/bus.dart';
import 'driver.dart';

class Schedule {
  List<ScheduleDay> list;
  Driver driver;
  Bus bus;

  Schedule({this.list, this.driver, this.bus});
}

class ScheduleDay{
  DateTime begin;
  DateTime end;

  ScheduleDay({this.begin, this.end});
}