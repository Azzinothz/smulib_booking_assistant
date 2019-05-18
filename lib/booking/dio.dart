import 'package:dio/dio.dart';

Dio dio = Dio();

Future getRoomStatus(String day) async {
  String url = "http://101.132.144.204:8082/api/room?day=" + day;
  Response response = await dio.get(url);
  return response.data;
}

Future<String> getStudentIDByName(String name) async {
  String url = "http://101.132.144.204:8082/api/student/name/" + name;
  Response response = await dio.get(url);
  dynamic student = response.data;
  if (!student.containsKey("stu_id")) {
    // return null;
    return null;
  }
  return student["stu_id"];
}
