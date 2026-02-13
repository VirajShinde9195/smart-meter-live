// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../models/live_reading.dart';

// class PFChart extends StatelessWidget {
//   final List<LiveReading> readings;
//   const PFChart({required this.readings});

//   String getRecommendation(double pf) {
//     if (pf >= 0.95) return "✅ Good PF (Resistive Load)";
//     if (pf >= 0.85) return "⚠️ Moderate PF (Slightly Inductive)";
//     return "❌ Poor PF (Inductive Load – Add Capacitor Bank)";
//   }

//   Color getPFColor(double pf) {
//     if (pf >= 0.95) return Colors.green;
//     if (pf >= 0.85) return Colors.orange;
//     return Colors.red;
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<FlSpot> spots = [];
//     if (readings.isEmpty) {
//       spots.add(FlSpot(0, 0));
//     } else {
//       for (int i = 0; i < readings.length; i++) {
//         double pfValue = readings[i].pf.clamp(0.0, 1.0);
//         spots.add(FlSpot(i.toDouble(), pfValue));
//       }
//     }

//     double latestPF = readings.isNotEmpty ? readings.last.pf : 0.0;

//     return Column(
//       children: [
//         Container(
//           height: 380,
//           width: 400,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 8,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(16),
//           child: LineChart(
//             LineChartData(
//               minY: 0.0,
//               maxY: 1.0,
//               backgroundColor: Colors.white,
//               gridData: FlGridData(
//                 show: true,
//                 drawVerticalLine: true,
//                 horizontalInterval: 0.1,
//                 getDrawingHorizontalLine: (value) =>
//                     FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
//                 getDrawingVerticalLine: (value) =>
//                     FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
//               ),
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   axisNameSize: 40,
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     getTitlesWidget: (value, meta) {
//                       return Text(
//                         value.toStringAsFixed(1),
//                         style: const TextStyle(
//                           color: Colors.black87,
//                           fontSize: 14,
//                         ),
//                       );
//                     },
//                   ),
//                   axisNameWidget: const Padding(
//                     padding: EdgeInsets.only(right: 13),
//                     child: Text(
//                       "Power Factor",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     interval: 1, // ✅ show every reading label
//                     getTitlesWidget: (value, meta) {
//                       int minute = (value.toInt()) * 5;
//                       return Transform.rotate(
//                         angle: -0.7, // ✅ rotate ~40 degrees
//                         child: Text(
//                           "$minute",
//                           style: const TextStyle(
//                             color: Colors.black87,
//                             fontSize: 13,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   axisNameWidget: const Padding(
//                     padding: EdgeInsets.only(top: 1),
//                     child: Text(
//                       "Time in Minutes →",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 rightTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: Colors.black26),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: spots,
//                   isCurved: true,
//                   color: Colors.green.shade700,
//                   barWidth: 3,
//                   isStrokeCapRound: true,
//                   dotData: FlDotData(show: true),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.green.withOpacity(0.3),
//                         Colors.yellow.withOpacity(0.2),
//                         Colors.red.withOpacity(0.1),
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),
//               ],
//               lineTouchData: LineTouchData(
//                 touchTooltipData: LineTouchTooltipData(
//                   tooltipBgColor: Colors.black87,
//                   getTooltipItems: (spots) => spots.map((spot) {
//                     return LineTooltipItem(
//                       "Time: ${(spot.x.toInt() * 5)} min\nPF: ${spot.y.toStringAsFixed(2)}",
//                       const TextStyle(color: Colors.white),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(12),
//           margin: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color: getPFColor(latestPF).withOpacity(0.15),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: getPFColor(latestPF), width: 1.2),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 "Latest PF: ${latestPF.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: getPFColor(latestPF),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 getRecommendation(latestPF),
//                 style: const TextStyle(fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../models/live_reading.dart';

// class PFChart extends StatelessWidget {
//   final List<LiveReading> readings;
//   const PFChart({required this.readings});

//   String getRecommendation(double pf) {
//     if (pf >= 0.95) return "✅ Good PF (Resistive Load)";
//     if (pf >= 0.85) return "⚠️ Moderate PF (Slightly Inductive)";
//     return "❌ Poor PF (Inductive Load – Add Capacitor Bank)";
//   }

//   Color getPFColor(double pf) {
//     if (pf >= 0.95) return Colors.green;
//     if (pf >= 0.85) return Colors.orange;
//     return Colors.red;
//   }

