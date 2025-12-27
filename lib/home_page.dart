// lib/home_page.dart

import 'package:flutter/material.dart';
import 'services/location_service.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  double distanceRange = 10;
  final List<String> categories = [
    'All',
    'Electronics',
    'Vehicles',
    'Property',
    'Furniture',
    'Sports'
  ];

  String _currentLocation = 'Getting location...';
  double? _userLatitude;
  double? _userLongitude;
  bool _isLoadingLocation = true;
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    // Try to get saved location first
    Map<String, dynamic>? savedLocation =
    await _locationService.getSavedLocation();

    if (savedLocation != null) {
      setState(() {
        _currentLocation = savedLocation['fullAddress'] ?? 'Unknown Location';
        _userLatitude = savedLocation['latitude'];
        _userLongitude = savedLocation['longitude'];
        _isLoadingLocation = false;
      });
    } else {
      // No saved location, fetch new one
      await _fetchNewLocation();
    }
  }

  Future<void> _fetchNewLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    Map<String, dynamic>? location =
    await _locationService.fetchAndSaveLocation();

    if (location != null) {
      setState(() {
        _currentLocation = location['fullAddress'] ?? 'Unknown Location';
        _userLatitude = location['latitude'];
        _userLongitude = location['longitude'];
        _isLoadingLocation = false;
      });
    } else {
      setState(() {
        _currentLocation = 'Location unavailable';
        _isLoadingLocation = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unable to get location. Please enable location services.'),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: () => LocationService().openAppSettings(),
            ),
          ),
        );
      }
    }
  }

  List<Product> _getFilteredProducts() {
    return mockProducts.where((product) {
      final categoryMatch =
          selectedCategory == 'All' || product.category == selectedCategory;

      // Calculate real distance if user location is available
      double distance = product.distance;
      if (_userLatitude != null && _userLongitude != null) {
        distance = _locationService.calculateDistance(
          _userLatitude!,
          _userLongitude!,
          product.latitude,
          product.longitude,
        );
      }

      final distanceMatch = distance <= distanceRange;
      return categoryMatch && distanceMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2563EB),
                                    Color(0xFF9333EA),
                                    Color(0xFFEC4899),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'N',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                        colors: [
                                          Color(0xFF2563EB),
                                          Color(0xFF9333EA),
                                          Color(0xFFEC4899),
                                        ],
                                      ).createShader(bounds),
                                  child: const Text(
                                    'NearByt',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'BUY LOCAL',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.tune),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (context, setModalState) => Container(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Filter Products',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        'Distance Range: ${distanceRange.toInt()} km',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Slider(
                                        value: distanceRange,
                                        min: 1,
                                        max: 20,
                                        divisions: 19,
                                        onChanged: (value) {
                                          setModalState(() {
                                            distanceRange = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Location Display with Refresh
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.grey[600], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _isLoadingLocation
                              ? Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                      Colors.grey[600]!),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _currentLocation,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          )
                              : Text(
                            _currentLocation,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.refresh, color: Colors.blue[700]),
                          onPressed: _fetchNewLocation,
                          tooltip: 'Refresh location',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;
                        return ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Products Grid
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Showing ${filteredProducts.length} products within ${distanceRange.toInt()} km',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: filteredProducts[index]);
                      },
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