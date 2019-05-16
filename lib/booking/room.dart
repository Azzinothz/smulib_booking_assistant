import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RoomStatusPage extends StatefulWidget {
  RoomStatusPage(this.date);
  final DateTime date;

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
    String url = "http://101.132.144.204:8082/api/room?day=" +
        widget.date.year.toString() +
        "-" +
        widget.date.month.toString() +
        "-" +
        widget.date.day.toString();
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
        InkWell roomCard =
            buildRoomCard(roomStatus["name"], roomStatus["booked_periods"]);
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
        title: Text(widget.date.year.toString() +
            "年" +
            widget.date.month.toString() +
            "月" +
            widget.date.day.toString() +
            "日" +
            " Test 1"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20),
        // child: ListView(
        //   children:
        //       roomCards != null ? roomCards : <Widget>[Text("Loading...")],
        // ),
        child: () {
          if (roomCards != null) {
            return ListView(
              children: roomCards,
            );
          } else {
            return Center(
                child: Text(
              "Loading...",
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ));
          }
        }(),
      ),
    );
  }

  // void setRoomCards() {
  //   List<InkWell> roomCards;
  //   roomsStatus.forEach((roomStatus) {
  //     InkWell roomCard =
  //         buildRoomCard(roomStatus["name"], roomStatus["booked_periods"]);
  //     roomCards.add(roomCard);
  //   });
  // }

  InkWell buildRoomCard(String roomName, List<dynamic> bookedPeriods) {
    List<Widget> contents = <Widget>[
      ListTile(
        title: Text(
          roomName,
          style: TextStyle(fontSize: 24),
        ),
      ),
      Divider(),
    ];

    if (bookedPeriods != null) {
      bookedPeriods.forEach((bookedPeriod) {
        ListTile item = ListTile(
          leading: Icon(Icons.error),
          title: Text(bookedPeriod[0] + " - " + bookedPeriod[1]),
        );
        contents.add(item);
      });
    }

    return InkWell(
      onTap: () {},
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
