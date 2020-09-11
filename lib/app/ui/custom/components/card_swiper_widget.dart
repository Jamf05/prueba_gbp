import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:prueba_gbp/entities/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<PeliculaModel> peliculas;

  CardSwiper({
    @required this.peliculas
  });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
        
        padding: EdgeInsets.only(top: 10.0,),
        height: _screenSize.height * 0.5,
        alignment: Alignment.bottomRight,
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( peliculas[index].getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              )
            );
            
          },
          itemCount: peliculas.length,
          
        ),
      );
  }
}