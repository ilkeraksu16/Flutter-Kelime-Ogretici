import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:kelimeler/Page/duzenle.dart';
import 'package:kelimeler/Page/ekle.dart';
import 'package:kelimeler/Page/ingilizce.dart';
import 'package:kelimeler/Page/karisik.dart';
import 'package:kelimeler/Page/turkce.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Kelimeler extends StatefulWidget {
  
  @override
  _KelimelerState createState() => _KelimelerState();
}

class _KelimelerState extends State<Kelimeler> {
  int _sayfa = 0;
  int pageRenk;
  @override
  void initState() {
    getColor();
    super.initState();
  }

  final List<Widget> _page = [
    Turkce(),
    Ingilizce(),
    Karisik()
  ];

  void kaydet(int value) async{
    print('$value');
    print('burada');
    await SharedPreferences.getInstance();
    print('deneme');
    final kayitAraci = await SharedPreferences.getInstance();
    print('evet');
    kayitAraci.setInt("renk", value);
    getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pageRenk != null ? Color(pageRenk) : Colors.purple,
        title: Text('Kelimeler'),
        centerTitle: true,
        leading: _renkSecimi(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => Duzenle()
              ));
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => Ekle()
              ));
            },
          ),
          
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor:pageRenk != null ? Color(pageRenk) : Colors.purple,
        tabs: [
          TabData(iconData: Icons.widgets, title: 'Türkçe'),
          TabData(iconData: Icons.layers, title: 'İngilizce'),
          TabData(iconData: Icons.ac_unit, title: 'Karışık'),
        ],
        onTabChangedListener: (position){
          setState(() {
           _sayfa = position; 
          });
        },
      ),
      body: _page[_sayfa],
    );
  }

  void getColor() async{
    final kayitAraci = await SharedPreferences.getInstance();
    int renk = kayitAraci.getInt("renk");
    setState(() {
      pageRenk = renk;
    });
  }

  Widget _renkSecimi(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  kaydet(0XFFF44336);
                },
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white),
                    color: Colors.red
                  ),
                ),
              ),
              GestureDetector(
                 onTap: (){
                  kaydet(0xFF2196F3);
                },
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white),
                    color: Colors.blue
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  kaydet(0XFF000000,);
                },
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white),
                    color: Colors.black
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  kaydet(0XFF9C27B0);
                },
                child: Container(
                  width: 25.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white),
                    color: Colors.purple
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}