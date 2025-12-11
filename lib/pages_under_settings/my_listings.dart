// lib/pages_under_settings/my_listings.dart

import 'package:flutter/material.dart';
import '../main_page.dart'; // Import the Product model and mockProducts

class MyListingsPage extends StatelessWidget {
  const MyListingsPage({super.key});

  // Dummy list of user's products (matching the AccountPage data - total 2)
  List<Product> get userListings {
    // Filter mockProducts where the seller is 'Arun Sharma' (2 products)
    return mockProducts.where((p) => p.seller == 'Arun Sharma').toList();
  }

  @override
  Widget build(BuildContext context) {
    final listings = userListings;
    final totalCount = listings.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Listings'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // Navigate to Add Product Page (index 2 in MainPage)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('To add a new listing, use the "Sell" tab on the main screen.')),
              );
            },
          ),
        ],
      ),
      body: totalCount == 0
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list_alt, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No active listings found.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the "+" icon to post your first ad.',
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
              'Your product listings ($totalCount items).', // Dynamic text: 2 items
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: listings.length,
              itemBuilder: (context, index) {
                return ListingItemCard(product: listings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListingItemCard extends StatelessWidget {
  final Product product;
  const ListingItemCard({super.key, required this.product});

  // Mock status logic to match the screenshot/AccountPage data
  String get status {
    if (product.title == 'Dell XPS 15 Laptop') return 'Active';
    if (product.title.contains('Classic 350')) return 'Sold'; // Represents the Sold bike listing
    return 'Active';
  }

  Color get statusColor {
    return status == 'Active' ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹ ${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(product.distance * 38).toInt()} views', // Mock views
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Menu for actions like Edit/Mark as Sold
            PopupMenuButton<String>(
              onSelected: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Action: $value on ${product.title}')),
                );
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Edit',
                  child: Text('Edit Listing'),
                ),
                PopupMenuItem(
                  value: 'Mark as Sold',
                  child: Text(status == 'Active' ? 'Mark as Sold' : 'Mark as Active'),
                ),
                const PopupMenuItem(
                  value: 'Delete',
                  child: Text('Delete Listing', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}