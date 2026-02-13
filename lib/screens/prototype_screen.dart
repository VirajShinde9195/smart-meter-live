import 'package:flutter/material.dart';

class PrototypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prototype Info")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset("assets/images/viraj_photo.jpg", height: 200),
            SizedBox(height: 20),
            Text("Our Prototype", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "We used ESP32 + PZEM-004T sensor to monitor voltage, current, power factor, and units. "
              "Data is sent to Supabase and displayed in this app. "
              "User benefits include:\n\n"
              "- Track daily usage\n"
              "- Alerts on high usage\n"
              "- Suggestions to reduce bill\n"
              "- Monthly reports",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
