import 'package:flutter/material.dart';
import 'package:wifi_switch/switch_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WiFi Switch',
      initialRoute: SwitchScreen.routeID,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        SwitchScreen.routeID: (context) => SwitchScreen(),
      },
    );
  }
}