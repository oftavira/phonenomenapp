// @dart=2.9
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phonenomenapp/navigation_service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:get_it/get_it.dart';

// La funcion callbackDispatcher se añade como top-level para que
// flutter la reconozca al ejecutarse en segundo plano, notemos que
// Workmanage.executetask ejecuta

// TODO tomar esta referencia y ejecutar alguna otra tarea en background

void callbackDispatcher() {
  Workmanager.executeTask((dynamic task, dynamic inputData) async {
    print('Background Services are Working!');
    try {
      final Iterable<CallLogEntry> cLog = await CallLog.get();
      print('Queried call log entries');
      for (CallLogEntry entry in cLog) {
        print('-------------------------------------');
        print('F. NUMBER  : ${entry.formattedNumber}');
        print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
        print('NUMBER     : ${entry.number}');
        print('NAME       : ${entry.name}');
        print('TYPE       : ${entry.callType}');
        print(
            'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp)}');
        print('DURATION   : ${entry.duration}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('ACCOUNT ID : ${entry.phoneAccountId}');
        print('SIM NAME   : ${entry.simDisplayName}');
        print('-------------------------------------');
      }
      return true;
    } on PlatformException catch (e, s) {
      print(e);
      print(s);
      return true;
    }
  });
}

// Creacion de un sistema de rutas sencillo para organizar las utilidades

GetIt getIt = GetIt.instance;

void main() {
  runApp(MyApp());

  getIt.registerLazySingleton(() => AppNavigator());

  // En la documentacion se señala que se debe añadir workmanager a los
  // canales de entrada de flutter
  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
}

/// example widget for call log plugin
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = getIt<AppNavigator>().scaffoldKey;
  final _navigatorKey = getIt<AppNavigator>().navKey;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        drawer: BasicDrawer(),
        appBar: AppBar(
          title: const Text('call_log example'),
        ),
        body: Navigator(
          key: _navigatorKey,
          initialRoute: '/home',
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}

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
        getIt<AppNavigator>().navKey.currentState.pushNamed(route);
      },
    );
  }
}

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