//   // ✅ Parse PF safely (handles double, int, String, or percent)
//   double _parsePf(dynamic raw) {
//     if (raw == null) return 0.0;
//     double v = 0.0;

//     if (raw is double) {
//       v = raw;
//     } else if (raw is int) {
//       v = raw.toDouble();
//     } else if (raw is String) {
//       v = double.tryParse(raw) ?? 0.0;
//     } else {
//       try {
//         v = double.parse(raw.toString());
//       } catch (_) {
//         v = 0.0;
//       }
//     }

//     // If PF looks like percent (e.g., 80 or 90), convert to 0.8 / 0.9
//     if (v > 1.5) v = v / 100.0;
//     return v.clamp(0.0, 1.0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<FlSpot> spots = [];

//     // ✅ Generate points from readings (with parsed PF values)
//     if (readings.isEmpty) {
//       spots.add(FlSpot(0, 0));
//     } else {
//       for (int i = 0; i < readings.length; i++) {
//         double pfValue = _parsePf(readings[i].pf);
//         spots.add(FlSpot(i.toDouble(), pfValue));
//       }
//     }

//     double latestPF = readings.isNotEmpty ? _parsePf(readings.last.pf) : 0.0;

//     return Column(
//       children: [
//         Container(
//           height: 380,
//           width: 400,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 8,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(16),
//           child: LineChart(
//             LineChartData(
//               minY: 0.0,
//               maxY: 1.0,
//               backgroundColor: Colors.white,
//               gridData: FlGridData(
//                 show: true,
//                 drawVerticalLine: true,
//                 horizontalInterval: 0.1,
//                 getDrawingHorizontalLine: (value) =>
//                     FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
//                 getDrawingVerticalLine: (value) =>
//                     FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
//               ),
//               titlesData: FlTitlesData(
//                 leftTitles: AxisTitles(
//                   axisNameSize: 40,
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     getTitlesWidget: (value, meta) {
//                       return Text(
//                         value.toStringAsFixed(1),
//                         style: const TextStyle(
//                           color: Colors.black87,
//                           fontSize: 14,
//                         ),
//                       );
//                     },
//                   ),
//                   axisNameWidget: const Padding(
//                     padding: EdgeInsets.only(right: 13),
//                     child: Text(
//                       "Power Factor",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 40,
//                     interval: 1,
//                     getTitlesWidget: (value, meta) {
//                       int minute = (value.toInt()) * 5;
//                       return Transform.rotate(
//                         angle: -0.7,
//                         child: Text(
//                           "$minute",
//                           style: const TextStyle(
//                             color: Colors.black87,
//                             fontSize: 13,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   axisNameWidget: const Padding(
//                     padding: EdgeInsets.only(top: 1),
//                     child: Text(
//                       "Time in Minutes →",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 rightTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: Colors.black26),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: spots,
//                   isCurved: true,
//                   color: Colors.green.shade700,
//                   barWidth: 3,
//                   isStrokeCapRound: true,
//                   dotData: FlDotData(show: true),
//                   belowBarData: BarAreaData(
//                     show: true,
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.green.withOpacity(0.3),
//                         Colors.yellow.withOpacity(0.2),
//                         Colors.red.withOpacity(0.1),
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),
//               ],
//               lineTouchData: LineTouchData(
//                 touchTooltipData: LineTouchTooltipData(
//                   tooltipBgColor: Colors.black87,
//                   getTooltipItems: (spots) => spots.map((spot) {
//                     return LineTooltipItem(
//                       "Time: ${(spot.x.toInt() * 5)} min\nPF: ${spot.y.toStringAsFixed(2)}",
//                       const TextStyle(color: Colors.white),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(12),
//           margin: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color: getPFColor(latestPF).withOpacity(0.15),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: getPFColor(latestPF), width: 1.2),
//           ),
//           child: Column(
//             children: [
//               Text(
//                 "Latest PF: ${latestPF.toStringAsFixed(2)}",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: getPFColor(latestPF),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 getRecommendation(latestPF),
//                 style: const TextStyle(fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// add one fecture here show reading of inductive and capacitive load
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../models/live_reading.dart';

// class PFChart extends StatefulWidget {
//   final List<LiveReading> readings;
//   const PFChart({required this.readings, Key? key}) : super(key: key);

//   @override
//   State<PFChart> createState() => _PFChartState();
// }

