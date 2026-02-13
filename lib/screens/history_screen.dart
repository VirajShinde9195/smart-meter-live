import 'package:flutter/material.dart';
import '../services/fetch_supabase_data.dart';
import '../models/uses_record.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<UsageRecord>> futureRecords;

  @override
  void initState() {
    super.initState();
    futureRecords = fetchUsageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: FutureBuilder<List<UsageRecord>>(
        future: futureRecords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No records found'));
          }

          final records = snapshot.data!;
          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: const Color(0xFF2A2A3C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  title: Text(
                    record.type.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    'Start: ${record.startDate ?? 'N/A'}\n'
                    'End: ${record.endDate ?? 'N/A'}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Text(
                    record.units != null
                        ? '${record.units!.toStringAsFixed(2)} kWh'
                        : '0.00 kWh',
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
