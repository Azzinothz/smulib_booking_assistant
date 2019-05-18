import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/book.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';

class MemberPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MemberState();
  }
}

class MemberState extends State<MemberPage> {
  List<Widget> memberCards = List();
  List<String> members = List();
  TextEditingController memberInputController = TextEditingController();

  void addMember(String name) async {
    memberInputController.text = "";
    String stuID = await getStudentIDByName(name);
    if (stuID == null) {
      return;
    }
    bookingDetail["stu_id"] = stuID;
    setState(() {
      memberCards.add(buildMemberCard(name));
      members.add(name);
    });
  }

  void removeMember(String name) {
    int i = members.indexOf(name);
    if (i == -1) {
      return;
    }
    setState(() {
      memberCards.removeAt(i);
      members.removeAt(i);
    });
  }

  Card buildMemberCard(String name) {
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
            removeMember(name);
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
            onPressed: (){},
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
