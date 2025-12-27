// lib/account.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import pages from the settings subdirectory
import 'pages_under_settings/my_listings.dart' as listings_page;
import 'pages_under_settings/favorites.dart' as favorites_page;
import 'pages_under_settings/reviews.dart' as reviews_page;
import 'pages_under_settings/settings.dart';
import 'pages_under_settings/help_and_support.dart';
import 'edit_profile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _fullName = 'Arun Sharma';
  String _email = 'arunsharma73177@gmail.com';
  String _memberSince = 'Member since Jan 2024';
  String _profileImage = 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200';

  // Mock data for active listings
  final List<Map<String, Object>> userProducts = [
    {
      'title': 'Dell XPS 15 Laptop',
      'price': 85000,
      'status': 'Active',
      'views': 234,
      'image':
      'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=200',
    },
    {
      'title': 'Mountain Bike - Firefox',
      'price': 15000,
      'status': 'Sold',
      'views': 456,
      'image':
      'https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=200',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fullName = prefs.getString('fullName') ?? 'Arun Sharma';
      _email = prefs.getString('username') != null
          ? '${prefs.getString('username')}@temp.com'
          : 'arunsharma73177@gmail.com';
      _profileImage = prefs.getString('profileImage') ??
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200';
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('username');
      await prefs.remove('fullName');

      if (!context.mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
            (route) => false,
      );
    }
  }

  Widget _buildMenuItem(IconData icon, String label, String? count,
      VoidCallback? onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (count != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(count),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Count Calculation
    final listingsInstance = listings_page.MyListingsPage();
    final totalListingsCount = listingsInstance.userListings.length;

    final activeListingsCount = userProducts.where((p) => p['status'] == 'Active').length;
    final soldListingsCount = userProducts.where((p) => p['status'] == 'Sold').length;

    final favoritesCount = favorites_page.FavoritesPage.favoriteProductIds.length;
    final reviewsCount = reviews_page.ReviewsPage.dummyReviews.length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Account',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.blue[800],
                          backgroundImage: NetworkImage(_profileImage),
                          onBackgroundImageError: (exception, stackTrace) {
                            if (mounted) {
                              setState(() {
                                _profileImage = '';
                              });
                            }
                          },
                          child: _profileImage.isEmpty
                              ? Text(
                            _fullName.isNotEmpty
                                ? _fullName[0].toUpperCase()
                                : 'A',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _fullName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _email,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                _memberSince,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const EditProfilePage(),
                              ),
                            );
                            if (result == true && mounted) {
                              _loadUserData();
                            }
                          },
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Listings',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Text(
                              activeListingsCount.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Sold',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            Text(
                              soldListingsCount.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Rating',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const Text(
                              '4.5 ⭐',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  _buildMenuItem(
                      Icons.shopping_bag,
                      'My Listings',
                      totalListingsCount.toString(),
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const listings_page.MyListingsPage()));
                      }),
                  _buildMenuItem(
                      Icons.favorite,
                      'Favorites',
                      favoritesCount.toString(),
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const favorites_page.FavoritesPage()));
                      }),
                  _buildMenuItem(
                      Icons.star,
                      'Reviews',
                      reviewsCount.toString(),
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const reviews_page.ReviewsPage()));
                      }),
                  _buildMenuItem(Icons.settings, 'Settings', null, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  }),
                  _buildMenuItem(Icons.help, 'Help & Support', null, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpAndSupportPage()));
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Active Listings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...userProducts.map((product) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product['image'] as String,
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
                                    product['title'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: product['status'] == 'Active'
                                        ? Colors.blue
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    product['status'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₹ ${(product['price'] as int).toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${product['views']} views',
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
            }).toList(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _handleLogout(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}