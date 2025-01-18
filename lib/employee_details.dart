import 'package:flutter/material.dart';
import 'package:mmm/employee.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;
  const EmployeeDetailScreen({super.key, required this.employee});

//it shows that the data is passed here when tapping on the list tile of employee
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(employee.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name:  ${employee.name}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Username: ${employee.username}",
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Email: ${employee.email}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Phone: ${employee.phone}", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Website: ${employee.website}",
                style: const TextStyle(fontSize: 18, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
