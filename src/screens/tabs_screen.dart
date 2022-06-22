import 'package:flutter/material.dart';
import 'package:news_app/src/providers/ui_provider.dart';
import 'package:news_app/src/screens/tab1_screen.dart';
import 'package:news_app/src/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Pages(),
      bottomNavigationBar: _NavigationBottomBar(),
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<UIProvider>(context);
    return PageView(
      controller: bottomProvider.controller,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _NavigationBottomBar extends StatelessWidget {
  const _NavigationBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<UIProvider>(context);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: BottomNavigationBar(
            onTap: (value) => bottomProvider.selectedMenuOpt = value,
            currentIndex: bottomProvider.selectedMenuOpt,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'For you'),
              BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Headers'),
            ]),
      ),
    );
  }
}
