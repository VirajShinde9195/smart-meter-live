import 'package:flutter/material.dart';

class HighUsageScreen extends StatefulWidget {
  @override
  _HighUsageScreenState createState() => _HighUsageScreenState();
}

class _HighUsageScreenState extends State<HighUsageScreen> {
  final Map<String, String> applianceData = {
    "Fan": "70",
    "Tube Light": "40",
    "AC (1 Ton)": "1500",
    "Fridge": "150",
    "TV": "100",
    "Mixer": "500",
    "Washing Machine": "500",
    "Computer": "200",
    "Pump": "750",
    "Charger": "10",
    "Iron": "1000",
    "Water Heater / Geyser": "2000",
    "Induction Cooker": "2000",
    "LED Bulb": "9",
    "Laptop": "65",
  };

  String searchQuery = "";
  String? selectedAppliance;
  final TextEditingController wattController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    final filteredAppliances = applianceData.keys
        .where((name) => name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Appliance Power Info")),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search appliance...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // 📋 Appliance List
          Expanded(
            child: ListView.builder(
              itemCount: filteredAppliances.length,
              itemBuilder: (context, index) {
                final applianceName = filteredAppliances[index];
                final power = applianceData[applianceName] ?? "N/A";
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(
                      Icons.electrical_services,
                      color: Colors.deepPurple,
                    ),
                    title: Text(applianceName),
                    subtitle: Text("Power: $power W"),
                  ),
                );
              },
            ),
          ),

          // ⚡ Calculator Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Energy Consumption Calculator",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // 🔽 Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select Appliance",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedAppliance,
                  items: applianceData.keys.map((String appliance) {
                    return DropdownMenuItem<String>(
                      value: appliance,
                      child: Text(appliance),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedAppliance = value;
                      if (value != null) {
                        wattController.text = applianceData[value]!;
                      }
                    });
                  },
                ),
                SizedBox(height: 10),

                TextField(
                  controller: wattController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Watt (e.g. 1000)",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: hoursController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Hours used",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final watt = double.tryParse(wattController.text) ?? 0;
                    final hours = double.tryParse(hoursController.text) ?? 0;
                    final units = (watt * hours) / 1000;

                    setState(() {
                      result =
                          "This appliance used approx ${units.toStringAsFixed(2)} units.";
                    });
                  },
                  child: Text("Calculate" ),
                ),
                SizedBox(height: 10),
                if (result.isNotEmpty)
                  Text(
                    result,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
