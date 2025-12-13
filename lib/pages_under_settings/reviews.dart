// lib/pages_under_settings/reviews.dart

import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  // Dummy data for user reviews (as a buyer/seller) - 4 reviews total
  static const List<Map<String, dynamic>> dummyReviews = [
    {
      'reviewer': 'Priya Singh',
      'rating': 5.0,
      'comment': 'Fast and smooth transaction! The phone was exactly as described. Highly recommended seller.',
      'date': '2 weeks ago',
      'role': 'Buyer',
      'product': 'iPhone 13 Pro Max',
    },
    {
      'reviewer': 'Mohit Verma',
      'rating': 4.0,
      'comment': 'Good communication. Bike was a bit dirty but ran well. Fair trade.',
      'date': '1 month ago',
      'role': 'Buyer',
      'product': 'Mountain Bike - Firefox',
    },
    {
      'reviewer': 'Tech Savvy Store',
      'rating': 5.0,
      'comment': 'Arun was a great buyer! Paid quickly and communicated clearly. Pleasure doing business.',
      'date': '3 months ago',
      'role': 'Seller',
      'product': 'Old Gaming Console',
    },
    {
      'reviewer': 'New Buyer 123',
      'rating': 4.0,
      'comment': 'Got the laptop quickly. Everything is perfect. A reliable seller!',
      'date': '1 week ago',
      'role': 'Buyer',
      'product': 'Dell XPS 15 Laptop',
    },
  ];

  List<Map<String, dynamic>> get reviews => dummyReviews;

  @override
  Widget build(BuildContext context) {
    // Calculate average rating
    final double averageRating = dummyReviews.isNotEmpty
        ? dummyReviews.map((e) => e['rating'] as double).reduce((a, b) => a + b) / dummyReviews.length
        : 0.0;
    final int totalReviews = dummyReviews.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Reviews'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (totalReviews > 0)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  'Your reviews and ratings ($totalReviews reviews).',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            // Rating Summary Card
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < averageRating.floor()
                                  ? Icons.star
                                  : index < averageRating
                                  ? Icons.star_half
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalReviews reviews',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Recent Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Reviews List
            if (dummyReviews.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'No reviews received yet.',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              )
            else
              ...dummyReviews.map((review) => ReviewTile(review: review)),
          ],
        ),
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final Map<String, dynamic> review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      review['role'] == 'Buyer' ? Icons.person : Icons.store,
                      color: Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      review['reviewer'] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${review['rating'].toStringAsFixed(1)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review['comment'] as String,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'On: ${review['product']}',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                Text(
                  review['date'] as String,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}