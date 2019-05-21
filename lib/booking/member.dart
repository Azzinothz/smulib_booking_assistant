import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/book.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';
import 'package:smulib_booking_assistant/booking/detail.dart';

class MemberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberState();
  }
}

class MemberState extends State<MemberPage> {
  List<Widget> memberCards = List();
  TextEditingController memberInputController = TextEditingController();

  void addMember(String name) async {
    memberInputController.text = "";
    String stuID = await getStudentIDByName(name);
    if (stuID == null) {
      return;
    }
    bookingDetail["teamusers"].add(stuID);
    setState(() {
      memberCards.add(buildMemberCard(name, stuID));
    });
  }

  void removeMember(String stuID) {
    int i = bookingDetail["teamusers"].indexOf(stuID);
    if (i == -1) {
      return;
    }
    bookingDetail["teamusers"].removeAt(i);
    setState(() {
      memberCards.removeAt(i);
    });
  }

  Card buildMemberCard(String name, String stuID) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name.substring(0, 1)),
        ),
        title: Text(name),
        trailing: IconButton(
          icon: Icon(
            Icons.cancel,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            removeMember(stuID);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            bookingDetail["start_time"] + " - " + bookingDetail["end_time"]),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DetailPage()));
            },
            icon: Icon(Icons.check),
            iconSize: 30,
          )
        ],
      ),
      body: Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Center(
            child: ListView(
              children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 100),
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 4,
                              child: TextField(
                                controller: memberInputController,
                                decoration: InputDecoration(
                                    hintText: "请输入成员姓名",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.green,
                                  ),
                                  iconSize: 40,
                                  onPressed: () {
                                    addMember(memberInputController.text);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ] +
                  memberCards,
            ),
          )),
    );
  }
}
