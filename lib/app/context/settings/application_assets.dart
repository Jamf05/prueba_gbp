class ApplicationAssets {

  static ApplicationAssets _singleton;

  static const String movie_icon = 'assets/icon/movie-icon.png';
  static const String loading = 'assets/img/loading.gif';
  static const String no_image = 'assets/img/no-image.jpg';


  factory ApplicationAssets(){
    
    if(_singleton == null)_singleton=ApplicationAssets._();

    return _singleton;
  }

  ApplicationAssets._();

}