import 'package:flutter/material.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final controller = PageController(viewportFraction: 0.92);
  int current = 0;

  final banners = [
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=1200',
    'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=1200',
    'https://images.unsplash.com/photo-1521119989659-a83eee488004?w=1200',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            controller: controller,
            itemCount: banners.length,
            onPageChanged: (i) => setState(() => current = i),
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(banners[i], fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: current == i ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: current == i ? Colors.black : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      ],
    );
  }
}