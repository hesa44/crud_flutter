import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/tambahdata.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(
          Uri.parse('http://192.168.129.99/flutterapi/crudflutter/read.php'));
      if (respone.statusCode == 200) {
        // print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    // print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_listdata[index]['nama']),
                    subtitle: Text(_listdata[index]['alamat']),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.playlist_add_circle_outlined),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TambahDataPage()));
          }),
    );
  }
}
