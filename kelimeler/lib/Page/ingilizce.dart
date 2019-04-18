import 'package:flutter/material.dart';
import 'package:kelimeler/database/db_helper.dart';
import 'package:kelimeler/model/kelime.dart';
import 'dart:math';

class Ingilizce extends StatefulWidget {
  @override
  _IngilizceState createState() => _IngilizceState();
}

class _IngilizceState extends State<Ingilizce> {
  final _kontrol =GlobalKey<FormState>();
  TextEditingController _clearControl =TextEditingController();
  DbHelper _dbHelper;
  String turkce;
  String ingilizce;
  String tahminTurk;
  Kelime kelime;
  List<Kelime> kelimeler;
  List<int> liste = new List();
  
  @override
  void initState() {
    super.initState();
    _dbHelper =DbHelper();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dbHelper.getKelimeler(false),
      builder: (BuildContext context, AsyncSnapshot<List<Kelime>> veri){
        if(!veri.hasData) return Center(child: CircularProgressIndicator(),);
        if(veri.data.isEmpty) return Center( child:Text("Kelime Hazinen Boş",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.teal),),);
        kelimeler =veri.data;
        if(ingilizce == null){
          int sayac =randomUret(kelimeler);
          turkce = veri.data[sayac].turkce;
          ingilizce = veri.data[sayac].ingilizce;
        }
        return Form(
          key: _kontrol,
          child: Padding(
              padding: EdgeInsets.only(left: 20.0,right: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('$ingilizce',style: TextStyle(fontSize: 22.0),),
                    SizedBox(height: 25.0,),
                    TextFormField(
                      controller: _clearControl,
                      decoration: InputDecoration(
                        hintText: 'Türkçesini Yazınız',
                        contentPadding: EdgeInsets.all(2.0),
                      ),
                      style: TextStyle(fontSize: 20.0),
                      validator: (value){
                        if(value.isEmpty)
                          return 'Boş Bırakmayınız';
                      },
                      onSaved: (value){
                        setState(() {
                          tahminTurk =value;
                        });
                      },
                    ),
                    SizedBox(height: 25.0,),
                    _butonlar(),
                  ],
                ),
              ),
        );

      },
    );
  }

  Widget _butonlar(){
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () async{
              if(_kontrol.currentState.validate()){
                _kontrol.currentState.save();
                await cevapKontrol(context);
                _clearControl.clear();
              }
            },
            child: Text('Cevapla',style: TextStyle(fontSize: 18.0),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
        SizedBox(width: 30.0,),
        Expanded(
          child: RaisedButton(
            color: Colors.red,
            onPressed: () async{
              //List<Kelime> kelimeler = await _dbHelper.getKelimeler(false);
              int index =randomUret(kelimeler);
              setState(() {
              turkce = kelimeler[index].turkce;
              ingilizce = kelimeler[index].ingilizce;  
              });
              _clearControl.clear();
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Row(
              children: <Widget>[
                Text('Pas',style: TextStyle(fontSize: 18.0,color: Colors.white),),
                SizedBox(width: 5.0,),
                Icon(Icons.chevron_right,color: Colors.white,),
                Icon(Icons.chevron_right,color: Colors.white,),
                Icon(Icons.chevron_right,color:Colors.white)
              ],
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          ),
        )
      ],
    );
  }

  Future<void> cevapKontrol(BuildContext context) async{

    print('ting: $tahminTurk');
    if(turkce ==tahminTurk){
      //List<Kelime> kelimeler = await _dbHelper.getKelimeler(false);
      int index =randomUret(kelimeler);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('$turkce kelimesini Doğru bildiniz',style: TextStyle(color: Colors.white,fontSize: 17.0),textDirection: TextDirection.ltr,),
        backgroundColor: Colors.blue,
        duration: Duration(milliseconds: 1200)
      ));
      setState(() {
       turkce =kelimeler[index].turkce;
       ingilizce =kelimeler[index].ingilizce; 
      });
    }
    else{
      //List<Kelime> kelimeler = await _dbHelper.getKelimeler(false);
      int index = randomUret(kelimeler);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Cevap $turkce',style: TextStyle(color: Colors.white,fontSize: 17.0),textDirection: TextDirection.rtl,),
        backgroundColor: Colors.red,
      ));
      setState(() {
        turkce =kelimeler[index].turkce;
        ingilizce =kelimeler[index].ingilizce; 
      });
    }
  }
  int randomUret(List<Kelime> kelimeler){
    int index;
    //Kelime hazinesi 10 dan küçük ise listeye eklemeden random getir.
    if(kelimeler.length <= 10){
      print('kelimenin uzunluğu : ${kelimeler.length}');
      print('listenin uzunluğu : ${liste.length}');
      if(kelimeler.length > liste.length)
      {
        index =indexBul(kelimeler);
        liste.add(index);
        return index;
      }
      else{
        print('kelime length:${kelimeler.length} liste length:${liste.length}');
        int index = liste[0];
        for(int i = 1 ; i<liste.length;i++){
          liste[i-1] = liste[i];
        }
        liste[liste.length-1] = index;
        return index;
      }
    }
    else{
      //kelime hazinesi 10 dan büyük ve liste 10 dan küçük ise kontrollü ekleme yapıyor.
      if (liste.length < 10) {
        print('liste lengt:${liste.length}');
        index =indexBul(kelimeler);
        liste.add(index);
        yaz();
        return index;
      }
      else{ // kelime hazinesi 10 dan büyük ise kontrollü ve kaydırmalı ekleme yapıyor.
        index =indexBul(kelimeler);
        for(int i = 1 ; i<liste.length;i++){
          liste[i-1] = liste[i];
        }
        print('değer $index');
        liste[9]= index;
        print('liste eklendikten sonra uzunluk : ${liste.length}');
        yaz();
        return index;
      }
    }
  }

  bool isListHave(int index){
    
    bool varmi = false;
    for (int i=0;i<liste.length;i++){
      if(liste[i] == index)
        varmi = true;
    }
    return varmi;
  }

  int indexBul(List<Kelime> kelimeler){
    Random rnd = new Random();
    bool kontrol;
    int index;
    do {
      index = rnd.nextInt(kelimeler.length);
      kontrol = isListHave(index);
      } while (kontrol);
    return index;
  }

  void yaz(){
    print('Liste elemanları : ');
    for (var i = 0; i < liste.length; i++) {
      print('liste $i. eleman değeri : ${liste[i]}');
    }
  }
}