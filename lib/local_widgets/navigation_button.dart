import 'package:flutter/material.dart';
import 'package:phonenomenapp/navigation/navigation_service.dart';

/// Requiere de dos parametros `String`, [route] contiene la ruta
/// y [text] sera el texto mostrado por este boton

// TODO: Ajustar el tamaño del `Container` segun el tamaño del dispositivo
// TODO: Definir el color segun la paleta de colores de la app

class NavigateTo extends StatelessWidget {
  final String route;
  final String text;
  const NavigateTo({Key key, this.route, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 60,
        width: 150,
        color: Colors.yellow[100],
        child: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ),
      onTap: () {
        locator<AppNavigator>().navKey.currentState.pushNamed(route);
      },
    );
  }
}
