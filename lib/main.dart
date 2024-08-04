import 'package:flutter/material.dart';
import './pages/home.dart';
import './pages/webview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/webview': (context) => WebViewPage(),
      },
    );
  }
}
