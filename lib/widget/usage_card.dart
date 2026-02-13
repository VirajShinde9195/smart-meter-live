import 'package:flutter/material.dart';

class UsageCard extends StatelessWidget {
  final double dailyUsage;
  final double target;
  final double bill;

  UsageCard({required this.dailyUsage, required this.target, required this.bill});

  @override
  Widget build(BuildContext context) {
    double progress = (dailyUsage / target).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A40),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0,4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily Usage', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[800],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress < 0.85 ? Colors.green : (progress < 1 ? Colors.yellow : Colors.red),
            ),
            minHeight: 12,
          ),
          SizedBox(height: 10),
          Text('Usage: ${dailyUsage.toStringAsFixed(2)} kWh / $target kWh', style: TextStyle(fontSize: 18)),
          Text('Estimated Bill: ₹${bill.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