// class _PFChartState extends State<PFChart> {
//   final List<Map<String, dynamic>> _pfData = [];
//   final List<Map<String, dynamic>> _inductivePeriods = [];
//   final List<Map<String, dynamic>> _offPeriods = [];

//   bool _isInductive = false;
//   bool _isDeviceOff = false;
//   DateTime? _inductiveStart;
//   DateTime? _offStart;

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _handleNewReading(LiveReading reading) {
//     double pf = _parsePf(reading.pf);
//     double voltage = reading.voltage ?? 0.0;
//     double current = reading.current ?? 0.0;
//     DateTime now = DateTime.now();

//     // ===== Device OFF Detection =====
//     if (voltage < 5 || current < 0.05) {
//       if (!_isDeviceOff) {
//         _isDeviceOff = true;
//         _offStart = now;
//       }
//       setState(() {});
//       return;
//     } else if (_isDeviceOff) {
//       // Device just turned ON again
//       _isDeviceOff = false;
//       if (_offStart != null) {
//         _offPeriods.add({"start": _offStart!, "end": now});
//         _offStart = null;
//       }
//     }

//     // ===== PF Data =====
//     _pfData.add({"pf": pf, "time": now});
//     _pfData.removeWhere((d) => now.difference(d["time"]).inHours > 24);

//     // ===== Inductive Tracking =====
//     if (pf < 0.85 && !_isInductive) {
//       _isInductive = true;
//       _inductiveStart = now;
//     } else if (pf >= 0.85 && _isInductive) {
//       _isInductive = false;
//       if (_inductiveStart != null) {
//         _inductivePeriods.add({
//           "start": _inductiveStart!,
//           "end": now,
//           "duration": now.difference(_inductiveStart!).inMinutes,
//         });
//       }
//     }

//     setState(() {});
//   }

//   double _parsePf(dynamic raw) {
//     double v = 0.0;
//     if (raw is double)
//       v = raw;
//     else if (raw is int)
//       v = raw.toDouble();
//     else if (raw is String)
//       v = double.tryParse(raw) ?? 0.0;
//     if (v > 1.5) v = v / 100.0;
//     return v.clamp(0.0, 1.0);
//   }

//   Color _getPFColor(double pf) {
//     if (pf >= 0.95) return Colors.green;
//     if (pf >= 0.85) return Colors.orange;
//     return Colors.red;
//   }

//   String _getRecommendation(double pf) {
//     if (pf >= 0.95) return "✅ Good PF (Resistive Load)";
//     if (pf >= 0.85) return "⚠️ Moderate PF (Slightly Inductive)";
//     return "❌ Poor PF (Inductive Load – Add Capacitor Bank)";
//   }

//   String _formatTime(DateTime t) =>
//       "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

//   @override
//   Widget build(BuildContext context) {
//     double latestPF = _pfData.isNotEmpty ? _pfData.last["pf"] : 0.0;
//     List<FlSpot> spots = _pfData.map((d) {
//       double minuteOfDay = d["time"].hour * 60 + d["time"].minute.toDouble();
//       return FlSpot(minuteOfDay, d["pf"]);
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live PF Monitoring"),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Container(
//         color: Colors.grey[100],
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // =================== CHART ===================
//                 Container(
//                   height: 360,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 6,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: spots.isEmpty
//                       ? const Center(child: Text("No data yet"))
//                       : SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: SizedBox(
//                             width: 1200,
//                             child: Stack(
//                               children: [
//                                 // ===== OFF Period Background =====
//                                 ..._offPeriods.map((p) {
//                                   double x1 =
//                                       (p["start"].hour * 60 + p["start"].minute)
//                                           .toDouble();
//                                   double x2 =
//                                       (p["end"].hour * 60 + p["end"].minute)
//                                           .toDouble();
//                                   return Positioned.fill(
//                                     child: IgnorePointer(
//                                       ignoring: true,
//                                       child: CustomPaint(
//                                         painter: _OffPeriodPainter(x1, x2),
//                                       ),
//                                     ),
//                                   );
//                                 }),

//                                 // ===== Main PF Chart =====
//                                 LineChart(
//                                   LineChartData(
//                                     minY: 0.0,
//                                     maxY: 1.0,
//                                     minX: 0,
//                                     maxX: 1440,
//                                     gridData: FlGridData(show: true),
//                                     titlesData: FlTitlesData(
//                                       leftTitles: AxisTitles(
//                                         sideTitles: SideTitles(
//                                           showTitles: true,
//                                           reservedSize: 40,
//                                           getTitlesWidget: (val, meta) =>
//                                               Text(val.toStringAsFixed(1)),
//                                         ),
//                                       ),
//                                       bottomTitles: AxisTitles(
//                                         sideTitles: SideTitles(
//                                           showTitles: true,
//                                           interval: 60,
//                                           getTitlesWidget: (val, meta) {
//                                             int h = (val ~/ 60) % 24;
//                                             return Text(
//                                               "${h.toString().padLeft(2, '0')}:00",
//                                               style: const TextStyle(
//                                                 fontSize: 12,
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     lineBarsData: [
//                                       LineChartBarData(
//                                         spots: spots,
//                                         isCurved: true,
//                                         color: Colors.blueAccent,
//                                         barWidth: 2,
//                                         dotData: FlDotData(show: false),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                 ),
//                 const SizedBox(height: 16),

//                 // =================== STATUS BOX ===================
//                 if (_isDeviceOff)
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.black45),
//                     ),
//                     child: const Text(
//                       "⚡ Device Off – No Power Flow Detected",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 else
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: _getPFColor(latestPF).withOpacity(0.15),
//                       border: Border.all(
//                         color: _getPFColor(latestPF),
//                         width: 1.2,
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Latest PF: ${latestPF.toStringAsFixed(2)}",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: _getPFColor(latestPF),
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           _getRecommendation(latestPF),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),

