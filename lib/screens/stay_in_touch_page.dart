import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ogive/custom_widgets/card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pedantic/pedantic.dart';

class StayInTouchPage extends StatefulWidget {
  @override
  _StayInTouchPageState createState() => _StayInTouchPageState();
}

class _StayInTouchPageState extends State<StayInTouchPage> {
  int _selectedIndex = 0;
  final pageOption = ["StayInTouch", "Home", "ReportProblem"];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.popAndPushNamed(context, pageOption[_selectedIndex]);
    });
  }

  Future<void> _launchURL(String url) async {
    String fbProtocolUrl = "fb://page/716275428808273";
    try {
      bool launched = await launch(fbProtocolUrl,
          forceSafariVC: false, universalLinksOnly: true);
      if (!launched) {
        await launch(url, forceSafariVC: false);
      }
    } catch (e) {
      await launch(url, forceSafariVC: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), title: Text('Stay in touch')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('Home')),
//          BottomNavigationBarItem(icon: Icon(Icons.email), title: Text('Contact Us'))
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
            appBar: AppBar(
              centerTitle: true,
              title: Text('Our Society'),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
//                    Container(
//                      decoration: BoxDecoration(
//                          gradient: LinearGradient(
//                              colors: [Colors.blueAccent, Colors.pinkAccent])),
//                      child: GestureDetector(
//                        onTap: () {
//                          _launchURL('https://www.facebook.com/ogive23/');
//                        },
//                        child: Card(
//                          elevation: 3,
//                          child: Column(
//                            mainAxisSize: MainAxisSize.min,
//                            children: <Widget>[
//                              ListTile(
//                                leading: FaIcon(
//                                  FontAwesomeIcons.facebook,
//                                  color: Colors.blue,
//                                  size: 40,
//                                ),
//                                title: Text('Facebook'),
//                                subtitle: Text('Visit our facebook page.'),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                    SizedBox(height: 30,),
//                    Container(
//                      decoration: BoxDecoration(
//                          gradient: LinearGradient(
//                              colors: [Colors.blueAccent, Colors.pinkAccent])),
//                      child: GestureDetector(
//                        onTap: () {
//                          _launchURL('https://www.facebook.com/ogive23/');
//                        },
//                        child: Card(
//                          elevation: 3,
//                          child: Column(
//                            mainAxisSize: MainAxisSize.min,
//                            children: <Widget>[
//                              ListTile(
//                                leading: FaIcon(
//                                  FontAwesomeIcons.instagram,
//                                  color: Colors.redAccent,
//                                  size: 40,
//                                ),
//                                title: Text('Facebook'),
//                                subtitle: Text('Visit our facebook page.'),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
                    getCard(
                        'Facebook',
                        'Visit our facebook Page.',
                        'https://www.facebook.com/ogive23/',
                        FontAwesomeIcons.facebook,
                        Colors.blue,
                        'fb'),
                    SizedBox(
                      height: 20,
                    ),
                    getCard(
                        'Instagram',
                        'Visit our Instagram Account.',
                        'https://www.instagram.com/mahmoued.martin/',
                        FontAwesomeIcons.instagram,
                        Colors.black,
                        'insta'),
                    SizedBox(
                      height: 20,
                    ),
                    getCard(
                        'Twitter',
                        'Find us on twitter.',
                        'https://twitter.com/MahmouedMartin2',
                        FontAwesomeIcons.twitter,
                        Colors.blue,
                        'twitter'),
                    SizedBox(
                      height: 20,
                    ),
                    getCard(
                        'Patreon',
                        'Support us.',
                        'https://www.patreon.com/user?0=u&1=%3D&2=1&3=6&4=2&5=7&6=7&7=2&8=5&9=6',
                        FontAwesomeIcons.patreon,
                        Colors.red,
                        ''),
                    SizedBox(
                      height: 20,
                    ),
                    getCard(
                        'opencollective',
                        'Support us.',
                        'https://opencollective.com/ogive',
                        FontAwesomeIcons.flag,
                        Colors.green,
                        ''),
                  ],
                ),
              ),
            )));
  }
}
