import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/room.dart';
import 'package:smulib_booking_assistant/booking/book.dart';

class BookingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookingState();
  }
}

class BookingState extends State<BookingPage> {
  DateTime pickedDate;

  void pickDate() {
    Future<DateTime> pickADay = showDatePicker(
      context: context,
      initialDate: pickedDate != null ? pickedDate : DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2020),
    );
    pickADay.then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        pickedDate = DateTime(date.year, date.month, date.day);
        bookingDetail["day"] = convertDateTimeToBookingDay(pickedDate);
        bookingDetail["date"] = pickedDate.year.toString() +
            "年" +
            pickedDate.month.toString() +
            "月" +
            pickedDate.day.toString() +
            "日";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RoomStatusPage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图书馆空间服务"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: pickDate,
            icon: Icon(Icons.calendar_today),
            color: Theme.of(context).primaryColor,
            iconSize: 78,
            padding: EdgeInsets.all(42),
          ),
        ),
      ),
    );
  }
}
