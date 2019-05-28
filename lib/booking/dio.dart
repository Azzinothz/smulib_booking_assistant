import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = Dio();

const baseURL = "http://101.132.144.204:8082";
// const baseURL = "http://127.0.0.1:8082";
String token = "";
String name = "";
String stuID = "";
int level = -1;

Future getRoomStatus(String day) async {
  String url = baseURL + "/api/room?day=" + day;
  Response response = await dio.get(url);
  return response.data;
}

Future<String> getStudentIDByName(String name) async {
  String url = baseURL + "/api/student/name/" + name;
  Response response = await dio.get(url);
  dynamic student = response.data;
  if (!student.containsKey("stu_id")) {
    return null;
  }
  return student["stu_id"];
}

Future<String> postBookingInfo(Map form) async {
  String url = baseURL + "/api/room/" + form["space"];
  try {
    await dio.post(url,
        data: form,
        options: Options(
          headers: {"Authorization": "Bearer " + token},
        ));
    return "success";
  } on DioError catch (e) {
    return e.response.data["message"];
  }
}

Future<bool> setToken(String username, String password) async {
  String url = baseURL + "/api/authorization/token";
  Map json = {
    "username": username,
    "password": password,
  };
  Response response = await dio.post(url, data: json);
  if (response.statusCode != 200) {
    return false;
  }
  token = response.data["token"];
  name = response.data["name"];
  stuID = response.data["stu_id"];
  level = response.data["level"];

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  prefs.setString("name", name);
  prefs.setString("stu_id", stuID);
  prefs.setInt("level", level);

  return true;
}
