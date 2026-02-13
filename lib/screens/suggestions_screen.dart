import 'package:flutter/material.dart';

class SuggestionsScreen extends StatelessWidget {
  final suggestions = [
    {
      "title": "Resistive Loads",
      "desc": "Bulbs, heaters, irons. High units but stable PF."
    },
    {
      "title": "Inductive Loads",
      "desc": "Motors, fans, AC. Reduce PF, increase bill."
    },
    {
      "title": "Tip",
      "desc": "Use LED bulbs instead of incandescent → save 30% energy."
    },
    {
      "title": "Tip",
      "desc": "Capacitor banks improve PF for inductive loads."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Suggestions")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          var item = suggestions[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.lightbulb, color: Colors.orange),
              title: Text(item['title']!),
              subtitle: Text(item['desc']!),
            ),
          );
        },
      ),
    );
  }
}
