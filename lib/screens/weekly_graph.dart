import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class WeeklyGraph extends StatefulWidget {
  const WeeklyGraph({super.key});

  @override
  State<WeeklyGraph> createState() => _WeeklyGraphState();
}

class _WeeklyGraphState extends State<WeeklyGraph> {
  List<Map<String, dynamic>> weeklyData = [];

  bool loading = true;
  String errorMsg = "";

  // Supabase
  final String supabaseUrl =
      "https://daomjbawryhkobgbhgeh.supabase.co/rest/v1/rpc/get_week_usage_by_range";

  final String anonKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRhb21qYmF3cnloa29iZ2JoZ2VoIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1ODEzNjAyNiwiZXhwIjoyMDczNzEyMDI2fQ.LnfIHVCJmLeWiq6Te4GyuU2OkgW2AXDZltU4SUHmRKo";

  // UI State
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int selectedWeek = 1;

  final List<String> weeks = [
    "1st Week",
    "2nd Week",
    "3rd Week",
    "4th Week",
    "5th Week",
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // ====================================
  // Get Week Range
  // ====================================
  Map<String, String> getWeekRange() {
    DateTime firstDay = DateTime(selectedYear, selectedMonth, 1);

    int startDay = (selectedWeek - 1) * 7 + 1;
    int endDay = startDay + 6;

    DateTime start = DateTime(selectedYear, selectedMonth, startDay);

    DateTime end = DateTime(selectedYear, selectedMonth, endDay);

    if (start.month != selectedMonth) {
      start = firstDay;
    }

    if (end.month != selectedMonth) {
      end = DateTime(selectedYear, selectedMonth + 1, 0);
    }

    return {
      "start": DateFormat("yyyy-MM-dd").format(start),
      "end": DateFormat("yyyy-MM-dd").format(end),
    };
  }

  // ====================================
  // Fetch Data
  // ====================================
  Future<void> fetchData() async {
    setState(() {
      loading = true;
      errorMsg = "";
    });

    try {
      final range = getWeekRange();

      final res = await http
          .post(
            Uri.parse(supabaseUrl),
            headers: {
              "apikey": anonKey,
              "Authorization": "Bearer $anonKey",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "start_date": range['start'],
              "end_date": range['end'],
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);

        weeklyData = List<Map<String, dynamic>>.from(decoded);
      } else {
        errorMsg = "Server Error ${res.statusCode}";
      }
    } catch (e) {
      errorMsg = "Network Error";
    }

    setState(() {
      loading = false;
    });
  }

  // ====================================
  // UI
  // ====================================
  @override
  Widget build(BuildContext context) {
    final range = getWeekRange();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weekly Energy Report"),
        backgroundColor: Colors.deepPurple,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg.isNotEmpty
          ? Center(
              child: Text(errorMsg, style: const TextStyle(color: Colors.red)),
            )
          : Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                children: [
                  // =====================
                  // Filters
                  // =====================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      // Month
                      DropdownButton<int>(
                        value: selectedMonth,

                        items: List.generate(12, (i) {
                          return DropdownMenuItem(
                            value: i + 1,
                            child: Text(
                              DateFormat.MMMM().format(DateTime(0, i + 1)),
                            ),
                          );
                        }),

                        onChanged: (v) {
                          selectedMonth = v!;
                          fetchData();
                        },
                      ),

                      // Week
                      DropdownButton<int>(
                        value: selectedWeek,

                        items: List.generate(5, (i) {
                          return DropdownMenuItem(
                            value: i + 1,
                            child: Text(weeks[i]),
                          );
                        }),

                        onChanged: (v) {
                          selectedWeek = v!;
                          fetchData();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // =====================
                  // White Info Box
                  // =====================
                  buildRangeCard(range['start']!, range['end']!),

                  const SizedBox(height: 15),

                  // =====================
                  // Summary
                  // =====================
                  buildSummary(),

                  const SizedBox(height: 20),

                  // =====================
                  // Chart
                  // =====================
                  SizedBox(height: 320, child: BarChart(buildChart())),
                ],
              ),
            ),
    );
  }

  // ====================================
  // White Range Card
  // ====================================
  Widget buildRangeCard(String start, String end) {
    double total = 0;

    for (var d in weeklyData) {
      total += double.tryParse(d['total'].toString()) ?? 0;
    }

    return Card(
      color: const Color.fromARGB(255, 237, 178, 119),
      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            infoItem("Start", start),
            infoItem("End", end),
            infoItem("Total", "${total.toStringAsFixed(2)} kWh"),
          ],
        ),
      ),
    );
  }

  Widget infoItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 4),

        Text(value, style: const TextStyle(color: Colors.black87)),
      ],
    );
  }

  // ====================================
  // Summary Card
  // ====================================
  Widget buildSummary() {
    double total = 0;

    for (var d in weeklyData) {
      total += double.tryParse(d['total'].toString()) ?? 0;
    }

    double avg = weeklyData.isEmpty ? 0 : total / weeklyData.length;

    return Card(
      color: const Color.fromARGB(255, 245, 179, 113),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            summaryItem(
              "Total Units :${total.toStringAsFixed(2)} kWh",
              "Sum of all daily usage",
            ),

            summaryItem(
              "Average : ${avg.toStringAsFixed(2)} kWh",
              "Per day usage",
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

        const SizedBox(height: 5),

        Text(
          value,
          style: const TextStyle(
            color: Color.fromARGB(255, 55, 10, 132),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ====================================
  // Chart
  // ====================================
  BarChartData buildChart() {
    List<BarChartGroupData> bars = [];

    for (int i = 0; i < weeklyData.length; i++) {
      double v = double.tryParse(weeklyData[i]['total'].toString()) ?? 0;

      bars.add(
        BarChartGroupData(
          x: i,

          barRods: [
            BarChartRodData(
              toY: v,
              width: 22,

              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),

              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
      );
    }

    return BarChartData(
      maxY: getMaxY(),

      barGroups: bars,

      gridData: FlGridData(show: true),

      borderData: FlBorderData(show: false),

      titlesData: buildTitles(),

      barTouchData: BarTouchData(
        enabled: true,

        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.black,

          getTooltipItem: (g, i, rod, index) {
            return BarTooltipItem(
              "${rod.toY.toStringAsFixed(2)} kWh",
              const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }

  // ====================================
  // Max Y
  // ====================================
  double getMaxY() {
    double max = 0;

    for (var d in weeklyData) {
      double v = double.tryParse(d['total'].toString()) ?? 0;

      if (v > max) max = v;
    }

    return max + 2;
  }

  // ====================================
  // Titles (No 0 1 2 Problem)
  // ====================================
  FlTitlesData buildTitles() {
    return FlTitlesData(
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false, reservedSize: 0),
      ),

      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: true, reservedSize: 45),
      ),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,

          getTitlesWidget: (value, meta) {
            int i = value.toInt();

            if (i < weeklyData.length) {
              DateTime d = DateTime.parse(weeklyData[i]['day']);

              return Text(
                DateFormat("dd/MM").format(d),
                style: const TextStyle(fontSize: 11),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
