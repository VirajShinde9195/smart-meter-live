import 'package:flutter/material.dart';
import '../models/live_reading.dart';

class LiveReadingProvider with ChangeNotifier {
  List<LiveReading> _readings = [];

  List<LiveReading> get readings => _readings;

  void addReading(LiveReading reading) {
    _readings.add(reading);
    if (_readings.length > 288) { // keep 24 hours (5-min interval)
      _readings.removeAt(0);
    }
    notifyListeners();
  }

  void clearReadings() {
    _readings.clear();
    notifyListeners();
  }
}
