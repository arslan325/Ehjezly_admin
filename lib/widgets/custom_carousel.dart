import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget{
  const CustomCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(height:200,
          autoPlay: true,
          aspectRatio: 16/9,
          viewportFraction: 0.8,
          autoPlayAnimationDuration: const Duration(seconds: 2),
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayInterval: const Duration(seconds: 3),
          //scrollDirection: Axis.vertical,
        ),
        items: [
          MyImageView("images/image1.jpg"),
          MyImageView("images/image2.jpg"),
          MyImageView("images/image1.jpg"),
          MyImageView("images/image2.jpg"),
          MyImageView("images/image1.jpg"),
          MyImageView("images/image2.jpg"),
        ]
    );
  }

}

class MyImageView extends StatelessWidget {
  String imgPath;
  MyImageView(this.imgPath, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 400,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
          ),
        )
    );
  }
}
