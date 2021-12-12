import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class TopMovieScreen extends StatefulWidget {

  @override
  _TopMovieScreenState createState() => _TopMovieScreenState();
}

class _TopMovieScreenState extends State<TopMovieScreen> {
  CarouselController _carouselController = new CarouselController();
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    final List<TopRatedMovie> moviesTop = moviesProvider.topRatedMovies;

    return Scaffold(
      body: Container( 
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(moviesTop[_current].topPoster, fit: BoxFit.cover, width: double.infinity,),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            Positioned(
              bottom: 50,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  aspectRatio: 16/9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,

                items: moviesTop.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              Container(
                                height: 320,
                                margin: EdgeInsets.only(top: 30),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(movie.topPoster, fit: BoxFit.cover),
                              ),
                              SizedBox(height: 20),
                              Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0, 
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // rating
                              SizedBox(height: 20),
                              Container(
                                child: Text(
                                  movie.originalTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey.shade600
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 500),
                                opacity: _current == moviesTop.indexOf(movie) ? 1.0 : 0.0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.yellow, size: 20,),
                                            SizedBox(width: 5),
                                            Text(movie.voteAverage.toString(), style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey.shade600
                                            ),)
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(context, 'rateddetails', arguments: movie);
                                              },
                                              icon: Icon(Icons.play_circle_filled, color: Colors.grey.shade600, size: 20,)
                                            ),
                                            Text('Ver', style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey.shade600
                                            ),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}