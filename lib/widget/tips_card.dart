import 'package:flutter/material.dart';
import '../models/live_reading.dart';

class TipsCard extends StatelessWidget {
  final List<LiveReading> readings;

  TipsCard({required this.readings});

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) return SizedBox();

    final latest = readings.last;
    String tip = "PF Normal";
    if (latest.pf < 0.85) {
      tip = "PF dropped to ${latest.pf.toStringAsFixed(2)} → Inductive load likely → increases bill.";
    } else if (latest.pf > 0.95) {
      tip = "PF is high → efficient usage.";
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A40),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0,4))],
      ),
      child: Row(
        children: [
          Icon(Icons.lightbulb, color: Colors.yellowAccent, size: 36),
          SizedBox(width: 12),
          Expanded(child: Text(tip, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
