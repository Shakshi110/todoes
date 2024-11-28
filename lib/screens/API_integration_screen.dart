import 'dart:convert'; // Import this to use jsonDecode
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiTaskScreen extends StatefulWidget {
  const ApiTaskScreen({super.key});

  @override
  _ApiTaskScreenState createState() => _ApiTaskScreenState();
}

class _ApiTaskScreenState extends State<ApiTaskScreen> {
  bool _isLoading = true;
  List<dynamic> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      setState(() {
        _tasks = List.from(
            jsonDecode(response.body));
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("API TASKS"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF192A56), Color(0xFF3B5998)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]
                      ['title']),
                );
              },
            ),
    );
  }
}
