import 'package:flutter/material.dart';
import 'package:phonenomenapp/local_widgets/navigation_button.dart';

// TODO: Mejorar la presentacion, alineacion, color, fuente etc.

/// Un drawer basico para la aplicacion, se incluye en el una lista de botones
/// creados con NavigateTo

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
