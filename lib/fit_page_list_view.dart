// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   // final List<dynamic> parsedJson = json.decode(jsonData);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List View Example'),
//       ),
//       body: ListView.builder(
//         itemCount: parsedJson.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(parsedJson[index]['name']),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DetailPage(item: parsedJson[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class DetailPage extends StatelessWidget {
//   final dynamic item;
//
//   DetailPage({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(item['name']),
//       ),
//       body: ListView.builder(
//         itemCount: item['criteria'].length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(item['criteria'][index]['text']),
//           );
//         },
//       ),
//     );
//   }
// }