//                 const SizedBox(height: 20),

//                 // =================== INDUCTIVE USAGE LOG ===================
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "📅 Inductive Usage Today:",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 _inductivePeriods.isEmpty
//                     ? const Text("No inductive usage yet")
//                     : Column(
//                         children: _inductivePeriods.map((p) {
//                           String s = _formatTime(p["start"]);
//                           String e = _formatTime(p["end"]);
//                           int dur = p["duration"];
//                           return Container(
//                             margin: const EdgeInsets.symmetric(vertical: 4),
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.red.withOpacity(0.1),
//                               border: Border.all(color: Colors.red),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               "⏱ $s → $e  (${dur}m)",
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                       ),

//                 const SizedBox(height: 20),

//                 // =================== RESET BUTTON ===================
//                 ElevatedButton.icon(
//                   icon: const Icon(Icons.refresh),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   label: const Text(
//                     "Reset Day Data",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _pfData.clear();
//                       _inductivePeriods.clear();
//                       _offPeriods.clear();
//                       _isInductive = false;
//                       _inductiveStart = null;
//                       _offStart = null;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // 🎨 Custom painter for OFF periods (gray shaded background)
// class _OffPeriodPainter extends CustomPainter {
//   final double startX, endX;
//   _OffPeriodPainter(this.startX, this.endX);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.grey.withOpacity(0.2)
//       ..style = PaintingStyle.fill;
//     double x1 = (startX / 1440) * size.width;
//     double x2 = (endX / 1440) * size.width;
//     canvas.drawRect(Rect.fromLTRB(x1, 0, x2, size.height), paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/live_reading.dart';

class PFChart extends StatefulWidget {
  final List<LiveReading> readings;
  const PFChart({required this.readings, Key? key}) : super(key: key);

  @override
  State<PFChart> createState() => _PFChartState();
}

class _PFChartState extends State<PFChart> {
  double inductiveMinutes = 0;
  double resistiveMinutes = 0;
  bool deviceOff = false;
  List<Map<String, String>> inductiveTimeline = [];

  double _parsePf(dynamic raw) {
    if (raw == null) return 0.0;
    double v;
    if (raw is double)
      v = raw;
    else if (raw is int)
      v = raw.toDouble();
    else if (raw is String)
      v = double.tryParse(raw) ?? 0.0;
    else
      v = double.tryParse(raw.toString()) ?? 0.0;
    if (v > 1.5) v = v / 100.0;
    return v.clamp(0.0, 1.0);
  }

  String _getRecommendation(double pf) {
    if (pf >= 0.95) return "✅ Resistive Load (Good PF)";
    if (pf >= 0.85) return "⚠️ Slightly Inductive";
    return "❌ Inductive Load – Add Capacitor Bank";
  }

