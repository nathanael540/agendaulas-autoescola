import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/home_controller.dart';
import 'views/home_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
      ],
      child: Home(),
    );
  }
}
