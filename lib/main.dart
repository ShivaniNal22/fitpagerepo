import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const String jsonData = '''
[
    {"id": 1, "name": "Top gainers", "tag":"Intraday Bullish", "color": "green", "criteria": [{ "type": "plain_text", "text": "Sort - %price change in descending order" }]},
    {"id": 2, "name": "Intraday buying seen in last 15 minutes", "tag":"Bullish", "color": "green", "criteria": [{"type":"plain_text","text":"Current candle open = current candle high"},{"type":"plain_text","text":"Previous candle open = previous candle high"},{"type":"plain_text","text":"2 previous candle’s open = 2 previous candle’s high"}]},
    {"id": 3, "name": "Open = High", "tag":"Bullish", "color": "green", "criteria": [{"type": "variable", "text": "Today’s open < yesterday’s low by \$1 %", "variable": { "\$1": { "type": "value", "values": [ -3, -1, -2, -5, -10 ] } }}]},
    {"id": 4, "name": "CCI Reversal", "tag":"Bearish", "color": "red", "criteria": [{"type": "variable", "text": "CCI \$1 crosses below \$2", "variable": { "\$1": { "type": "indicator", "study_type": "cci", "parameter_name": "period", "min_value":1, "max_value":99, "default_value":20 }, "\$2": { "type": "value", "values": [100,200]}}}]},
    {"id": 5, "name": "RSI Overbought", "tag":"Bearish", "color": "red", "criteria": [{ "type": "variable", "text": "Max of last 5 days close > Max of last 120 days close by \$1 %", "variable": { "\$1": { "type": "value", "values": [ 2, 1, 3, 5 ] } } }, { "type": "variable", "text": "Today's Volume > prev \$2 Vol SMA by \$3 x", "variable": { "\$2": { "type": "value", "values": [ 10, 5, 20, 30 ] }, "\$3": { "type": "value", "values": [ 1.5, 0.5, 1, 2, 3 ] } } },{ "type": "variable", "text": "RSI \$4 > 20", "variable": { "\$4": { "type": "indicator", "study_type": "rsi", "parameter_name": "period", "min_value":1, "max_value":99 , "default_value":14}}}]}
]
''';

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

class MyHomePage extends StatelessWidget {
  final List<dynamic> parsedJson = json.decode(jsonData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.redAccent,
        title: const Center(
          child: Text('FIT PAGE'
              ,style: TextStyle(
              fontWeight: FontWeight.bold,color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: parsedJson.length,
        itemBuilder: (context, index) {
          final item = parsedJson[index];
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
                  margin: EdgeInsets.only(left: 16, top: 0), // Added margin only on the left side
                  child: Text(
                    item['tag'],
                    style: TextStyle(color: color),
                  ),
                ),
                Divider(thickness: 1, color: Colors.white), // Changed divider color to grey
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
              child: Text(item['name'],
                style:const TextStyle(color: Colors.black,fontSize: 17),
              ),
            ),
             const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Text(
                item['tag'],
                style: TextStyle(color: color,fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: item['criteria'].length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(item['criteria'][index]['text'], style: TextStyle(color: Colors.white)),
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
