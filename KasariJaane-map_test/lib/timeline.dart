import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kasarijaane/components/constants.dart';

List<Color> colors = [ktheme, kdarkblue, Colors.pinkAccent];

class Timeline extends StatefulWidget {
  Timeline({
    Key? key,
    required this.processCard,
  }) : super(key: key);

  final List processCard;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    List processCard = widget.processCard;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: processCard.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                width: 2,
                                height: 60,
                                color: index == 0 ? kwhite : kyellow,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: index == 0 ||
                                            index == (processCard.length - 1)
                                        ? kdarkblue
                                        : colors[0],
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              Container(
                                width: 2,
                                height: 60,
                                color: index == (processCard.length - 1)
                                    ? kwhite
                                    : kyellow,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.black26,
                                  )
                                ]),
                            height: 70,
                            width: 120,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    processCard[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: colors[0],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
