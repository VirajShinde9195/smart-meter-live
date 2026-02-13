import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/live_reading.dart';

Future<LiveReading> fetchLiveReading() async {
  try {
    // 👇 Replace this with your actual ESP32 IP shown in Serial Monitor
    const String espUrl = "http://192.168.154.100/reading";
    // Send GET request to ESP
    final response = await http.get(Uri.parse(espUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Return the data as LiveReading model
      return LiveReading(
        time: DateTime.now(),
        voltage: (data['voltage'] ?? 0).toDouble(),
        current: (data['current'] ?? 0).toDouble(),
        // power: (data['power'] ?? 0).toDouble(),
        pf: (data['power_factor'] ?? 0).toDouble(),
        energy: (data['energy'] ?? 0).toDouble(),
      );
    } else {
      throw Exception('Failed to load ESP data: ${response.statusCode}');
    }
  } catch (e) {
    print('⚠️ Error fetching ESP data: $e');

    // Return default (zero) values if connection fails
    return LiveReading(
      time: DateTime.now(),
      voltage: 0,
      current: 0,
      // power: 0,
      pf: 0,
      energy: 0,
    );
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/live_reading.dart';

// Future<LiveReading> fetchLiveReading() async {
//   try {
//     // 👇 Using your ESP32 IP
//     const String espUrl = "http://10.113.128.100/reading";

//     // Send GET request to ESP
//     final response = await http.get(Uri.parse(espUrl));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       // Return the data as LiveReading model
//       return LiveReading(
//         time: DateTime.now(),
//         voltage: (data['voltage'] ?? 0).toDouble(),
//         current: (data['current'] ?? 0).toDouble(),
//         // power: (data['power'] ?? 0).toDouble(),
//         pf: (data['power_factor'] ?? 0).toDouble(),
//         energy: (data['energy'] ?? 0).toDouble(),
//       );
//     } else {
//       throw Exception('Failed to load ESP data: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('⚠️ Error fetching ESP data: $e');

//     // Return default (zero) values if connection fails
//     return LiveReading(
//       time: DateTime.now(),
//       voltage: 0,
//       current: 0,
//       // power: 0,
//       pf: 0,
//       energy: 0,
//     );
//   }
// }
