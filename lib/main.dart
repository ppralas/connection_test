import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'HTTP Requests Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _responseText = '';
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<void> _getRequest() async {
    try {
      final response = await Dio().get('$baseUrl/posts');
      setState(() {
        _responseText = jsonEncode(response.data);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> _putRequest() async {
    try {
      final response = await Dio().put(
        '$baseUrl/posts/1',
        data: jsonEncode(
          <String, dynamic>{'title': 'foo', 'body': 'bar', 'userId': '1'},
        ),
      );
      setState(() {
        _responseText = jsonEncode(response.data);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> _makePostRequest() async {
    try {
      final response = await Dio().post(
        '$baseUrl/posts',
        data: jsonEncode(
          <String, dynamic>{'title': 'foo', 'body': 'bar', 'userId': '1'},
        ),
      );
      setState(() {
        _responseText = jsonEncode(response.data);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> _deleteRequest() async {
    try {
      final response = await Dio().delete('$baseUrl/posts/1');
      setState(() {
        _responseText = jsonEncode(response.data);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> _patchRequest() async {
    try {
      final response = await Dio().patch(
        '$baseUrl/posts/1',
        data: jsonEncode(<String, dynamic>{
          'title': 'new title',
        }),
      );
      setState(() {
        _responseText = jsonEncode(response.data);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Requests Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Response:',
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _responseText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _getRequest,
                  child: const Text('GET'),
                ),
                ElevatedButton(
                  onPressed: _putRequest,
                  child: const Text('PUT'),
                ),
                ElevatedButton(
                  onPressed: _makePostRequest,
                  child: const Text('POST'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _deleteRequest,
                  child: const Text('DELETE'),
                ),
                ElevatedButton(
                  onPressed: _patchRequest,
                  child: const Text('PATCH'),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
