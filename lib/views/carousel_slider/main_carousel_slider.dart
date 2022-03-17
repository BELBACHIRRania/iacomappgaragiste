import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselDemo extends StatefulWidget {
  CarouselDemo() : super();
  final String title = "Carousel Demo";

  @override
  CarouselDemoState createState() => CarouselDemoState();
}

class CarouselDemoState extends State<CarouselDemo> {
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/images/2.jpg',
    'assets/images/20.png',
    'assets/images/21.png',
    'assets/images/23.png'
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              carouselSlider = CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,

                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: imgList.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 0.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(imgUrl),
                          ),
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
