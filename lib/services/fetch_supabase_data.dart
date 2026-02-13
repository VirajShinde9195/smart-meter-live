import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/uses_record.dart';

Future<List<UsageRecord>> fetchUsageData() async {
  final supabase = Supabase.instance.client;

  // ✅ Fetch data safely from Supabase table
  final List<dynamic> response = await supabase
      .from('readings')
      .select('type, start_date, end_date, units')
      .order('start_date', ascending: false);

  // ✅ Convert rows to UsageRecord objects
  return response
      .map((item) => UsageRecord.fromJson(item as Map<String, dynamic>))
      .toList();
}
