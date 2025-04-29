import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String result = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/1');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);
          setState(() {
            result = data['name']?.toString() ?? "No name found";
          });
        } catch (e) {
          setState(() {
            result = "Error parsing data";
          });
        }
      } else {
        setState(() {
          result = "Failed to load data";
        });
      }
    } catch (e) {
      setState(() {
        result = "Network error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text(
            "HTTP Example App",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          backgroundColor: Colors.blue[800],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Text(
              result,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Colors.blue[900],
                letterSpacing: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}