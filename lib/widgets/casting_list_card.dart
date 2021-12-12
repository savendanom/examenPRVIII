import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int idMovie;
  final String type;

  const CastingCards({Key? key, required this.idMovie, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getPepolMovie(idMovie),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List pepol = snapshot.data!;

        if (type == 'casting') {
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: pepol[0].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastingCard(person: pepol[0][index],)
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: pepol[1].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastingCard(person: pepol[1][index],)
            ),
          );
        }
      },
    );
  }
}

class _CastingCard extends StatelessWidget {

  final Cast person;

  const _CastingCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 110,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/count-loading.gif'),
              image: NetworkImage(person.picPepol),
              width: 130,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 5),

          Text(
            person.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }
}