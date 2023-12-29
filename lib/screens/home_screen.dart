import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movies_model.dart';
import 'package:flutter_movie/services/api_service.dart';
import 'package:flutter_movie/widgets/movies_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
            return ListView(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 200,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: movieList.asMap().entries.map((entry) {
                    // final int index = entry.key;
                    final MoviesModel movie = entry.value;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.white,
                  isScrollable: true,
                  indicator: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  labelStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(left: 10),
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Action'),
                    Tab(text: 'Adventure'),
                    Tab(text: 'Comedy'),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: [
                    Container(),
                    MoviesSection(),
                    Container(),
                    Container(),
                    Container(),
                  ][_tabController.index],
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
