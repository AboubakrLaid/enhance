// import 'package:enhance/home.dart';
import 'package:enhance/refresh.dart';
import 'package:enhance/refresh_button.dart';
import 'package:enhance/transform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Refresh()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RefreshButton()
      ),
    );
  }
}
