import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movies_model.dart';
import 'package:flutter_movie/services/api_service.dart';
import 'package:flutter_movie/widgets/movies_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  // List<MoviesModel> Movie = [];
  // bool isLoading = true;

  // void waitForMovies() async {
  //   Movie = await ApiService.getMovies();
  //   isLoading = true;
  //   setState() {}
  // }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<MoviesModel>> movies;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSection);
    movies = ApiService.getMovies();
    super.initState();
  }

  _handleTabSection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          title: const Text(
            "Movies Streaming",
            style: TextStyle(color: Colors.white),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
        ),
        //... (이전 코드와 동일)
        body: FutureBuilder(
          future: movies,
          builder: (context, AsyncSnapshot<List<MoviesModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Center(
                child: Text(
                  'Error loading data: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              final List<MoviesModel> movieList = snapshot.data!;
              print("Movie list length: ${movieList.length}");
              // 여기서 movieList를 사용하여 화면을 구성하도록 수정
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  makeList(movieList)
                ],
              );
            } else {
              print("No data available");
              return const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              );
            }
          },
        ));
  }

  CarouselSlider makeList(List<MoviesModel> movieList) =>
      CarouselSlider.builder(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
        itemCount: movieList.length,
        itemBuilder: (context, index, realIndex) {
          final MoviesModel movie = movieList[index];
          return Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  movie.title,
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  softWrap: true,
                ),
              ],
            ),
          );
        },
      );
}
