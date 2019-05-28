import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';
import 'package:smulib_booking_assistant/booking/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Scaffold page = Scaffold(
    body: Container(
      color: Colors.blue,
    ),
  );

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    if (token != null) {
      name = prefs.getString("name");
      stuID = prefs.getString("stu_id");
      level = prefs.getInt("level");
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: BookingPage(),
                );
              }));
      return;
    }
    setState(() {
      page = buildLoginPage();
    });
  }

  void submit() async {
    setState(() {
      page = Scaffold(
        body: Container(color: Theme.of(context).primaryColor),
      );
    });
    bool ok = await setToken(username.text, password.text);
    if (!ok) {
      return;
    }

    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: BookingPage(),
              );
            }));
  }

  @override
  Widget build(BuildContext context) {
    return page;
  }

  Scaffold buildLoginPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.blue,
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                        icon: Icon(Icons.person), hintText: "请输入学号"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), hintText: "请输入密码"),
                    obscureText: true,
                  ),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          submit();
                        },
                        child: Text(
                          "登录",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
