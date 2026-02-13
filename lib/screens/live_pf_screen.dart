import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/live_reading_provider.dart';
import '../widget/pf_chart.dart';
import '../widget/tips_card.dart';
import '../services/fetch_live_data.dart';
import '../models/live_reading.dart';
import 'dart:async';

class LivePFScreen extends StatefulWidget {
  @override
  _LivePFScreenState createState() => _LivePFScreenState();
}

class _LivePFScreenState extends State<LivePFScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchAndAddReading();
    timer = Timer.periodic(Duration(minutes: 5), (_) => fetchAndAddReading());
  }

  void fetchAndAddReading() async {
    LiveReading? reading = await fetchLiveReading();
    if (reading != null) {
      Provider.of<LiveReadingProvider>(context, listen: false).addReading(reading);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readings = Provider.of<LiveReadingProvider>(context).readings;

    return Scaffold(
      appBar: AppBar(
        title: Text('Live PF Monitoring'),
        backgroundColor: Colors.deepPurple,
      ),
      body: readings.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  PFChart(readings: readings),
                  SizedBox(height: 20),
                  TipsCard(readings: readings),
                ],
              ),
            ),
    );
  }
}
