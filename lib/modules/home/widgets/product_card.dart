import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, String> product;
  final bool favorite;

  const ProductCard({super.key, required this.product, required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product['img']!,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                  color: favorite ? Colors.red : Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '${product['brand']}'),
                TextSpan(
                  text: ' ⭐ ${product['rating']} ',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: '(${product['reviews']})'),
              ],
              style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            product['name']!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: product['price']!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextSpan(text: '  '),
                TextSpan(
                  text: product['oldPrice']!,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                TextSpan(text: '  '),
                WidgetSpan(
                  child: Container(
                    color: Colors.red.shade50,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      product['discount']!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
