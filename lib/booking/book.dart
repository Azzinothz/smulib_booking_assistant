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
  String result = dt.year.toString();
  [dt.month, dt.day].forEach((item) {
    if (item < 10) {
      result += "-0" + item.toString();
    } else {
      result += "-" + item.toString();
    }
  });
  return result;
}

String convertTimeToBookingPeriod(TimeOfDay time) {
  String result = "";
  [time.hour, time.minute].forEach((item) {
    if (item < 10) {
      result += ":0" + item.toString();
    } else {
      result += ":" + item.toString();
    }
  });
  return result.substring(1);
}