  Color _getPFColor(double pf) {
    if (pf >= 0.95) return Colors.green;
    if (pf >= 0.85) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final readings = widget.readings;
    List<FlSpot> spots = [];
    inductiveTimeline.clear();

    if (readings.isEmpty) {
      spots.add(FlSpot(0, 0));
    } else {
      inductiveMinutes = 0;
      resistiveMinutes = 0;
      DateTime? currentStart;

      for (int i = 0; i < readings.length; i++) {
        double pf = _parsePf(readings[i].pf);
        double x = i.toDouble();

        if (pf == 0) {
          deviceOff = true;
        } else {
          deviceOff = false;
          if (pf < 0.85) {
            inductiveMinutes += 5;
            if (currentStart == null) currentStart = readings[i].createdAt;
          } else {
            resistiveMinutes += 5;
            if (currentStart != null) {
              DateTime? end = readings[i].createdAt;
              inductiveTimeline.add({
                "start": _formatTime(currentStart),
                "end": _formatTime(end),
              });
              currentStart = null;
            }
          }
        }
        spots.add(FlSpot(x, pf));
      }

      if (currentStart != null) {
        inductiveTimeline.add({
          "start": _formatTime(currentStart),
          "end": "Now",
        });
      }
    }

    double latestPF = readings.isNotEmpty ? _parsePf(readings.last.pf) : 0.0;
    DateTime? latestTime = readings.isNotEmpty ? readings.last.createdAt : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ---------- PF CHART ----------
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 8,
                  left: 8,
                  right: 8,
                ), // ✅ added top padding
                decoration: BoxDecoration(
                  color: Colors.black, // ✅ black background
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                height: 420, // ✅ slightly taller so PF=1 visible
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: max(600, spots.length * 60),
                    child: LineChart(
                      LineChartData(
                        minY: 0.0,
                        maxY: 1.05, // ✅ small margin for PF=1 visibility
                        backgroundColor: Colors.black,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 0.1,
                          getDrawingHorizontalLine: (value) =>
                              FlLine(color: Colors.white24, strokeWidth: 1),
                          getDrawingVerticalLine: (value) =>
                              FlLine(color: Colors.white24, strokeWidth: 1),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) => Text(
                                value.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            axisNameWidget: const Text(
                              "Power Factor",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            axisNameSize: 32,
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= readings.length)
                                  return const SizedBox();
                                DateTime t =
                                    readings[value.toInt()].createdAt ??
                                    DateTime.now();
                                String formatted =
                                    "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
                                return Text(
                                  formatted,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                            axisNameWidget: const Text(
                              "Time (24h format) →",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            axisNameSize: 40,
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.white30),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: const Color.fromARGB(255, 238, 237, 241),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.withOpacity(0.15),
                                  Colors.orange.withOpacity(0.15),
                                  Colors.red.withOpacity(0.08),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // all other parts same ↓↓↓
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: _getPFColor(latestPF).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _getPFColor(latestPF), width: 1.2),
                ),
                child: Column(
                  children: [
                    Text(
                      deviceOff
                          ? "⚡ Device is OFF"
                          : "Latest PF: ${latestPF.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _getPFColor(latestPF),
                      ),
                    ),
                    if (!deviceOff)
                      Text(
                        _getRecommendation(latestPF),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    if (latestTime != null)
                      Text(
                        "Last updated: ${latestTime.hour}:${latestTime.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[400]),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSummaryCard(),
              const SizedBox(height: 20),
              _buildTimelineCard(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "🧠 Daily PF Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Resistive load used for: ${resistiveMinutes.toInt()} minutes",
            style: TextStyle(color: Colors.green.shade700, fontSize: 17),
          ),
          Text(
            "Inductive load used for: ${inductiveMinutes.toInt()} minutes",
            style: TextStyle(color: Colors.red.shade700, fontSize: 17),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  inductiveMinutes = 0;
                  resistiveMinutes = 0;
                  inductiveTimeline.clear();
                });
              },
              icon: Icon(Icons.refresh, color: Colors.deepPurple),
              label: Text(
                "Reset Summary",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "⏰ Inductive Load Timeline (Today)",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 8),
          inductiveTimeline.isEmpty
              ? Text(
                  "✅ No inductive load detected today.",
                  style: TextStyle(color: Colors.green.shade700),
                )
              : Column(
                  children: inductiveTimeline.map((range) {
                    return ListTile(
                      dense: true,
                      leading: Icon(Icons.bolt, color: Colors.redAccent),
                      title: Text(
                        "From ${range['start']} to ${range['end']}",
                        style: TextStyle(fontSize: 15),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  String _formatTime(DateTime? t) {
    if (t == null) return "--:--";
    return "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
  }
}
