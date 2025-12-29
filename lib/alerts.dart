// lib/alerts.dart

import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'type': 'message',
        'title': 'New Message',
        'message': 'Rahul Kumar sent you a message about "iPhone 13 Pro Max"',
        'time': '5 minutes ago',
        'read': false,
      },
      {
        'type': 'like',
        'title': 'Someone liked your product',
        'message': 'Your "Dell XPS 15 Laptop" was added to favorites',
        'time': '1 hour ago',
        'read': false,
      },
      {
        'type': 'price_drop',
        'title': 'Price Drop Alert',
        'message': 'Sony PlayStation 5 is now ₹2,000 cheaper in your area',
        'time': '3 hours ago',
        'read': true,
      },
      {
        'type': 'sold',
        'title': 'Product Sold',
        'message': 'Congratulations! Your "Mountain Bike" has been sold',
        'time': '1 day ago',
        'read': true,
      },
      {
        'type': 'message',
        'title': 'New Message',
        'message': 'Tech Plaza Meerut replied to your inquiry about Samsung Galaxy S23',
        'time': '2 days ago',
        'read': true,
      },
      {
        'type': 'like',
        'title': 'Product Interest',
        'message': '3 people added your "Treadmill" to their watchlist',
        'time': '3 days ago',
        'read': true,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read functionality
            },
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final isRead = notification['read'] as bool;

          IconData icon;
          Color iconColor;

          switch (notification['type']) {
            case 'message':
              icon = Icons.message;
              iconColor = Colors.blue;
              break;
            case 'like':
              icon = Icons.favorite;
              iconColor = Colors.red;
              break;
            case 'price_drop':
              icon = Icons.trending_down;
              iconColor = Colors.green;
              break;
            case 'sold':
              icon = Icons.shopping_bag;
              iconColor = Colors.purple;
              break;
            default:
              icon = Icons.notifications;
              iconColor = Colors.grey;
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isRead ? Colors.white : Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification['title'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (!isRead)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'New',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification['message'] as String,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'] as String,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}