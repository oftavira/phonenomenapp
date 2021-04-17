import 'package:flutter/material.dart';

class P1 extends StatelessWidget {
  const P1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              child: Container(),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
