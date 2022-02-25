//model
class movie {
  int id;
  String title;
  double voteAverage;
  String releaseDate;
  String overVeiw;
  String posterPath;
  movie(
      {required this.id,
      required this.voteAverage,
      required this.title,
      required this.overVeiw,
      required this.posterPath,
      required this.releaseDate});
  factory movie.fromJson(Map<String, dynamic> parsedjson) {
    return movie(
      id: parsedjson['id'],
      voteAverage: parsedjson['vote_average'],
      title: parsedjson['title'],
      overVeiw: parsedjson['overview'],
      posterPath: parsedjson['poster_path'],
      releaseDate: parsedjson['release_date'],
    );
  }
}
