import 'package:flutter/material.dart';


class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.notifications),
            ),
            title: Text('Notification $index'),
            subtitle: Text('This is a notification'),
            trailing: Text('1h ago'),
            onTap: () {
              // Add your code to handle the tap here
            },
          );
        },
      ),
    );
  }
}

