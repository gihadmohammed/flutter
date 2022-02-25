import 'package:flutter/material.dart';
import 'package:gihad/model/model.dart';

class details extends StatelessWidget {
  final movie mov;
  final String pathofimage = 'https://image.tmdb.org/t/p/w500';
  const details({required this.mov, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double movieheight = MediaQuery.of(context).size.height;
    String path;
    if (mov.posterPath != null) {
      path = pathofimage + mov.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(mov.title),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                height: movieheight / 1.5,
                child: Image.network(path)),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(mov.overVeiw),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'vote:' + mov.voteAverage.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      )),
    );
  }
}
