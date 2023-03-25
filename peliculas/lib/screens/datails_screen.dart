import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie,),
              _Overview(movie),
              _Overview(movie),
              _Overview(movie),
              const SizedBox(height: 15,),
              CastingCards(movie.id,)
            ])
          )
          
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget{

  final Movie movie;

  const _CustomAppBar(this.movie); 
  

  @override
  Widget build(BuildContext context){
    return SliverAppBar(
      backgroundColor: Colors.grey,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(10),
          color: Colors.grey,
          child: Text( 
            movie.title,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
            )),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullBackdropPath), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie); 

  @override
  Widget build(BuildContext context) {
    
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-imagen.jpg'),
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),

          const SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text(movie.originalTitle, overflow: TextOverflow.ellipsis, maxLines: 2,),
            ],
          ),
          const SizedBox(width: 10,),
          Row(
            children: [
              const Icon(Icons.start_outlined, size: 20, color: Colors.grey,),
              const SizedBox(width: 5),
              Text('${movie.voteAverage}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16),)
            ],
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview(this.movie); 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        movie.overview, 
        textAlign: TextAlign.justify, 
        style: Theme.of(context).textTheme.titleMedium
      ),
    );
  }
}