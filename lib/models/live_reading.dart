class LiveReading {
  final DateTime time;
  final double voltage;
  final double current;
  final double pf;
  final double energy;

  LiveReading({
    required this.time,
    required this.voltage,
    required this.current,
    required this.pf,
    required this.energy,
  });

  factory LiveReading.fromJson(Map<String, dynamic> json) {
    return LiveReading(
      time: DateTime.parse(json['time']),
      voltage: json['voltage'].toDouble(),
      current: json['current'].toDouble(),
      pf: json['pf'].toDouble(),
      energy: json['energy'].toDouble(),
    );
  }

  // 👇 Add this getter to support 'createdAt' usage
  DateTime get createdAt => time;
}
