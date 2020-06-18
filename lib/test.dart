import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'api_callers/get.dart';
import 'models/user_location.dart';
import 'screens/under_construction/color.dart';
import 'screens/under_construction/jobs.dart';
import 'screens/under_construction/news.dart';
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String quote;
  int _selectedIndex = 0;
  final pageOption = [Color() , News(), Jobs()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.color_lens),title: Text('')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.newspaper),title: Text('News')),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.book),title: Text('Jobs')),
      ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
      ),
    body: pageOption[_selectedIndex],
    );
  }


  aboutDialog(){
    showAboutDialog(
      context: context,
      applicationVersion: '1.0.0',
      applicationLegalese: 'Ogive',
      applicationIcon: Image.asset('assets/images/ogive_version_2.png',fit: BoxFit.scaleDown,height: 40,width: 40,),
    );
  }
}
