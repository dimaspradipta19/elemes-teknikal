import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/view/menu/movie/movie_screen.dart';
import 'package:technical_elemes/view/menu/tv/tv_screen.dart';
import 'package:technical_elemes/viewmodel/provider/navigationbar_provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final List<Widget> _widgetOption = [
    const MovieScreen(),
    const TvScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationBarProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.movie, color: Colors.black),
            icon: Icon(Icons.movie, color: Colors.grey[350]),
            label: "Movie",
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.tv, color: Colors.black),
            icon: Icon(Icons.tv, color: Colors.grey[350]),
            label: "TV",
          ),
        ],
        selectedItemColor: const Color(0XFF123C69),
        selectedFontSize: 12.0,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.grey[350]),
        unselectedItemColor: const Color(0XFF597796),
        currentIndex: provider.selectedIndex,
        onTap: (index) {
          provider.getSelectedIndex = index;
        },
      ),
      body: _widgetOption[provider.selectedIndex],
    );
  }
}
