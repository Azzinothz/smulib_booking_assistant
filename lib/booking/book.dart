import 'package:flutter/material.dart';

Map bookingDetail = {
  // For request:
  "space": "",
  "username": "",
  "password": "",
  "day": "",
  "start_time": "",
  "end_time": "",
  "title": "",
  "application": "",
  "teamusers": List<String>(),
  "mobile": "",

  // For display:
  "date": "",
  "name": "",
  "book_period_list_tiles": List<Widget>(),
};

String convertDateTimeToBookingDay(DateTime dt) {
  return dt.year.toString() + "-" + dt.month.toString() + "-" + dt.day.toString();
}
