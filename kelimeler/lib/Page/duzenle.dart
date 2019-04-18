import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelimeler/database/db_helper.dart';
import 'package:kelimeler/model/kelime.dart';
import 'package:kelimeler/Page/kelime_duzenle.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Duzenle extends StatefulWidget {
  @override
  _DuzenleState createState() => _DuzenleState();
}

class _DuzenleState extends State<Duzenle> {

  DbHelper _dbHelper;
  int pageRenk;
  @override
  void initState() {
    super.initState();
    getColor();
    _dbHelper =DbHelper();
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
        title: Text('Kelime Düzenle'),
        centerTitle: true,
        backgroundColor: pageRenk != null ? Color(pageRenk) : Colors.purple,
      ),
      body: Container(
        color: pageRenk != null ? Color(pageRenk) : Colors.purple,
        child: FutureBuilder(
          future: _dbHelper.getKelimeler(true),
          builder: (BuildContext context, AsyncSnapshot<List<Kelime>> veri){
            if(!veri.hasData) return Center(child: CircularProgressIndicator(),);
            if(veri.data.isEmpty) return Center( child:Text("Kelime Hazinen Boş",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),);
            List<Kelime> kelime = veri.data;
            return ListView.builder(
              itemCount: kelime.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => KelimeDuzenle(kelime: kelime[index],)
              ));
                      },
                    ),
                    title: Text('${kelime[index].ingilizce}', style: TextStyle(fontSize: 16.5),),
                    subtitle: Text('${kelime[index].turkce}', style: TextStyle(fontSize: 18.0)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async{
                        setState(() {});
                        int cevap =await _dbHelper.deleteGorev(kelime[index].id);
                        if(cevap ==1)
                          {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Kelime Silindi',style: TextStyle(color: Colors.white,fontSize: 18.0),),
                                duration: Duration(milliseconds: 1200),
                                backgroundColor: Colors.red,
                              )
                            );
                          }
                      },
                    )
                  ),
                );
              }
            ); 
          },
        ),
      ),
    );
  }
  
}

