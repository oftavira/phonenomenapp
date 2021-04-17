import 'package:flutter/material.dart';
import 'package:phonenomenapp/local_widgets/navigation_button.dart';

class BasicDrawer extends StatelessWidget {
  const BasicDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NavigateTo(text: 'Pagina 1', route: '/pagina1'),
          NavigateTo(text: 'Pagina 1', route: '/pagina2'),
        ],
      ),
    );
  }
}
