import 'package:flutter/material.dart';
import 'package:swallow_nest_flutter/booking/book.dart';

class PeriodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PeriodState();
  }
}

class PeriodState extends State<PeriodPage> {
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool confirm = false;

  String convertTime(TimeOfDay time) {
    return time.hour.toString() + ":" + time.minute.toString();
  }

  void setStartTime() async {
    TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime != null ? startTime : TimeOfDay.now(),
    );
    setState(() {
      startTime = pickedTime;
      if (endTime != null) {
        if (startTime.hour > endTime.hour ||
            (startTime.hour == endTime.hour &&
                startTime.minute >= endTime.minute)) {
          confirm = false;
        } else {
          confirm = true;
        }
      }
    });
  }

  void setEndTime() async {
    TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime != null ? endTime : TimeOfDay.now(),
    );
    setState(() {
      endTime = pickedTime;
      if (startTime != null) {
        if (startTime.hour > endTime.hour ||
            (startTime.hour == endTime.hour &&
                startTime.minute >= endTime.minute)) {
          confirm = false;
        } else {
          confirm = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bookingDetail["name"]),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Card(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      ListTile(
                        title: Text(
                          "请选择预约时间",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: setStartTime,
                        child: ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(startTime != null
                              ? convertTime(startTime)
                              : "开始时间"),
                        ),
                      ),
                      InkWell(
                        onTap: setEndTime,
                        child: ListTile(
                          leading: Icon(
                            Icons.access_time,
                            color: Theme.of(context).accentColor,
                          ),
                          title: Text(
                              endTime != null ? convertTime(endTime) : "结束时间"),
                        ),
                      ),
                      Divider(),
                    ] +
                    bookingDetail["book_period_list_tiles"] +
                    [
                      Divider(),
                      ButtonTheme.bar(
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: Text("确认，选择参与人员"),
                              onPressed: confirm ? (){
                                bookingDetail["start_time"] = convertTime(startTime);
                                bookingDetail["end_time"] = convertTime(endTime);
                              } : null,
                            )
                          ],
                        ),
                      )
                    ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
