import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movies_model.dart';

class popularMovie extends StatelessWidget {
  const popularMovie({
    super.key,
    required this.movieList,
  });

  final List<MoviesModel> movieList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: movieList.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        final MoviesModel movie = movieList[index];
        // movie를 사용하여 각 항목을 렌더링하는 로직을 작성
        return Column(
          children: [
            Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10),
                      color: Colors.black.withOpacity(0.3),
                    )
                  ]),
              child: Image.network(movie.posterPath),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 22),
              softWrap: true,
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
