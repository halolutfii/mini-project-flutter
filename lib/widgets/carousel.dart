import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  int _currentIndex = 0;

  final List<Widget> _promoItems = [
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blueAccent,
      ),
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          "Now you can request time-off directly from the app!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.deepOrange,
      ),
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          "New: Performance review available on mobile!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: _promoItems,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            height: 100,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _promoItems.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = entry.key),
              child: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Colors.blueAccent
                      : Colors.grey.shade400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}