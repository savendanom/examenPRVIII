import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CardReviewsMovie extends StatelessWidget {
  final int idMovie;

  const CardReviewsMovie({Key? key, required this.idMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getReviewsMovies(idMovie),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 400,
            child: ListView(
              children: [
                _CardReviewsDefault(autor: 'msbreviews', content: 'Muy buena pelicula, la recomiendo ya que me gusto mucho no me aburri ni me quede dormido\r\n le doy un 8/10'),
                
                _CardReviewsDefault(autor: 'ruben', content: 'La pelicula estuvo bien, pero hay puntos que pudieron ser mejores, quiero el multiverso XD'),

                _CardReviewsDefault(autor: 'sergio', content: 'Muy buena pelicula, la recomiendo ya que me gusto mucho no me aburri ni me quede dormido\r\n le doy un 8/10'),
                
                _CardReviewsDefault(autor: 'Ana', content: 'Estuvo bien, bastante entretenida y te deja en suspendo debes prestar atención para no perderte y enternder el porque de cada trampa\r\n le doy un 8/10'),

                _CardReviewsDefault(autor: 'Juan', content: 'En lo personal no me gusto, casi que con cuaderdo hay que verla para entender, resulte estresado\r\n 🤦‍♂️'),
                _CardReviewsDefault(autor: 'Pepe', content: 'Muy buena pelicula, la recomiendo ya que me gusto mucho no me aburri ni me quede dormido\r\n le doy un 8/10'),
              ],
            ),
          );
        }

        final List<ReviewsMovie> reviews = snapshot.data!;

        print(reviews);

        if (reviews.length == 0) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 400,
            child: ListView(
              children: [
                _CardReviewsDefault(autor: 'msbreviews', content: 'Muy buena pelicula, la recomiendo ya que me gusto mucho no me aburri ni me quede dormido\r\n le doy un 8/10'),
                
                _CardReviewsDefault(autor: 'ruben', content: 'La pelicula estuvo bien, pero hay puntos que pudieron ser mejores, quiero el multiverso XD'),

                _CardReviewsDefault(autor: 'sergio', content: 'Muy buena pelicula, la recomiendo ya que me gusto mucho no me aburri ni me quede dormido\r\n le doy un 8/10'),
                
                _CardReviewsDefault(autor: 'Ana', content: 'Estuvo bien, bastante entretenida y te deja en suspendo debes prestar atención para no perderte y enternder el porque de cada trampa\r\n le doy un 8/10'),

                _CardReviewsDefault(autor: 'Juan', content: 'En lo personal no me gusto, casi que con cuaderdo hay que verla para entender, resulte estresado\r\n 🤦‍♂️'),
                _CardReviewsDefault(autor: 'Pepe', content: 'Muy buena pelicula, la recomiendo ya que me gusto mucho no me aburri ni me quede dormido\r\n le doy un 8/10'),
              ],
            ),
          );
        }

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: 400,
          child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (_, int index) => _CardReviews(review: reviews[index],)
          ),
        );
      },
    );
  }
}

class _CardReviews extends StatelessWidget {

  final ReviewsMovie review;

  const _CardReviews({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon( Icons.person),
            title: Text(review.author),
            subtitle: Text(review.content),
          )
        ],
      ),
    );
  }
}

class _CardReviewsDefault extends StatelessWidget {

  final String autor;
  final String content;

  const _CardReviewsDefault({Key? key, required this.autor, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon( Icons.person),
            title: Text(autor),
            subtitle: Text(content),
          )
        ],
      ),
    );
  }
}