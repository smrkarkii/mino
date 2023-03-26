import 'package:flutter/material.dart';

class NepalYatayat extends StatefulWidget {
  @override
  _NepalYatayatState createState() => _NepalYatayatState();
}

class _NepalYatayatState extends State<NepalYatayat> {
  String _selectedBus = '';
  List<String> _busStops = [];
  String _selectedOption = 'Lamatar';

  List<String> _options = ['Balkumari-Sukedhara'];

  Map<String, List> _data = {
    'Balkumari-Sukedhara': [
      'Balkumari',
      'Koteshwor',
      'Minbhawan',
      'Civil',
      'New Baneshwor',
      'Thapagaun',
      'Hanumansthan',
      'Anamnagar',
      'New Plaza',
      'Putali Sadak',
      'Kamladi',
      'Nagapokhari',
      'Naksal',
      'Bal Mandir',
      'Tangal',
      'Bhatbhateni',
      'Baluwatar',
      'Pabitra Workshop',
      'Talim Kendra',
      'Teaching Hospital',
      'Chakrapath',
      'Dhumbarahi',
      'Tinkune',
      'Chappal Karkhana',
      'Sukedhara'
    ],
  };

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
      _busStops = _data[_selectedOption]![0];
      _selectedBus = '';
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _selectedOption,
              onChanged: (val) {
                setState(() {
                  _selectedOption = val.toString();
                  _busStops = _data[_selectedOption]![1];
                  _selectedBus = '';
                });
              },
              items: _options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(_busStops.isNotEmpty ? _busStops[0] : ''),
            // _busStops.map((robusute) => Text(bus))
          ],
        ),
      ),
    );
  }
}
