import 'package:flutter/material.dart';
import 'package:gihad/Screens/detail.dart';
import 'package:gihad/helper/http.dart';
import 'package:gihad/model/model.dart';

class last extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<last> {
  late List<movie> movie3 = [];
  String Image =
      "https://media.istockphoto.com/vectors/movie-time-vector-illustration-cinema-poster-concept-on-red-round-vector-id911590226?k=20&m=911590226&s=612x612&w=0&h=HlJtSKF-fLsKFy1QJ-EVnxXkktBKNS-3jUQPXsSasYs=";
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      List<movie> data = await Httphelper.getLatest();
      setState(() {
        movie3 = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The latest movie",
          style: TextStyle(
              color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: movie3.isEmpty
          ? Center(
              child: Text(
                "not found latest movie added",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.0,
                ),
                itemCount: movie3.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.amberAccent,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => details(mov: movie3[index])),
                      );
                    },
                    title: Text(
                      movie3[index].title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${movie3[index].releaseDate} - Vote: ${movie3[index].voteAverage}",
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.favorite,
                    ),
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            
                            'https://image.tmdb.org/t/p/original${movie3[index].posterPath}' ==
                                    null
                                ? Image
                                : 'https://image.tmdb.org/t/p/original${movie3[index].posterPath}')),
                  ),
                ),
              ),
            ),
    );
  }
}
