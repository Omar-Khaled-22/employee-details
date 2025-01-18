import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mmm/employee.dart';
import 'package:mmm/employee_details.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final EmployeeService _employeeService = EmployeeService();
  List<Employee> _employees = [];
  bool _isLoading = true;

  @override
  // Load employees when the screen initializes
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    // Retrieve cached employee data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('employees');

    if (cachedData != null) {
      List<dynamic> jsonData = jsonDecode(cachedData);
      setState(() {
        // Converts   JSON  to  Employee  objects
        _employees = jsonData.map((e) => Employee.fromJson(e)).toList();
        _isLoading = false;
      });
    } else {
      try {
        List<Employee> employees = await _employeeService.fetchEmployees();
        setState(() {
          _employees = employees;
          _isLoading = false;
        });
        // Cache the employee data
        prefs.setString(
            'employees', jsonEncode(employees.map((e) => e.toJson()).toList()));
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      //shows list view if not loading  contains name and email
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _employees.length,
              itemBuilder: (context, index) {
                Employee employee = _employees[index];

                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(employee.email),
                  //when tapped it goes to employee detail
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EmployeeDetailScreen(employee: employee),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
