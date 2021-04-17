// El objetivo de este archivo es estructurar
// algunas funcionalidades que podrían ser utiles en futuros proyectos
// relacionadas principalmente con dos caracteristicas
//
//    + Ejecutar codigo nativo en android utilizando kotlin
//    + Ejecutar codigo en segundo plano
//    + Ejecutar funciones relacionadas con el telefono como son
//      - Marcacion de un numero
//      - Lectura de contactos
//      - Lectura de historial de llamadas
//
// La motivacion principal, es encontrar la manera de incluir servicios
// de escucha de estados de las llamadas y accionar una aplicacion en
// caso de que un evento ocurra. Como se detalla en algunas de las paqueterías
// utilizadas aqui, existen limitaciones para el SDK flutter, por lo que en
// algun punto se debe entrar en el terreno de plugins y codigo nativo

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_phone_state/flutter_phone_state.dart';
import 'package:flutter_contact/contact.dart';
import 'package:flutter_contact/contacts.dart';

// # Dependencias en pubspec.yaml
//
// dependencies:
//   flutter_contact: ^0.6.1
//   flutter_phone_state: ^0.5.8
//   call_log: ^3.0.2
//   workmanager: ^0.2.4

class FlutterPhoneUtils {
  String id;
  FlutterPhoneUtils(this.id);

  //  Relacionados con flutter_contact
  //
  //  TODO probar las funciones comentadas

  // await Contacts.addContact(newContact);

  // // Delete a contact
  // // The contact must have a valid identifier
  // await Contacts.deleteContact(contact);

  // // Update a contact
  // // The contact must have a valid identifier
  // await Contacts.updateContact(contact);

  // /// Lazily fetch avatar data without caching it in the contact instance.
  // final contact = Contacts.getContact(contactId);
  // final Uint8List avatarData = await contact.getOrFetchAvatar();

  /// Retorna un stream con el contacto buscado

  Stream<Contact> query(String name) {
    return Contacts.streamContacts(query: name);
  }

  /// Retorna un stream con los contactos existentes

  Stream<Contact> contacts() {
    return Contacts.streamContacts();
  }

  /// TODO Probar este metodo

  Stream<Contact> woThumbnails() {
    return Contacts.streamContacts(withThumbnails: false);
  }

  // Relacionado a flutter_phone_state

  /// Eventos relacionados a llamadas, la limitacion es que solo
  /// funciona si la app esta en primer plano

  Stream<PhoneCallEvent> phoneCallEvents() {
    return FlutterPhoneState.phoneCallEvents.asBroadcastStream();
  }

  /// Establece un numero de entrada en el sistema operativo, pero no
  /// lo marca, debe tener 10 digitos ej: "55 25 45 78 69"

  PhoneCall dialNumber(String number) {
    return FlutterPhoneState.startPhoneCall(number);
  }

  /// Relacionado con los servicios plugin
  /// TODO: Probar la libreria Pigeon, la cual señala que utiliza metodos
  /// de entrada libres de errores type entre el intercambio de informacion
  /// del HOST (android, ios) a Flutter
  ///
  /// La inclusion de este codigo esta relacionada con el archivo
  /// ./android/app/src/main/kotlin/com/example/'appname'/MainActivity.kt
  /// donde se debe definir la funcion que se ejecutara en el HOST

  static const platform = const MethodChannel('samples.flutter.dev/battery');

  Future<String> getBatteryLevel() async {
    String _batteryLevel = 'Unknown battery level.';

    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      _batteryLevel = 'Battery level at $result % .';
      print(result);
    } on PlatformException catch (e) {
      _batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    return _batteryLevel;
  }
}

// Añadir este codigo a la ruta  ./android/app/src/main/kotlin/com/example/phonenomenapp

// package com.example.phonenomenapp

// import android.content.Context
// import android.content.ContextWrapper
// import android.content.Intent
// import android.content.IntentFilter
// import android.os.BatteryManager
// import android.os.Build.VERSION
// import android.os.Build.VERSION_CODES
// import androidx.annotation.NonNull
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
// import io.flutter.plugin.common.MethodChannel

// class MainActivity: FlutterActivity() {
//   private val CHANNEL = "samples.flutter.dev/battery"

//   override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//     super.configureFlutterEngine(flutterEngine)


//     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//       // Note: this method is invoked on the main thread.
//       call, result ->
//       if (call.method == "getBatteryLevel") {
//         val batteryLevel = getBatteryLevel()

//         if (batteryLevel != -1) {
//           result.success(batteryLevel)
//         } else {
//           result.error("UNAVAILABLE", "Battery level not available.", null)
//         }
//       } else {
//         result.notImplemented()
//       }
//     }

//   }

//   private fun getBatteryLevel(): Int {
//     val batteryLevel: Int
//     if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//       val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//       batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//     } else {
//       val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
//       batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
//     }

//     return batteryLevel
//   }

// }