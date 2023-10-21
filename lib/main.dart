import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black26),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _data;

  Future getJsonData() async {
    var response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=1"));

    setState(() {
      var decode = json.decode(response.body);
      _data = decode["data"];
      print(_data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Fetch Json Data",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 24),
        child: ListView.builder(
          itemCount: _data == null ? 0 : _data.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  color: Colors.white, // Your desired background color
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3), blurRadius: 3),
                  ]),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                title: Text(
                    "${_data[index]["first_name"]} ${_data[index]["last_name"]}"),
                subtitle: Text("${_data[index]["email"]}"),
                leading: Image.network("${_data[index]["avatar"]}"),
                onTap: () async {
                  await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        child: Container(
                          height: 200,
                          margin: EdgeInsets.fromLTRB(16, 24, 16, 16),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network("${_data[index]["avatar"]}"),
                              SizedBox(height: 20,),
                              Text("${_data[index]["first_name"]} ${_data[index]["last_name"]}"),
                              Text("${_data[index]["email"]}"),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
