import 'package:flutter/material.dart';

import '../components/constants.dart';

class DriverPage extends StatefulWidget {
  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  String _selectedVehicleType = 'Bus';

  final _vehicleIdController = TextEditingController();
  final _startingPointController = TextEditingController();
  final _destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              textfield('Vehicle ID', _vehicleIdController),
              SizedBox(height: 16.0),
              textfield('Starting Point', _startingPointController),
              SizedBox(height: 16.0),
              textfield('Destination', _destinationController),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // start travel logic here
                },
                child: Text('Start Travel'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // stop travel logic here
                },
                child: Text('Stop Travel'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // stop travel logic here
                  Navigator.pop(context);
                },
                child: Text('View as normal user.'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField textfield(label, controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: klightpurple),
        fillColor: kwhite,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kblack),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kblack),
        ),
      ),
    );
  }
}
