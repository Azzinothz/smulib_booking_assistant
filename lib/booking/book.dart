import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';

Map bookingDetail = {
  "username": "",
  "password": "",
  "space": "",
  "day": "",
  "start_time": "",
  "end_time": "",
  "title": "",
  "application": "",
  "teamusers": List<String>(),
  "mobile": "",
};

Map display = {
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

class BookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookState();
  }
}

class BookState extends State<BookPage> {
  String msg;
  Card resultContentCard;

  void getResult() async {
    String result = await postBookingInfo(bookingDetail);
    setState(() {
      if (result == "success") {
        resultContentCard = Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListTile(
              leading: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 32,
              ),
              title: Text(
                "预约成功",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      } else {
        resultContentCard = Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListTile(
              leading: Icon(
                Icons.cancel,
                color: Colors.red,
                size: 32,
              ),
              title: Text(
                result,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("预约结果"),
        centerTitle: true,
        leading: null,
        elevation: 0,
      ),
      body: Container(
          color: Theme.of(context).primaryColor,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: resultContentCard),
    );
  }
}
