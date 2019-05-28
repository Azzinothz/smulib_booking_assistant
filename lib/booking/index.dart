import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/room.dart';
import 'package:smulib_booking_assistant/booking/book.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';
import 'package:smulib_booking_assistant/booking/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void toIndexPage(context) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: IndexPage(),
            );
          }));
}

class IndexPage extends StatefulWidget {
  /// Creates an index page
  ///
  /// User can choose the day he or she needs the room
  ///
  /// This is the main page
  @override
  State<StatefulWidget> createState() {
    return IndexState();
  }
}

class IndexState extends State<IndexPage> {
  DateTime _pickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图书馆空间服务"),
        centerTitle: true,
        elevation: 0,
        leading: Container(),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Hi, " + (level == 0 ? "老板" : name),
                    style: TextStyle(color: Colors.white, fontSize: 48),
                  ),
                ),
                _buildDateChooser(context),
                // Place holder
                SizedBox(
                  height: 48,
                ),
              ],
            ),
            _buildUserSwitcher(context),
          ],
        ),
      ),
    );
  }

  Positioned _buildUserSwitcher(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 1,
      right: 1,
      child: FlatButton(
        onPressed: () {
          _logout();
        },
        child: Text(
          "切换用户",
          style: TextStyle(
            color: Theme.of(context).buttonColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  DecoratedBox _buildDateChooser(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        onPressed: _pickDate,
        icon: Icon(Icons.calendar_today),
        color: Theme.of(context).primaryColor,
        iconSize: 78,
        padding: EdgeInsets.all(42),
      ),
    );
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: LoginPage(),
            );
          }),
      (Route<dynamic> route) => false,
    );
  }

  void _pickDate() {
    Future<DateTime> pickADay = showDatePicker(
      context: context,
      initialDate: _pickedDate != null ? _pickedDate : DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2020),
    );
    pickADay.then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _pickedDate = DateTime(date.year, date.month, date.day);
        bookingDetail["day"] = convertDateTimeToBookingDay(_pickedDate);
        display["date"] = _pickedDate.year.toString() +
            "年" +
            _pickedDate.month.toString() +
            "月" +
            _pickedDate.day.toString() +
            "日";
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => RoomStatusPage()));
      });
    });
  }
}
