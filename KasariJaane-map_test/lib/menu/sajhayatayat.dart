import 'package:flutter/material.dart';

class Sajhayatayat extends StatefulWidget {
  @override
  _SajhayatayatState createState() => _SajhayatayatState();
}

class _SajhayatayatState extends State<Sajhayatayat> {
  String _selectedBus = '';
  List<String> _busStops = [];
  String _selectedOption = 'Lamatar - New Bus Park';

  List<String> _options = [
    'Lamatar - New Bus Park',
    'Lagankhel - Budhanilkantha',
    'Lagankhel- New Bus Park',
    'Godawari- Machhapokhar',
  ];

  Map<String, List> _data = {
    'Lamatar - New Bus Park': [
      'Lamatar',
      'Dhungin',
      'Lubhu',
      'Sanagau',
      'Kamalpokhari',
      'Krishna Mandir',
      'KIST Hospital',
      'Gwarko',
      'BNB Hospital',
      'Satdobato',
      'Lagankhel',
      'Jawalakhel',
      'Pulchowk',
      'Kupondole',
      'Tripureshwor',
      'RNAC',
      'Jamal',
      'Lainchaur',
      'Teaching Hospital',
      'Narayan Gopal Chowk',
      'Samakhusi',
      'New Bus Park'
    ],
    'Lagankhel - Budhanilkantha': [
      'Lagankhel',
      'Kumaripati',
      'Jawalakhel',
      'Pulchowk',
      'Kupondole',
      'Tripureshwor',
      'Nepal Wayu Sewa',
      'Jamal',
      'Lainchaur',
      'Lazimpat',
      'Panipokhari',
      'Rastrapati Bhawan',
      'Teaching Hospital',
      'Narayan Gopal Chowk',
      'Gangalal Hospital',
      'Neuro Hospital',
      'Goulfutar',
      'Telecom Chowk',
      'Hattigauda',
      'Chapli',
      'Deuba Chowk',
      'Budhanilkantha'
    ],
    'Lagankhel- New Bus Park': [
      'Lagankhel',
      'Kumaripati',
      'Jawalakhel',
      'Pulchowk',
      'Kupondole',
      'Tripureshwor',
      'Nepal Wayu Sewa',
      'Jamal',
      'Lainchaur',
      'Lazimpat',
      'Panipokhari',
      'Rastrapati Bhawan',
      'Teaching Hospital',
      'Narayan Gopal Chowk',
      'Samakhusi',
      'New Bus Park'
    ],
    'Godawari - Machhapokhari': [
      'Godawari',
      'Taukhel',
      'Hadegaun',
      'Badegaun',
      'Thaiba',
      'Harisiddhi',
      'Hattiban',
      'Khumaltar',
      'Satdobato',
      'Jawalakhel',
      'Pulchowk',
      'Kupondole',
      'Tripureshwor',
      'RNAC',
      'Jamal',
      'Lainchaur',
      'Sorhakhutte',
      'Lagankhel',
      'Naya Bazar',
      'Balaju Chowk',
      'Machhapokhari'
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
