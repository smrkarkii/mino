import 'package:flutter/material.dart';
import 'constants.dart';
import '../searchresult.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key? key, required this.label}) : super(key: key);
  String label;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late String _query;

  @override
  void initState() {
    super.initState();
    _query = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kwhite,
        border:
            Border.all(color: _query == null ? Colors.red : Colors.transparent),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: kblack,
          ),
          hintText: widget.label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16.0),
          // suffixIcon: Icon(
          //   Icons.tune,
          //   color: kdarkpurple,
          // ),
        ),
        onSubmitted: (query) {
          if (query.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Please enter a ${widget.label}.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            setState(() {
              _query = query;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultPage(
                    query: _query,
                  ),
                ),
              );
            });
          }
        },
      ),
    );
  }
}
