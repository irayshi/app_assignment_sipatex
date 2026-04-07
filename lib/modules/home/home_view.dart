import 'package:app_assignment_sipatex/modules/home/home_controller.dart';
import 'package:app_assignment_sipatex/modules/home/widgets/banner_carousel.dart';
import 'package:app_assignment_sipatex/modules/home/widgets/custom_bottom_nav.dart';
import 'package:app_assignment_sipatex/modules/home/widgets/product_card.dart';
import 'package:app_assignment_sipatex/modules/home/widgets/search_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:icons_plus/icons_plus.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Womens', 'img': 'https://i.pravatar.cc/100?img=48'},
      {'name': 'Mens', 'img': 'https://i.pravatar.cc/100?img=12'},
      {'name': 'Kids', 'img': 'https://i.pravatar.cc/100?img=14'},
      {'name': 'Wetsuits', 'img': 'https://i.pravatar.cc/100?img=33'},
      {'name': 'Boards', 'img': 'https://i.pravatar.cc/100?img=25'},
    ];

    final products = [
      {
        'name': 'Fun Times Shirt',
        'brand': 'Rip Curl',
        'rating': '4.9',
        'reviews': '126',
        'price': '\$39.99',
        'oldPrice': '\$79.00',
        'discount': '-50%',
        'img':
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=600',
      },
      {
        'name': 'Pipeline Short Sleeve',
        'brand': 'Hurley',
        'rating': '4.8',
        'reviews': '94',
        'price': '\$47.99',
        'oldPrice': '\$79.00',
        'discount': '-39%',
        'img':
            'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=600',
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              backgroundColor: Colors.white,
              toolbarHeight: 72,
              scrolledUnderElevation: 0,
              actions: [
                const Icon(AntDesign.shop_outline, size: 24),
                const SizedBox(width: 12),
                Badge(
                  backgroundColor: Colors.red,
                  label: Text('5'),
                  textStyle: TextStyle(color: Colors.white, fontSize: 10),
                  child: const Icon(Icons.notifications_none, size: 24),
                ),
                const SizedBox(width: 12),
              ],
              title: SearchBar(),
            ),
            SliverToBoxAdapter(child: BannerCarousel()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 0,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    _sectionHeader('Shop by Category'),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 92,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) {
                          final item = categories[i];
                          return Column(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(item['img']!),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['name']!,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemCount: categories.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 12,
                  left: 20,
                  right: 20,
                ),
                child: _sectionHeader('For Your Fashion'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childCount: products.length,
                itemBuilder: (context, i) =>
                    ProductCard(product: products[i], favorite: false),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNav(
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.currentIndex.value = i,
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        const Text('See All', style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
