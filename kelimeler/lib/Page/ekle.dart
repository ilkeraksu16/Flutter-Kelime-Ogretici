import 'package:flutter/material.dart';
import 'package:kelimeler/database/db_helper.dart';
import 'package:kelimeler/model/kelime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Ekle extends StatefulWidget {

  @override
  _EkleState createState() => _EkleState();
}

class _EkleState extends State<Ekle> {

  final _kontrol = GlobalKey<FormState>();
  TextEditingController _clearControlT =TextEditingController();
  TextEditingController _clearControlI =TextEditingController();
  DbHelper _dbHelper;
  String turkce, ingilizce;
  int pageRenk;

  @override
  void initState() {
    _dbHelper =DbHelper();
    getColor();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getColor() async{
    final kayitAraci = await SharedPreferences.getInstance();
    int renk = kayitAraci.getInt("renk");
    setState(() {
      pageRenk = renk;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelime Ekle'),
        centerTitle: true,
        backgroundColor: pageRenk != null ? Color(pageRenk) : Colors.purple,
      ),
      body: Builder(
        builder: (context) => 
          Padding(
          padding: EdgeInsets.only(left:10.0,right: 10.0,top: 40.0,bottom: 10.0),
          child: Form(
            key: _kontrol,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Türkçe',style: TextStyle(fontSize: 18.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _clearControlT,
                  decoration: InputDecoration(
                    hintText: 'Kelimeyi Yazınız' ,
                    hintStyle: TextStyle(fontSize: 17.0),
                    contentPadding: EdgeInsets.all(3.0)
                  ),
                  style: TextStyle(fontSize: 17.0),
                  validator: (value){
                    if(value.isEmpty)
                      return 'Yazı Yazınız';
                  },
                  onSaved: (value){
                    setState(() {
                    turkce = value; 
                    //print('$turkce');
                    });
                  },
                ),
                SizedBox(height: 15.0,),
                Text('İngilizce',style: TextStyle(fontSize: 18.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _clearControlI,
                  decoration: InputDecoration(
                    hintText: 'Kelimeyi Yazınız',
                    hintStyle: TextStyle(fontSize: 17.0),
                    contentPadding: EdgeInsets.all(3.0)
                  ),
                  style: TextStyle(fontSize: 17.0),
                  validator: (value){
                    if(value.isEmpty)
                      return 'Yazı yazınız';
                  },
                  onSaved: (value){
                    setState(() {
                    ingilizce = value; 
                    });
                  },

                ),
                SizedBox(height: 15.0,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Color(0xff9BAC15),
                        onPressed: () async{
                          if (_kontrol.currentState.validate()) {
                            _kontrol.currentState.save();
                            Kelime ceviri = Kelime(turkce: turkce,ingilizce: ingilizce);
                            print('');
                            await _dbHelper.insertKelime(ceviri);
                            //FocusScope.of(context).requestFocus(FocusNode());//klavye kapama
                            _clearControlT.clear();
                            _clearControlI.clear();
                            _showSnackBar(context);
                          }
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Kaydet',style: TextStyle(fontSize: 20.0),),
                        ),),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        textColor: Colors.white,
                        highlightColor: Colors.purple,
                      ),
                    )
                  ],
                ),
              SizedBox(height: MediaQuery.of(context).size.height/2-20,),
                Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text('Kübra Derya\'ya fikrinden dolayı teşekkürler'),
                        ),
                      ),
                    )
              ],
            ),
          )
        )
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Kelime Başarıyla Kaydedildi'),
      duration: Duration(milliseconds: 1200),
    ));
  }
}