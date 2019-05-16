import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swallow_nest_flutter/booking/book.dart';
import 'package:swallow_nest_flutter/booking/period.dart';

class RoomStatusPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RoomStatusState();
  }
}

class RoomStatusState extends State<RoomStatusPage> {
  dynamic roomsStatus;
  List<InkWell> roomCards;

  void getRoomsStatus() async {
    Dio dio = Dio();
    String url =
        "http://101.132.144.204:8082/api/room?day=" + bookingDetail["day"];
    Response response = await dio.get(url);
    setState(() {
      roomsStatus = response.data;
      if (roomsStatus == null) {
        roomCards = <InkWell>[
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
      roomCards = List();
      roomsStatus.forEach((roomStatus) {
        InkWell roomCard = buildRoomCard(roomStatus["name"],
            roomStatus["space"], roomStatus["booked_periods"]);
        roomCards.add(roomCard);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getRoomsStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookingDetail["date"]),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20),
        child: () {
          if (roomCards != null) {
            return ListView(
              children: roomCards,
            );
          } else {
            return Center(
                child: Text(
              "正在获取空间信息...",
              style: TextStyle(
                fontSize: 36,
                color: Colors.white,
              ),
            ));
          }
        }(),
      ),
    );
  }

  InkWell buildRoomCard(
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
        bookingDetail["name"] = roomName;
        bookingDetail["book_period_list_tiles"] = bookedPeriodsListTiles;
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
