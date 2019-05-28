import 'package:flutter/material.dart';
import 'package:smulib_booking_assistant/booking/dio.dart';
import 'package:smulib_booking_assistant/booking/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  /// Creates a login page
  ///
  /// After user's first login, App would save the token and relevant data locally
  /// User can choose to log out in the index page
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return page;
  }

  void toIndexPage() {
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

  void getToken() async {
    /// Get token from local storage, if succeeds, push to the next page
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");

    if (token != null) {
      name = prefs.getString("name");
      stuID = prefs.getString("stu_id");
      level = prefs.getInt("level");
      toIndexPage();
      return;
    } else {
      setState(() {
        page = buildLoginPage();
      });
      return;
    }
  }

  void submit() async {
    setState(() {
      page = Scaffold(
        body: Container(color: Theme.of(context).primaryColor),
      );
    });
    bool ok = await setToken(usernameCtrl.text, passwordCtrl.text);
    if (!ok) {
      return;
    }

    toIndexPage();
    return;
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
                buildTextField("请输入学号", usernameCtrl, false),
                buildTextField("请输入密码", passwordCtrl, true),
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

  Padding buildTextField(
      String hint, TextEditingController controller, bool isPassword) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(icon: Icon(Icons.person), hintText: hint),
        obscureText: isPassword,
      ),
    );
  }
}
