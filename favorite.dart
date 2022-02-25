import 'package:flutter/material.dart';
import 'package:gihad/helper/http.dart';
import 'package:gihad/model/model.dart';

import 'detail.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String baseimage = 'https://image.tmdb.org/t/p/w92';
  String image =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  List<movie> movie2 = [];
  Icon visible = const Icon(Icons.search);
  Widget search = const Text('movies');
  void initState() {
    Future.delayed(Duration.zero, () async {
      var up_movies = await Httphelper.getUfavorite();
      setState(() {
        movie2 = up_movies;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage imag;
    return Scaffold(
      appBar: AppBar(
        title: search,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (visible.icon == Icons.search) {
                    visible = const Icon(Icons.cancel);
                    search = TextField(
                      textInputAction: TextInputAction.search,
                      onChanged: (text) async {
                        var listmov = await Httphelper.find(text);
                        setState(() {
                          movie2 = listmov;
                        });
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    setState(() {
                      visible = const Icon(Icons.search);
                      search = Text('movies');
                    });
                  }
                });
              },
              icon: visible),
        ],
      ),
      body: movie2.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (movie2 == []) ? 0 : movie2.length,
              itemBuilder: (context, position) {
                if (movie2[position].posterPath != null) {
                  imag = NetworkImage(baseimage + movie2[position].posterPath);
                } else {
                  imag = NetworkImage(image);
                }
                return Card(
                  color: Colors.white,
                  elevation: 20.0,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => details(mov: movie2[position])),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: imag,
                    ),
                    title: Text(movie2[position].title),
                    subtitle: Text('released' +
                        movie2[position].releaseDate +
                        '-vote' +
                        movie2[position].voteAverage.toString()),
                  ),
                );
              },
            ),
    );
  }
}
