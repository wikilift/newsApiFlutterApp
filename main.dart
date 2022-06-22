import 'package:flutter/material.dart';
import 'package:news_app/src/providers/ui_provider.dart';
import 'package:news_app/src/screens/screens.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UIProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomeScreen(),
        },
        theme: myTheme,
      ),
    );
  }
}
