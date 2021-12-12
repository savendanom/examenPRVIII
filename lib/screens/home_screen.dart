import 'package:flutter/material.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:project_movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Examen Final PR. 8'),
          elevation: 0,
          actions: [
            IconButton(
              // icon: Icon(Icons.trending_up, color: Colors.red,),
              icon: Icon(
                Icons.whatshot,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'top');
              },
            ),
            IconButton(
              // icon: Icon(Icons.trending_up, color: Colors.red,),
              icon: Icon(
                Icons.info,
                color: Colors.black,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        title: Text('Informacion'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Sergio Avendaño'),
                            Text('Carné: 150402006:'),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      );
                    });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              MovieSlider(
                  movies: moviesProvider.popularMovies,
                  title: 'Películas populares 🎉'),
            ],
          ),
        ));
  }
}
