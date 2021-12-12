import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class SimilarMovieCard extends StatelessWidget {

  final int idMovie;

  const SimilarMovieCard({Key? key, required this.idMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getsimilarMovies(idMovie),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<SimilarMovie> movies = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _SimilarCard(movie: movies[index], customID: '${ movies[index].title}${ UniqueKey().toString() }')
          ),
        );
      },
    );
  }
}

class _SimilarCard extends StatelessWidget {

  final SimilarMovie movie;
  final String customID;

  const _SimilarCard({Key? key, required this.movie, required this.customID}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 110,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'similar', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.posterImg),
                width: 130,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5),

          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }
}