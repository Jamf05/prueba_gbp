class Cast {
  List<ActorModel> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList ){

    if ( jsonList == null ) return;

    jsonList.forEach( ( item ) {
      final actor = ActorModel.fromJsonMap(item);
      actores.add(actor);
    });

  }
}

class ActorModel {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  ActorModel({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  ActorModel.fromJsonMap( Map<String, dynamic> json ){

    castId        =  json['cast_id'];
    character     =  json['character'];
    creditId      =  json['credit_id'];
    gender        =  json['gender'];
    id            =  json['id'];
    name          =  json['name'];
    order         =  json['order'];
    profilePath   =  json['profile_path'];

  }

  getFoto(){

    if ( profilePath == null ){
      return 'https://www.speakingtigerbooks.com/wp-content/uploads/2017/07/no-avatar-male.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    } 
  }


}
