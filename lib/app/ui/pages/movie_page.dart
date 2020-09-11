import 'package:flutter/material.dart';
import 'package:prueba_gbp/app/blocs/movie_bloc.dart';
import 'package:prueba_gbp/app/context/settings/app_settings.dart';
import 'package:prueba_gbp/app/context/settings/application_assets.dart';
import 'package:prueba_gbp/app/context/settings/application_colors.dart';
import 'package:prueba_gbp/app/injectors/injector.dart';
import 'package:prueba_gbp/app/ui/base_state.dart';
import 'package:prueba_gbp/app/ui/custom/static_widgets.dart';
import 'package:prueba_gbp/entities/dto/event.dart';
import 'package:prueba_gbp/entities/dto/result_model.dart';
import 'package:prueba_gbp/entities/models/actor_model.dart';
import 'package:prueba_gbp/entities/models/genre_model.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

class MoviePage extends StatefulWidget {
  static final route = 'movie';

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends BaseState<MoviePage,MovieBloc> {

  dynamic future;
  
  @override
  void initState() {
    super.initState();
    future = null; // bloc.getAuthenticationInfo();
  }

  @override
  MovieBloc getBlocInstance() {
    return MovieBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    final PeliculaModel pelicula = ModalRoute.of(context).settings.arguments;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ApplicationColors().darkBlue,
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),

                _posterTitulo( context, pelicula ),
                _descripcion( pelicula ),
                SizedBox(height: 10.0,),
                _crearCasting( pelicula ),
                _summary( size, pelicula ),
                SizedBox(height: 40.0,),
              ]
            ),
          )
        ],
      )
    );
  }

/*
 
        ######  ##     ## ##     ## ##     ##    ###    ########  ##    ## 
       ##    ## ##     ## ###   ### ###   ###   ## ##   ##     ##  ##  ##  
       ##       ##     ## #### #### #### ####  ##   ##  ##     ##   ####   
        ######  ##     ## ## ### ## ## ### ## ##     ## ########     ##    
             ## ##     ## ##     ## ##     ## ######### ##   ##      ##    
       ##    ## ##     ## ##     ## ##     ## ##     ## ##    ##     ##    
        ######   #######  ##     ## ##     ## ##     ## ##     ##    ##    
 
*/

  Widget _summary(Size size, PeliculaModel pelicula){
    return FutureBuilder(
        future: bloc.getGenresInfo(),
        builder: (context, AsyncSnapshot<Result<Event<List<GenreModel>>>> snapshot) {
        final Result<Event<List<GenreModel>>> result = snapshot.data; 
          if (snapshot.hasData){
            if (result.error != null) return Container();
            List<GenreModel> allGenres = result.data.payload.response;

            String listgenres = '';

            allGenres.forEach((GenreModel genre) {
              if (pelicula.genreIds.contains(genre.id)) listgenres = listgenres + ", " + genre.name;
            });
            
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        child: Text(
                          l10n.genre,
                          style: AppSettings().homeSubTitleStyle,
                        ),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        width: size.width*0.65,
                        height: 30,
                        child: Text(
                          listgenres.substring(2,listgenres.length),
                          overflow: TextOverflow.fade,
                          style: AppSettings().homeMovieTitle,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        l10n.release,
                        style: AppSettings().homeSubTitleStyle,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        pelicula.releaseDate,
                        style: AppSettings().homeMovieTitle,
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            child: SizedBox(
                child: CircularProgressIndicator()
              )
            );
          }

        },
    );
  }

  Widget _crearAppbar(PeliculaModel pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: ApplicationColors().blue,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          image: NetworkImage( pelicula.getBackgroundImg() ),
          placeholder: AssetImage(ApplicationAssets.loading),
          fadeInDuration: Duration( milliseconds: 150 ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo( BuildContext context, PeliculaModel pelicula ){
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width*0.5,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Text(
              pelicula.title,
              style: AppSettings().homeTitleStyle
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                customButton(
                  size: size,
                  text: l10n.watchNow,
                  onPressed: (){}
                ),
                _ratings(size, pelicula.voteAverage)
              ],
            ),
          ),
        ],
      )
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
      width: 120,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      )
    );
  }

  Widget _descripcion( PeliculaModel pelicula ){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        style: AppSettings().homeMovieTitle,
        textAlign: TextAlign.justify,
      ),
    );

  }

  Widget _crearCasting( PeliculaModel pelicula ){

    return FutureBuilder(
      future: bloc.getCastInfo(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<Result<Event<List<ActorModel>>>> snapshot) {
        final Result<Event<List<ActorModel>>> result = snapshot.data; 
        if ( snapshot.hasData ){
          if(result.error != null){
            return Container();
          }
          List<ActorModel> cast = result.data.payload.response;
          return _crearActoresPageView( cast );
        } else {
          return Center( child: CircularProgressIndicator() );
        }
      },
    ); 
  }

  Widget _crearActoresPageView( List<ActorModel> actores ){
    return SizedBox(
      height: 110.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: ( context, i ) => _actorTarjeta( actores[i] ),
      ),
    );

  }

  Widget _actorTarjeta( ActorModel actor ){

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: FadeInImage(
                image: NetworkImage( actor.getFoto() ),
                placeholder: AssetImage(ApplicationAssets.no_image),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: AppSettings().homeMovieTitle,
          ),
        ],
      ),
    );

  }
  
}