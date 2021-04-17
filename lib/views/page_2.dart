import 'package:flutter/material.dart';

class P2 extends StatelessWidget {
  const P2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: '',
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        return Container();
      },
    );
  }
}
