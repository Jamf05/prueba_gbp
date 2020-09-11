import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/context/settings/app_settings.dart';
import 'package:prueba_gbp/app/context/settings/application_assets.dart';
import 'package:prueba_gbp/app/context/settings/application_colors.dart';
import 'package:prueba_gbp/app/ui/pages/movie_page.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<PeliculaModel> peliculas;
  final Function siguientePagina;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 700 ){
        siguientePagina();
      }

    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas[i] );
        },
      ),
    );
  }

/*
 
 ########    ###    ########        ## ######## ########    ###       
    ##      ## ##   ##     ##       ## ##          ##      ## ##      
    ##     ##   ##  ##     ##       ## ##          ##     ##   ##     
    ##    ##     ## ########        ## ######      ##    ##     ##    
    ##    ######### ##   ##   ##    ## ##          ##    #########    
    ##    ##     ## ##    ##  ##    ## ##          ##    ##     ##    
    ##    ##     ## ##     ##  ######  ########    ##    ##     ##    
 
*/

  Widget _tarjeta( BuildContext context, PeliculaModel pelicula){
    Size size;
    if (size == null) size = MediaQuery.of(context).size;  

    final peliculaTarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg() ),
                  placeholder: AssetImage(ApplicationAssets.no_image),
                  height: size.height*0.23,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: AppSettings().homeMovieTitle,
            ),
            _ratings(size, pelicula.voteAverage)
            
          ],
        ),
    );

    return GestureDetector(
      child: peliculaTarjeta,
      onTap: () => Navigator.pushNamed(context, MoviePage.route, arguments: pelicula)
    );
  }

  Widget _ratings(Size size, double score){
    int stars = (score/2).round();
    final 
    List<Widget> list = List();

    for (var i = 0; i < 5; i++) {

      Widget star = Icon(
        Icons.star, size: size.width*0.045,
        color: i <= stars ? ApplicationColors().yellow : ApplicationColors().yellow2,
      );

      list.add(star);
    }

    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      )
    );
  }
}