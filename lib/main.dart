import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red, // Changed primary color to red
        scaffoldBackgroundColor: Colors.black, // Changed scaffold background color to black
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<dynamic> jsonData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://coding-assignment.bombayrunning.com/data.json'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      setState(() {
        jsonData = jsonDecode(response.body);
      });
    } else {
      // If the server did not return a 200 OK response, show an error
      showDialog(
        context: context,
        builder: (context) =>  const AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Center(
          child: Text(
            'FIT PAGE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: jsonData == null
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: jsonData.length,
        itemBuilder: (context, index) {
          final item = jsonData[index];
          final color = getColorFromString(item['color']);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(item: item),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16, top: 0), // Added margin only on the left side
                  child: Text(
                    item['tag'],
                    style: TextStyle(color: color),
                  ),
                ),
                const Divider(thickness: 1, color: Colors.white), // Changed divider color to grey
              ],
            ),
          );
        },
      ),
    );
  }

  Color getColorFromString(String color) {
    switch (color.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class DetailPage extends StatelessWidget {
  final dynamic item;

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = getColorFromString(item['color']);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: Text(
                item['name'],
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Text(
                item['tag'],
                style: TextStyle(color: color, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: item['criteria'].length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(item['criteria'][index]['text'], style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    );
  }

  Color getColorFromString(String color) {
    switch (color.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
