import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(new MaterialApp(
    title: "JSON",
    // home: new Home(data: new List<String>.generate(300, (i) =>"ini data ke $i"),),
    home: new Home(),
  ));
}

//MENAMPILKAN DATA DARI ARRAY
// class Home extends StatelessWidget {
//   Home({this.data});
//   final List<String> data;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(title : new Text("JSON DATA"),),
//       body: new Container(
//           child: new ListView.builder(
//             itemCount: data?.length,
//             itemBuilder: (context,index){
//               return new ListTile(
//                 leading: new Icon(Icons.widgets),
//                 title: new Text("${data[index]}"),
//               );
//             }
//           ),
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataJSON;

  Future<String> getData() async {
    http.Response result = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      dataJSON = json.decode(result.body);
    });
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("JSON DATA"),
      ),
      body: new ListView.builder(
        itemCount: dataJSON == null ? 0 : dataJSON.length,
        itemBuilder: (context, index) {
          return new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Card(
                  child: new Container(
                    padding: new EdgeInsets.all(20.0),
                      child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(dataJSON[index]['title']),
                  new Text(dataJSON[index]['body']),
                ],
              ))));
        },
      ),
    );
  }
}
