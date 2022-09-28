import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/loadData.dart';

void main() {
  runApp(MyApp());
}

Future<LoadData> apiCall(String as) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/' + as));
  if (response.statusCode == 200) {
    return LoadData.fromJson(json.decode(response.body));
  }
  if (response.statusCode == 404) {
    throw Exception('404 page not found');
  } else {
    throw Exception('Failed to load');
  }
}

Future<void> _showMyDialog() async {
  var context;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'INFO PAGE',
          style: TextStyle(
              color: Colors.black26, fontStyle: FontStyle.italic, fontSize: 30),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: DialogExample(),
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('INFOS'),
          content: FutureBuilder<LoadData>(
            future: apiCall("2"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: Center(
                        child: Text(
                  "User Id: ${snapshot.data?.userId} \n" +
                      "Id: ${snapshot.data?.id}\n" +
                      "Title: ${snapshot.data?.title}\n" +
                      "Body: ${snapshot.data?.body}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.pink),
                )));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text(
        'Press Here',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
