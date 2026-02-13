class UsageRecord {
  final String type;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? units; // Energy usage in kWh

  UsageRecord({
    required this.type,
    this.startDate,
    this.endDate,
    this.units,
  });

  factory UsageRecord.fromJson(Map<String, dynamic> json) {
    return UsageRecord(
      type: json['type'] ?? '',
      startDate: json['start_date'] != null
          ? DateTime.tryParse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'])
          : null,
      units: json['units'] != null
          ? double.tryParse(json['units'].toString())
          : null,
    );
  }
}
