import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas", textAlign: TextAlign.end,),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search), 
            onPressed: () {  },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          
          // Tarjetas superiores
          CardSwiper( movies: moviesProvider.onDisplayMovie ),

          // Sliders
          MovieSlider(
            movies: moviesProvider.popularMovies,
            title: 'Populares',
            onNextPage: () => moviesProvider.getPopularMovies()
          )

        ],)
      )
    );
  }
}