import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/book.dart';

class DetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailPage> {
  TextEditingController title = TextEditingController();
  TextEditingController application = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详细信息"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                          icon: Icon(Icons.title), hintText: "请输入标题"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: application,
                      decoration: InputDecoration(
                          icon: Icon(Icons.text_fields), hintText: "请输入描述"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: phone,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone), hintText: "请输入手机号码"),
                    ),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            if (title.text == "") {
                              title.text = "项目会议";
                            }
                            if (application.text.length < 10) {
                              application.text = "项目组全员参与的项目会议";
                            }
                            if (phone.text.length != 11) {
                              phone.text = "15021458372";
                            }
                          },
                          child: Text("自动生成"),
                        ),
                        FlatButton(
                          onPressed: () {
                            bookingDetail["title"] = title.text;
                            bookingDetail["application"] = application.text;
                            bookingDetail["mobile"] = phone.text;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BookPage()));
                          },
                          child: Text("提交预约信息"),
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
