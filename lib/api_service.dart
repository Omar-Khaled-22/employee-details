import 'package:mmm/employee.dart';
import 'package:dio/dio.dart';

class EmployeeService {
  final Dio _dio = Dio();
  final String _url = "https://jsonplaceholder.typicode.com/users";

  Future<List<Employee>> fetchEmployees() async {
    try {
      Response response = await _dio.get(_url);
      List<dynamic> data = response.data;
      return data.map((json) => Employee.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to load employees: \$e");
    }
  }
}
