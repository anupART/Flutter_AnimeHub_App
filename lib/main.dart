import 'package:animeapp/releasepage.dart';
import 'package:animeapp/serachpage.dart';
import 'package:animeapp/typography.dart';
import 'package:flutter/material.dart';

import 'color.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MainNavigationScreen()
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const ReleasePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: buttonColor,
        unselectedItemColor: unselected,
        backgroundColor: myPrimaryColor,
        selectedLabelStyle: FontClass.infoText,
        unselectedLabelStyle: FontClass.infoText,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Releases',
          ),
        ],
      ),
    );
  }
}
