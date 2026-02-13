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


import 'package:flutter/material.dart';
import '../widget/usage_card.dart';
import '../models/live_reading.dart';
import '../services/fetch_live_data.dart';

class DashboardScreen extends StatelessWidget {
  final double dailyTarget = 3.3; // Daily energy target (kWh)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Energy Dashboard ⚡',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<LiveReading>(
          stream: liveReadingStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Padding(
                      padding: EdgeInsets.all(50),
                      child: CircularProgressIndicator()));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '⚠️ Error fetching live reading',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(child: Text('No live data available'));
            }

            final live = snapshot.data!;
            final double bill = live.energy * 10; // 💰 Real-time bill
            final double voltage = live.voltage;
            final double current = live.current;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ✅ Live Usage Summary Card
                UsageCard(
                  dailyUsage: live.energy,
                  target: dailyTarget,
                  bill: bill,
                ),

                SizedBox(height: 20),

                // ✅ Voltage & Current Box
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purpleAccent, Colors.deepPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniDataBox(Icons.flash_on, "Voltage", "${voltage.toStringAsFixed(1)} V"),
                      _buildMiniDataBox(Icons.electric_bolt, "Current", "${current.toStringAsFixed(2)} A"),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // ✅ Navigation Buttons
                _buildButton(context, 'Live PF Monitoring', '/live', Colors.deepPurple),
                SizedBox(height: 15),
                // ✅ Weekly Graph Button (ADDED)
                _buildButton(context, 'Weekly Energy Graph', '/weekly_graph', Colors.orangeAccent),
                SizedBox(height: 15),
                _buildButton(context, 'High Usage Equipment', '/high_usage', Colors.redAccent),
                SizedBox(height: 15),
                _buildButton(context, 'Smart Suggestions', '/suggestions', Colors.blueAccent),
                SizedBox(height: 15),
                _buildButton(context, 'Prototype Info', '/prototype', Colors.green),
                SizedBox(height: 25),

                // ✅ Daily Total Summary
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Today's Summary",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Energy Used: ${live.energy.toStringAsFixed(2)} kWh",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Bill Estimate: ₹${bill.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildMiniDataBox(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        SizedBox(height: 6),
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 13)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, String route, Color color) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// ✅ Stream for fetching live readings every 2 seconds
Stream<LiveReading> liveReadingStream() async* {
  while (true) {
    final reading = await fetchLiveReading();
    yield reading;
    await Future.delayed(Duration(seconds: 2));
  }
}
