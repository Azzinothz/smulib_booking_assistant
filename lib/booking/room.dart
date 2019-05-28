import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';
import 'package:smulib_booking_assistant/booking/book.dart';
import 'package:smulib_booking_assistant/booking/period.dart';

class RoomStatusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RoomStatusState();
  }
}

class RoomStatusState extends State<RoomStatusPage> {
  dynamic _roomsStatus;
  List<InkWell> _roomCards;

  @override
  void initState() {
    super.initState();
    _setRoomsStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(display["date"]),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20),
        child: () {
          if (_roomCards != null) {
            return ListView(
              children: _roomCards,
            );
          } else {
            return Center(
                child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ));
          }
        }(),
      ),
    );
  }

  void _setRoomsStatus() async {
    dynamic data = await getRoomStatus(bookingDetail["day"]);
    setState(() {
      _roomsStatus = data;
      if (_roomsStatus == null) {
        _roomCards = <InkWell>[
          InkWell(
            onTap: () {},
            child: Card(
              child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "双休日不开放",
                    style: TextStyle(fontSize: 28),
                    textAlign: TextAlign.center,
                  )),
            ),
          )
        ];
        return;
      }
      _roomCards = List();
      _roomsStatus.forEach((roomStatus) {
        InkWell roomCard = _buildRoomCard(roomStatus["name"],
            roomStatus["space"], roomStatus["booked_periods"]);
        _roomCards.add(roomCard);
      });
    });
  }

  InkWell _buildRoomCard(
      String roomName, num space, List<dynamic> bookedPeriods) {
    List<Widget> contents = <Widget>[
      ListTile(
        title: Text(
          roomName,
          style: TextStyle(fontSize: 24),
        ),
      ),
      Divider(),
    ];

    List<Widget> bookedPeriodsListTiles = List();
    if (bookedPeriods != null) {
      bookedPeriods.forEach((bookedPeriod) {
        ListTile item = ListTile(
          leading: Icon(Icons.error),
          title: Text(bookedPeriod[0] + " - " + bookedPeriod[1]),
        );
        bookedPeriodsListTiles.add(item);
      });
      contents.addAll(bookedPeriodsListTiles);
    }

    return InkWell(
      onTap: () {
        bookingDetail["space"] = space.toString();
        display["name"] = roomName;
        display["book_period_list_tiles"] = bookedPeriodsListTiles;
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => PeriodPage()));
      },
      child: Card(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: contents,
          ),
        ),
      ),
    );
  }
}
