// import 'package:flutter/material.dart';
// import '../widget/usage_card.dart';
// import '../models/live_reading.dart';
// import '../services/fetch_live_data.dart'; // your fetchLiveReading() file

// class DashboardScreen extends StatelessWidget {
//   final double dailyTarget = 3.3;
//   final double bill = 25.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Energy Monitoring', style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // ✅ Replaced static UsageCard with StreamBuilder for live updates
//             StreamBuilder<LiveReading>(
//               stream: liveReadingStream(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Text('Error fetching live reading');
//                 } else if (snapshot.hasData) {
//                   final live = snapshot.data!;
//                   return UsageCard(
//                     dailyUsage: live.energy, // Using live power as dailyUsage
//                     target: dailyTarget,
//                     bill: bill,
//                   );
//                 } else {
//                   return Text('No data');
//                 }
//               },
//             ),
//             SizedBox(height: 20),

//             _buildButton(context, 'Live PF Monitoring', '/live', Colors.deepPurple),
//             SizedBox(height: 15),

//             _buildButton(context, 'High Usage Equipment', '/high_usage', Colors.redAccent),
//             SizedBox(height: 15),

//             _buildButton(context, 'Smart Suggestions', '/suggestions', Colors.blueAccent),
//             SizedBox(height: 15),

//             _buildButton(context, 'Prototype Info', '/prototype', Colors.green),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(BuildContext context, String text, String route, Color color) {
//     return GestureDetector(
//       onTap: () => Navigator.pushNamed(context, route),
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [color.withOpacity(0.8), color],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ✅ Stream to fetch live readings every 2 seconds
// Stream<LiveReading> liveReadingStream() async* {
//   while (true) {
//     final reading = await fetchLiveReading();
//     yield reading;
//     await Future.delayed(Duration(seconds: 2));
//   }
// }

// import 'package:flutter/material.dart';
// import '../widget/usage_card.dart';
// import '../models/live_reading.dart';
// import '../services/fetch_live_data.dart';

// class DashboardScreen extends StatelessWidget {
//   final double dailyTarget = 3.3; // Daily energy target (kWh)

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text(
//           'Energy Dashboard ⚡',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         elevation: 4,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: StreamBuilder<LiveReading>(
//           stream: liveReadingStream(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                   child: Padding(
//                       padding: EdgeInsets.all(50),
//                       child: CircularProgressIndicator()));
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   '⚠️ Error fetching live reading',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               );
//             } else if (!snapshot.hasData) {
//               return Center(child: Text('No live data available'));
//             }

//             final live = snapshot.data!;
//             final double bill = live.energy * 10; // 💰 Real-time bill
//             final double voltage = live.voltage;
//             final double current = live.current;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // ✅ Live Usage Summary Card
//                 UsageCard(
//                   dailyUsage: live.energy,
//                   target: dailyTarget,
//                   bill: bill,
//                 ),

//                 SizedBox(height: 20),

//                 // ✅ Voltage & Current Box
//                 Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [Colors.purpleAccent, Colors.deepPurple],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.deepPurple.withOpacity(0.3),
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       )
//                     ],
//                   ),
//                   padding: EdgeInsets.all(16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildMiniDataBox(Icons.flash_on, "Voltage", "${voltage.toStringAsFixed(1)} V"),
//                       _buildMiniDataBox(Icons.electric_bolt, "Current", "${current.toStringAsFixed(2)} A"),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 30),

//                 // ✅ Navigation Buttons
//                 _buildButton(context, 'Live PF Monitoring', '/live', Colors.deepPurple),
//                 SizedBox(height: 15),
//                 // ✅ Weekly Graph Button (ADDED)
//                 _buildButton(context, 'Weekly Energy Graph', '/weekly_graph', Colors.orangeAccent),
//                 SizedBox(height: 15),
//                 _buildButton(context, 'High Usage Equipment', '/high_usage', Colors.redAccent),
//                 SizedBox(height: 15),
//                 _buildButton(context, 'Smart Suggestions', '/suggestions', Colors.blueAccent),
//                 SizedBox(height: 15),
//                 _buildButton(context, 'Prototype Info', '/prototype', Colors.green),
//                 SizedBox(height: 25),

//                 // ✅ Daily Total Summary
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 8,
//                         offset: Offset(0, 4),
//                       )
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         "Today's Summary",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Energy Used: ${live.energy.toStringAsFixed(2)} kWh",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       Text(
//                         "Bill Estimate: ₹${bill.toStringAsFixed(2)}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.green[700],
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMiniDataBox(IconData icon, String label, String value) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 30),
//         SizedBox(height: 6),
//         Text(label, style: TextStyle(color: Colors.white70, fontSize: 13)),
//         SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//       ],
//     );
//   }

