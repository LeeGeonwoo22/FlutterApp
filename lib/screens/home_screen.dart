import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie/widgets/movies_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSection);
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
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 230,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/upcoming1.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/upcoming2.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/upcoming3.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/upcoming4.jpg"),
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
          const SizedBox(height: 30),
          TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicator: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
              MoviesSection(),
              Container(),
              Container(),
              Container(),
            ][_tabController.index],
          )
        ],
      ),
    );
  }
}
