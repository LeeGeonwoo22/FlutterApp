import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movies_model.dart';
import 'package:flutter_movie/services/api_service.dart';
import 'package:flutter_movie/widgets/movies_section.dart';
import 'package:flutter_movie/widgets/popular_movie.dart';

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
            if (snapshot.hasData) {
              final List<MoviesModel> movieList = snapshot.data!;
              print("Movie list length: ${movieList.length}");
              // 여기서 movieList를 사용하여 화면을 구성하도록 수정
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(child: popularMovie(movieList: movieList))
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
}
