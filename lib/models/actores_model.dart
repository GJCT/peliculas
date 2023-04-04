import 'dart:convert';

class Cast {

  List<Actor> actores = [];


  Cast.fromJsonList( List<dynamic> jsonList  ){

    if ( jsonList.isEmpty ) return;

    jsonList.forEach( (item) {
      final actor = Actor.fromMap(item);
      actores.add(actor);
    });
  }

}

class Actor {
  Actor({
    required this.castId,
    required this.character,
    required this.creditId,
    required this.gender,
    required this.id,
    required this.name,
    required this.order,
    this.profilePath,
  });

  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String? profilePath;

   get foto{
    if ( profilePath == null ) {
      return 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

  factory Actor.fromJson(String str) => Actor.fromMap(json.decode(str));

  factory Actor.fromMap( Map<String, dynamic> json ) => Actor(
    castId      : json['cast_id'] as int,
    character   : json['character'],
    creditId    : json['credit_id'],
    gender      : json['gender'],
    id          : json['id'],
    name        : json['name'],
    order       : json['order'],
    profilePath : json['profile_path'],
  );

  Map<String, dynamic> toJson() => {
    "castId"      : castId,
    "character"   : character, 
    "creditId"    : creditId,
    "gender"      :  gender,
    "id"          : id,
    "name"        : name,
    "order"       : order,
    "profilePath" : profilePath,
  };

}
