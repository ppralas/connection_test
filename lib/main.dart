// ignore_for_file: avoid_print

import 'package:collection_test/data/api_client.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

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
  final ApiClient apiClient = ApiClient(Dio());

  Future<void> getPosts() async {
    try {
      final List<Post> posts = await apiClient.getPosts();
      setState(() {
        _responseText = _stringChange(posts);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> postPost() async {
    try {
      final Post post = await apiClient.createPost({
        'title': 'foo',
        'body': 'bar',
        'userId': 1,
      });
      setState(() {
        _responseText = _stringChange(post);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> putPost() async {
    try {
      final Post post = await apiClient.putPost(1, {'title': 'new title'});
      setState(() {
        _responseText = _stringChange(post);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> patchPost(int postId) async {
    try {
      final Post post = await apiClient.patchPost(postId, {
        'title': 'updated title',
        'body': 'updated body',
        'userId': 1,
      });
      setState(() {
        _responseText = _stringChange(post);
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  Future<void> deletePost() async {
    try {
      await apiClient.deletePost(1);
      setState(() {
        _responseText = 'Post deleted successfully';
        print(_responseText); // Print the response
      });
    } catch (error) {
      setState(() {
        _responseText = 'Error: $error';
      });
    }
  }

  String _stringChange(dynamic value) {
    return value.toString().replaceAll(',', ',\n');
  }

  @override
  Widget build(BuildContext context) {
    int postId = 1;
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
                  onPressed: getPosts,
                  child: const Text('GET'),
                ),
                ElevatedButton(
                  onPressed: putPost,
                  child: const Text('PUT'),
                ),
                ElevatedButton(
                  onPressed: postPost,
                  child: const Text('POST'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: deletePost,
                  child: const Text('DELETE'),
                ),
                ElevatedButton(
                  onPressed: () => patchPost(postId),
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
