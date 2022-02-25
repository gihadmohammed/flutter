import 'dart:js';

import 'package:flutter/material.dart';
import 'package:gihad/Screens/detail.dart';
import 'package:gihad/Screens/favorite.dart';
import 'package:gihad/Screens/latest.dart';
import 'package:gihad/helper/http.dart';
import 'package:gihad/model/model.dart';

class movielist extends StatefulWidget {
  const movielist({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<movielist> {
  String baseimage = 'https://image.tmdb.org/t/p/w92';
  String image =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  List<movie> movie1 = [];
  List<movie> movie2 = [];
  Icon visible = const Icon(Icons.search);
  Widget search = const Text('movies');
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      var upcomemovies = await Httphelper.getUpcoming();

      setState(() async {
        movie1 = upcomemovies;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage imag;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                          child: Icon(
                        Icons.settings,
                      ))),
                  SizedBox(
                    height: 10,
                  ),
                  Text("about",
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite_border_rounded),
              title: Text("The Most Popular"),
              onTap: () {
                print("object");

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favourite()));
              },
            ),
            SizedBox(height: 4.0),
            ListTile(
              leading: Icon(Icons.watch_rounded),
              title: Text(
                'latest',
                style: TextStyle(color: Colors.lightBlue),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => last()));
              },
            )
          ],
        ),
      ),
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
                          movie1 = listmov;
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
      body: movie1.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: (movie1 == []) ? 0 : movie1.length,
              itemBuilder: (context, position) {
                if (movie1[position].posterPath != null) {
                  imag = NetworkImage(baseimage + movie1[position].posterPath);
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
                            builder: (_) => details(mov: movie1[position])),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: imag,
                    ),
                    title: Text(movie1[position].title),
                    subtitle: Text('released' +
                        movie1[position].releaseDate +
                        '-vote' +
                        movie1[position].voteAverage.toString()),
                  ),
                );
              },
            ),
    );
  }
}
