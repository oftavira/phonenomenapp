// @dart=2.9
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phonenomenapp/local_widgets/drawer.dart';
import 'package:phonenomenapp/navigation/navigation_service.dart';
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

void main() {
  // Registramos los servicios que utilizaremos a través de locator (GetIt.instance)
  setUpLocator();

  // App
  runApp(MyApp());

  // En la documentacion se señala que se debe añadir workmanager a los
  // canales de entrada de flutter
  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = locator<AppNavigator>().scaffoldKey;
  final _navigatorKey = locator<AppNavigator>().navKey;
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
