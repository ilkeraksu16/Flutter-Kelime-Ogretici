import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ayarlar extends StatefulWidget {
  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {

  final deger = 'purple';
  int pageRenk;

  @override
  void initState() {
    //getColor();
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayarlar'),
        centerTitle: true,
        backgroundColor: pageRenk != null ? Color(pageRenk) : Colors.purple,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text('Uygulama Renginizi Seçiniz',style: TextStyle(
              fontSize: 20.0,
            ),),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.purple
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.blue
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.red
                  ),
                ),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Radio(
                  activeColor: Colors.purple,
                  value: 0XFF9C27B0,
                  groupValue: deger,
                  onChanged: (value) => kaydet(value)
                ),
                Radio(
                  activeColor: Colors.blue,
                  value: 0xFF2196F3,
                  groupValue: deger,
                  onChanged: (value) => kaydet(value)
                ),
                Radio(
                  activeColor: Colors.red,
                  value: 0XFFF44336,
                  groupValue: deger,
                  onChanged: (value) => kaydet(value)
                ),
                Radio(
                  activeColor: Colors.black,
                  value: 0XFF000000,
                  groupValue: deger,
                  onChanged: (value) => kaydet(value)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
  void getColor() async{
    final kayitAraci = await SharedPreferences.getInstance();
    int renk = kayitAraci.getInt("renk");
    setState(() {
      pageRenk = renk;
    });
  }
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
}