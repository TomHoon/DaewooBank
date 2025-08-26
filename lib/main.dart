import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = "Fetching token...";

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.requestPermission(); // ask notification permission

    FirebaseMessaging.instance.getToken().then((t) {
      setState(() => token = t ?? "No token");
      print("FCM Token: $t");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple FCM Demo")),
      body: Center(
        child: SelectableText(token),
      ),
    );
  }
}
