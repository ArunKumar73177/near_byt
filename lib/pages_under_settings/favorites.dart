// lib/pages_under_settings/favorites.dart

import 'package:flutter/material.dart';
import '../main_page.dart'; // Import the Product model and mockProducts

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  // Dummy list of favorite product IDs, repeated to match the requested count of 8
  static const List<String> favoriteProductIds = [
    '1', // iPhone 13 Pro Max
    '2', // Royal Enfield Classic 350
    '3', // Sony PlayStation 5
    '4', // Dell XPS 15 Laptop
    '1', // Repeated
    '2', // Repeated
    '3', // Repeated
    '4', // Repeated
  ];

  // Filter mockProducts to get only the favorites, matching the 8 IDs
  List<Product> get favoriteProducts {
    final allProducts = mockProducts;

    // Create the list of 8 products by finding the corresponding product for each ID in the list.
    final List<Product> favorites = [];
    for (final id in favoriteProductIds) {
      final product = allProducts.firstWhere(
            (p) => p.id == id,
        orElse: () => allProducts.first,
      );
      favorites.add(product);
    }
    return favorites;
  }

  @override
  Widget build(BuildContext context) {
    final products = favoriteProducts;
    final count = products.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: products.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No favorites yet!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the heart icon on a product to add it here.',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              'Your favorite products ($count items).', // Dynamic text: 8 items
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FavoriteProductCard(product: product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteProductCard extends StatelessWidget {
  final Product product;
  const FavoriteProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: const Icon(Icons.image),
              );
            },
          ),
        ),
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '₹ ${product.price.toStringAsFixed(0)} • ${product.location}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            // Logic to remove from favorites
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.title} removed from favorites (Mock Action)'),
              ),
            );
          },
        ),
      ),
    );
  }
}