//   Widget _buildButton(BuildContext context, String text, String route, Color color) {
//     return GestureDetector(
//       onTap: () => Navigator.pushNamed(context, route),
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [color.withOpacity(0.8), color],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
//           ],
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//                 fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ✅ Stream for fetching live readings every 2 seconds
// Stream<LiveReading> liveReadingStream() async* {
//   while (true) {
//     final reading = await fetchLiveReading();
//     yield reading;
//     await Future.delayed(Duration(seconds: 2));
//   }
// }

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widget/usage_card.dart';
import '../models/live_reading.dart';
import '../services/fetch_live_data.dart';
import 'package:intl/intl.dart';

double calcUnits(double v, double i, double pf, double hours) {
  double power = v * i * pf; // Watt
  return (power * hours) / 1000; // kWh
}

double calcBill(double units) {
  if (units <= 100) {
    return units * 4.43;
  } else {
    return (100 * 4.43) + ((units - 100) * 9.64);
  }
}

class DashboardScreen extends StatelessWidget {
  final double dailyTarget = 3.3;
  final double monthLimit = 100;

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          'Energy Dashboard ⚡',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: StreamBuilder<LiveReading>(
          stream: liveReadingStream(),

          builder: (context, snapshot) {
            bool isOnline = false;

            if (snapshot.hasData) {
              final live = snapshot.data!;

              // Check real load condition
              if (live.current > 0.05 && live.voltage > 50) {
                isOnline = true;
              }
            }

            return FutureBuilder<_BackupData>(
              future: _getBackupData(),

              builder: (context, dbSnap) {
                // Always allow UI
                final backup = dbSnap.data ?? _BackupData.empty();

                // ================= DATA =================

                final live = snapshot.data;

                final energy = isOnline ? live!.energy : backup.energy;

                final voltage = isOnline ? live!.voltage : backup.voltage;

                final current = isOnline ? live!.current : backup.current;

                final double dailyUsage = isOnline ? (live?.energy ?? 0) : 0;

                final monthUsage = backup.month;

                final remaining = (monthLimit - monthUsage).clamp(
                  0,
                  monthLimit,
                );

                // final bill = energy * 0;
                // Assume home PF
                final double pf = isOnline ? (live?.pf ?? 0.95) : 0.95;

                // Units Prediction
                final unitPerHour = calcUnits(voltage, current, pf, 1);
                final unit10Hr = unitPerHour * 10;
                final unitDay = unitPerHour * 24;
                final unitMonth = unitDay * 30;

                // Bill Prediction
                final billHour = calcBill(unitPerHour);
                final billDay = calcBill(unitDay);
                final billMonth = calcBill(unitMonth);

                // ================= UI =================

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ===== STATUS CARD =====
                    Container(
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurple, Colors.purpleAccent],
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                isOnline ? "🟢 Online" : "🔴 Offline",

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),

                              Text(
                                "Remaining: ${remaining.toStringAsFixed(1)}",

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Text(
                            "Yesterday Units: ${backup.yesterday.toStringAsFixed(2)} kWh",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Month Total Units: ${monthUsage.toStringAsFixed(2)} kWh",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,

                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ===== USAGE CARD =====
                    UsageCard(
                      dailyUsage: unitDay,
                      target: dailyTarget,
                      bill: billDay,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 93, 93),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            "🔮 Usage Prediction",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "1 Hour: ${unitPerHour.toStringAsFixed(3)} units  | ₹${billHour.toStringAsFixed(1)}",
                          ),

                          Text(
                            "10 Hours: ${unit10Hr.toStringAsFixed(2)} units",
                          ),

                          Text(
                            "1 Day: ${unitDay.toStringAsFixed(2)} units  | ₹${billDay.toStringAsFixed(1)}",
                          ),

                          Text(
                            "Month: ${unitMonth.toStringAsFixed(1)} units  | ₹${billMonth.toStringAsFixed(0)}",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ===== VOLTAGE / CURRENT =====
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purpleAccent, Colors.deepPurple],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),

                      padding: const EdgeInsets.all(16),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          _miniBox(
                            Icons.flash_on,
                            "Voltage",
                            "${voltage.toStringAsFixed(1)} V",
                          ),

                          _miniBox(
                            Icons.electric_bolt,
                            "Current",
                            "${current.toStringAsFixed(2)} A",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    _btn(
                      context,
                      'Live PF Monitoring',
                      '/live',
                      Colors.deepPurple,
                    ),

                    const SizedBox(height: 15),

                    _btn(
                      context,
                      'Weekly Energy Graph',
                      '/weekly_graph',
                      Colors.orangeAccent,
                    ),

                    const SizedBox(height: 15),

                    _btn(
                      context,
                      'High Usage Equipment',
                      '/high_usage',
                      Colors.redAccent,
                    ),

                    const SizedBox(height: 15),

                    _btn(
                      context,
                      'Smart Suggestions',
                      '/suggestions',
                      Colors.blueAccent,
                    ),

                    const SizedBox(height: 15),

                    _btn(context, 'Prototype Info', '/prototype', Colors.green),

                    const SizedBox(height: 25),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _miniBox(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),

        const SizedBox(height: 5),

        Text(label, style: const TextStyle(color: Colors.white70)),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _btn(BuildContext ctx, String t, String r, Color c) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(ctx, r),

      child: Container(
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [c.withOpacity(.8), c]),
          borderRadius: BorderRadius.circular(16),
        ),

        child: Center(
          child: Text(
            t,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ================= STREAM =================

Stream<LiveReading> liveReadingStream() async* {
  while (true) {
    try {
      final r = await fetchLiveReading();
      yield r;
    } catch (_) {
      yield* const Stream.empty();
    }

    await Future.delayed(const Duration(seconds: 2));
  }
}

// ================= BACKUP DB =================
Future<_BackupData> _getBackupData() async {
  try {
    final supabase = Supabase.instance.client;
    final now = DateTime.now();

    // ===== TODAY RANGE =====
    final todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // ===== YESTERDAY RANGE =====
    final yesterday = now.subtract(const Duration(days: 1));

    final yesterdayStart = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
      0,
      0,
      0,
    );

    final yesterdayEnd = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
      23,
      59,
      59,
    );

    // ===== MONTH RANGE =====
    final monthStart = DateTime(now.year, now.month, 1, 0, 0, 0);
    final monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    // Convert to ISO (Supabase friendly)
    // String iso(DateTime d) => d.toIso8601String();
    String fmt(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

    // ===== TODAY DATA =====
    final todayRes = await supabase.rpc(
      'get_usage_by_range',
      // params: {'start_date': iso(todayStart), 'end_date': iso(todayEnd)},
      params: {'start_date': fmt(todayStart), 'end_date': fmt(todayEnd)},
    );

    double todaySum = 0;
    for (var d in todayRes) {
      todaySum += (d['total'] as num?)?.toDouble() ?? 0;
    }

    // ===== YESTERDAY DATA =====
    final yesterdayRes = await supabase.rpc(
      'get_usage_by_range',
      params: {
        'start_date': fmt(yesterdayStart),
        'end_date': fmt(yesterdayEnd),
      },
    );

    double yesterdaySum = 0;
    for (var d in yesterdayRes) {
      yesterdaySum += (d['total'] as num?)?.toDouble() ?? 0;
    }

    // ===== MONTH DATA =====
    final monthRes = await supabase.rpc(
      'get_usage_by_range',
      params: {'start_date': fmt(monthStart), 'end_date': fmt(monthEnd)},
    );

    double monthSum = 0;
    for (var d in monthRes) {
      monthSum += (d['total'] as num?)?.toDouble() ?? 0;
    }

    // ===== LAST LIVE DATA =====
    final last = await supabase
        .from('readings')
        .select('value')
        .order('reading_date', ascending: false)
        .limit(1);

    double e = 0, v = 0, c = 0;

    if (last.isNotEmpty) {
      final l = last.first;

      e = (l['value'] as num?)?.toDouble() ?? 0;
      v = (l['voltage'] as num?)?.toDouble() ?? 0;
      c = (l['current'] as num?)?.toDouble() ?? 0;
    }

    return _BackupData(
      yesterday: yesterdaySum, // ✅ USE YESTERDAY
      month: monthSum,
      energy: e,
      voltage: v,
      current: c,
    );
  } catch (e) {
    debugPrint("Dashboard DB Error: $e");

    return _BackupData.empty();
  }
}

// ================= MODEL =================

class _BackupData {
  final double yesterday; // ✅ NEW
  final double month;

  final double energy;
  final double voltage;
  final double current;

  _BackupData({
    required this.yesterday,
    required this.month,
    required this.energy,
    required this.voltage,
    required this.current,
  });

  factory _BackupData.empty() {
    return _BackupData(
      yesterday: 0,
      month: 0,
      energy: 0,
      voltage: 0,
      current: 0,
    );
  }
}
