class Renk{
  int renk;
  int id;
  Renk({this.renk,});

  Map<String, dynamic> toMap(){
    var map =Map<String, dynamic>();
    map['id'] = id;
    map['renk'] = renk;
    return map;
  }

  Renk.fromMap(Map<String, dynamic> map){
    id = map['id'];
    renk = map['renk'];
  }
}