import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:project_movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailSimilarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SimilarMovie movie =
        ModalRoute.of(context)!.settings.arguments as SimilarMovie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CustomAppBar(movie: movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterSimilar(movie: movie),
            _OverviewSimilar(movie: movie),
            _TitleSimilar(title: 'Reparto'),
            CastingCards(idMovie: movie.id, type: 'casting'),
            _TitleSimilar(title: 'Equipo de producción'),
            CastingCards(idMovie: movie.id, type: 'team'),
            _TitleSimilar(title: 'Películas similares'),
            SimilarMovieCard(idMovie: movie.id)
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final SimilarMovie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/count-loading.gif'),
          image: NetworkImage(movie.headerBack),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterSimilar extends StatelessWidget {
  final SimilarMovie movie;

  const _PosterSimilar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme customTextTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              width: 110,
              height: 150,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.posterImg),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 170),
                  child: Text(movie.title,
                      style: customTextTheme.headline5,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start)),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width - 170),
                  child: Text(movie.originalTitle,
                      style: customTextTheme.subtitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start)),
              Row(
                children: [
                  Icon(Icons.star_outline_rounded,
                      size: 25, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(movie.voteAverage.toString(),
                      style: customTextTheme.caption)
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Me Encanta',
                    icon: Icon(Icons.sentiment_satisfied_alt, size: 25),
                    onPressed: () async {
                      final max = await moviesProvider.sendRated(movie.id, 10);

                      if (max == 'Success.') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Gracias por votar 📮🎉📈',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.indigoAccent,
                          content: Text(
                            'Voto actualizado 📫📊',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ));
                      }
                    },
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    tooltip: 'Regular',
                    icon: Icon(Icons.sentiment_satisfied, size: 25),
                    onPressed: () async {
                      final regular =
                          await moviesProvider.sendRated(movie.id, 5);

                      if (regular == 'Success.') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Gracias por votar 📮🎉📈',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.indigoAccent,
                          content: Text(
                            'Voto actualizado 📫📊',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ));
                      }
                    },
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    tooltip: 'Pésimo',
                    icon: Icon(Icons.sentiment_very_dissatisfied, size: 25),
                    onPressed: () async {
                      final sad = await moviesProvider.sendRated(movie.id, 0.5);

                      if (sad == 'Success.') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Gracias por votar 📮🎉📈',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.indigoAccent,
                          content: Text(
                            'Voto actualizado 📫📊',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ));
                      }
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _OverviewSimilar extends StatelessWidget {
  final SimilarMovie movie;

  const _OverviewSimilar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _TitleSimilar extends StatelessWidget {
  final String title;

  const _TitleSimilar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
