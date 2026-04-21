import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class MainWrapper extends StatefulWidget {
  final String userName;
  const MainWrapper({Key? key, required this.userName}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  late String firstName;
  String lastName = "";
  String email = "user@contoh.com";
  String password = "password123";

  @override
  void initState() {
    super.initState();
    firstName = widget.userName;
  }

  void updateProfileData(
    String newFirst,
    String newLast,
    String newEmail,
    String newPass,
  ) {
    setState(() {
      firstName = newFirst;
      lastName = newLast;
      email = newEmail;
      password = newPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(userName: firstName),
      const SearchScreen(),
      ProfileScreen(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        onProfileChanged: updateProfileData,
      ),
    ];

    return Scaffold(
      extendBody: true,

      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F005C).withOpacity(0.9),
          border: const Border(
            top: BorderSide(color: Colors.white10, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
