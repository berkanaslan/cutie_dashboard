import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final Color statusColor = Color(0xFFFAFCFD);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusColor,
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cutie Dashboard",
      home: MenuDashboard(),
    );
  }
}
