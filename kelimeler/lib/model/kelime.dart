class Kelime {
  int id;
  String turkce;
  String ingilizce;

  Kelime({this.turkce, this.ingilizce});

  Map<String, dynamic> toMap(){
    var map =Map<String, dynamic>();

    map['id'] = id;
    map['turkce'] =turkce;
    map['ingilizce'] =ingilizce;

    return map;
  }

  Kelime.fromMap(Map<String, dynamic> map){
    id = map['id'];
    turkce = map['turkce'];
    ingilizce = map['ingilizce'];
  }
}