import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/models/pelicula_model.dart';


class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  
 const CardSwiper({Key key, this.peliculas}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;

    return Container(
       padding: const EdgeInsets.only(top: 10.0),
       child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: screenSize.width * 0.7,
          itemHeight: screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index){

            peliculas[index].id = '${ peliculas[index].id }-tarjeta' as int;

            return Hero(
              tag: peliculas[index].id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage( peliculas[index].getPosterImg()  ),
                    placeholder: const AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
              ),
            );
            
          },
          itemCount: peliculas.length,
          // pagination: new SwiperPagination(),
          // control: new SwiperControl(),
      ),
    );

  }
}
