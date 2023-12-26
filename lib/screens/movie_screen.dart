import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class MovieScreen extends StatelessWidget {
  String image;
  // const MovieScreen({super.key});
  MovieScreen(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/$image.jpg'),
                  opacity: 0.8,
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          )
        ]),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                image,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'PG-13',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Action',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    '2.3 hrs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 25,
                unratedColor: Colors.white,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                ),
                onRatingUpdate: (rating) {},
              ),
              const SizedBox(height: 20),
              const Text(
                '가디언즈 오브 갤럭시와 함께 우주의 문제를 해결하러 다니던 토르는 잇달아 신들을 살해하는 악당 고르를 대적하는 과정에서 옛 연인 제인 포스터와 재회한다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        )
      ]),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "Add to Wishlist",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {},
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 50,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Row(
//                     children: [
//                       Icon(
//                         Icons.favorite,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                       Text(
//                         "Add to Wishlist",
//                         style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),