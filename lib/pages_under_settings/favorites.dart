// lib/pages_under_settings/favorites.dart

import 'package:flutter/material.dart';
import '../main_page.dart'; // Import the Product model and mockProducts

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  // Dummy list of favorite product IDs
  static const List<String> favoriteProductIds = ['1', '3'];

  // Filter mockProducts to get only the favorites
  List<Product> get favoriteProducts {
    return mockProducts
        .where((product) => favoriteProductIds.contains(product.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = favoriteProducts;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Favorites'),
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
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return FavoriteProductCard(product: product);
        },
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
      margin: const EdgeInsets.only(bottom: 12),
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
                content: Text('${product.title} removed from favorites'),
              ),
            );
          },
        ),
      ),
    );
  }
}