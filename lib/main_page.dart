
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'search.dart';
import 'sell.dart';
import 'alerts.dart';
import 'account.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const SellPage(),
    const AlertsPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
class Product {
  final String id;
  final String title;
  final double price;
  final String location;
  final double distance;
  final String image;
  final List<String>? images;
  final String category;
  final String condition;
  final String description;
  final String seller;
  final String postedDate;
  final double latitude;
  final double longitude;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.distance,
    required this.image,
    this.images,
    required this.category,
    required this.condition,
    required this.description,
    required this.seller,
    required this.postedDate,
    required this.latitude,
    required this.longitude,
  });
}
// Demo Productsgit
final List<Product> mockProducts = [
  Product(
    id: '1',
    title: 'iPhone 13 Pro Max',
    price: 45000,
    location: 'Mumbai, Maharashtra',
    distance: 2.5,
    latitude: 19.0760,
    longitude: 72.8777,
    image: 'https://images.unsplash.com/photo-1632661674596-df8be070a5c5?w=400',
    images: [
      'https://images.unsplash.com/photo-1632661674596-df8be070a5c5?w=400',
      'https://images.unsplash.com/photo-1611472173362-3f53dbd65d80?w=400',
      'https://images.unsplash.com/photo-1592286927505-b0e6d5d0abcb?w=400',
    ],
    category: 'Electronics',
    condition: 'Like New',
    description: 'Excellent condition, 256GB, Pacific Blue',
    seller: 'Rahul Kumar',
    postedDate: '2 hours ago',
  ),
  Product(
    id: '2',
    title: 'Royal Enfield Classic 350',
    price: 125000,
    location: 'Pune, Maharashtra',
    distance: 5.8,
    latitude: 18.5204,
    longitude: 73.8567,
    image: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400',
    images: [
      'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400',
      'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=400',
    ],
    category: 'Vehicles',
    condition: 'Used',
    description: '2020 model, well maintained, single owner',
    seller: 'Arun Sharma',
    postedDate: '5 hours ago',
  ),
  Product(
    id: '3',
    title: 'Sony PlayStation 5',
    price: 42000,
    location: 'Delhi, NCR',
    distance: 3.2,
    latitude: 28.7041,
    longitude: 77.1025,
    image: 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400',
    category: 'Electronics',
    condition: 'New',
    description: 'Brand new, sealed pack with 2 controllers',
    seller: 'Gaming Store',
    postedDate: '1 day ago',
  ),
  Product(
    id: '4',
    title: 'Dell XPS 15 Laptop',
    price: 85000,
    location: 'Hyderabad, Telangana',
    distance: 6.1,
    latitude: 17.3850,
    longitude: 78.4867,
    image: 'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=400',
    category: 'Electronics',
    condition: 'Like New',
    description: 'i7 processor, 16GB RAM, 512GB SSD',
    seller: 'Arun Sharma',
    postedDate: '4 hours ago',
  ),

  Product(
    id: '5',
    title: 'Samsung Galaxy S23 Ultra',
    price: 89999,
    location: 'Shastri Nagar, Meerut',
    distance: 1.2,
    latitude: 28.9845,
    longitude: 77.7064,
    image: 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400',
    images: [
      'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400',
      'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400',
    ],
    category: 'Electronics',
    condition: 'New',
    description: '12GB RAM, 256GB Storage, Phantom Black, with warranty',
    seller: 'Tech Plaza Meerut',
    postedDate: '3 hours ago',
  ),
  Product(
    id: '6',
    title: 'Honda City 2019',
    price: 725000,
    location: 'Civil Lines, Meerut',
    distance: 2.3,
    latitude: 29.0012,
    longitude: 77.7085,
    image: 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=400',
    images: [
      'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=400',
      'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
    ],
    category: 'Vehicles',
    condition: 'Used',
    description: 'VX model, white color, single owner, well maintained',
    seller: 'Vikram Singh',
    postedDate: '1 day ago',
  ),
  Product(
    id: '7',
    title: 'L-Shaped Sofa Set',
    price: 35000,
    location: 'Kanker Khera, Meerut',
    distance: 3.1,
    latitude: 28.9678,
    longitude: 77.7234,
    image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
    category: 'Furniture',
    condition: 'Like New',
    description: 'Grey fabric, 6 seater, bought 6 months ago',
    seller: 'Neha Gupta',
    postedDate: '2 days ago',
  ),
  Product(
    id: '8',
    title: 'Apple MacBook Air M2',
    price: 95000,
    location: 'Pallavpuram, Meerut',
    distance: 1.8,
    latitude: 28.9923,
    longitude: 77.6945,
    image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
    images: [
      'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=400',
    ],
    category: 'Electronics',
    condition: 'Like New',
    description: '8GB RAM, 256GB SSD, Midnight color, under warranty',
    seller: 'Rajesh Verma',
    postedDate: '5 hours ago',
  ),
  Product(
    id: '9',
    title: 'Treadmill - Powermax Fitness',
    price: 22000,
    location: 'Saket, Meerut',
    distance: 2.7,
    latitude: 28.9756,
    longitude: 77.7156,
    image: 'https://images.unsplash.com/photo-1538805060514-97d9cc17730c?w=400',
    category: 'Sports',
    condition: 'Good',
    description: 'Automatic treadmill with incline, perfect working condition',
    seller: 'Fitness World',
    postedDate: '6 hours ago',
  ),
  Product(
    id: '10',
    title: 'Bajaj Pulsar NS200',
    price: 95000,
    location: 'Brahmpuri, Meerut',
    distance: 3.5,
    latitude: 29.0089,
    longitude: 77.7123,
    image: 'https://images.unsplash.com/photo-1558981806-ec527fa84c39?w=400',
    category: 'Vehicles',
    condition: 'Used',
    description: '2021 model, 18000 km driven, excellent condition',
    seller: 'Amit Kumar',
    postedDate: '8 day ago',
  ),
  Product(
    id: '11',
    title: 'LG 43 inch 4K Smart TV',
    price: 32000,
    location: 'Modipuram, Meerut',
    distance: 4.2,
    latitude: 29.0234,
    longitude: 77.6789,
    image: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400',
    category: 'Electronics',
    condition: 'New',
    description: 'Brand new sealed pack, webOS, HDR support',
    seller: 'Electronics Hub',
    postedDate: '8 hours ago',
  ),
  Product(
    id: '12',
    title: 'Study Table with Chair',
    price: 8500,
    location: 'Ganga Nagar, Meerut',
    distance: 2.1,
    latitude: 28.9934,
    longitude: 77.7234,
    image: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=400',
    category: 'Furniture',
    condition: 'Good',
    description: 'Wooden study table with comfortable chair, good for students',
    seller: 'Priya Sharma',
    postedDate: '3 days ago',
  ),
  Product(
    id: '13',
    title: 'Canon EOS 1500D DSLR',
    price: 28000,
    location: 'Hapur Road, Meerut',
    distance: 3.8,
    latitude: 28.9567,
    longitude: 77.7345,
    image: 'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400',
    images: [
      'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400',
      'https://images.unsplash.com/photo-1606913084603-3e7702b01627?w=400',
    ],
    category: 'Electronics',
    condition: 'Like New',
    description: '24MP, with 18-55mm lens, bag and accessories included',
    seller: 'Photography Store',
    postedDate: '12 hours ago',
  ),
  Product(
    id: '14',
    title: 'Mountain Bike - Firefox',
    price: 15000,
    location: 'Lalkurti, Meerut',
    distance: 1.5,
    latitude: 28.9789,
    longitude: 77.7089,
    image: 'https://images.unsplash.com/photo-1576435728678-68d0fbf94e91?w=400',
    category: 'Sports',
    condition: 'Good',
    description: '21 speed gears, front suspension, rarely used',
    seller: 'Rohit Joshi',
    postedDate: '2 days ago',
  ),
  Product(
    id: '15',
    title: '2BHK Flat for Rent',
    price: 12000,
    location: 'Shastri Nagar, Meerut',
    distance: 1.1,
    latitude: 28.9856,
    longitude: 77.7078,
    image: 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400',
    category: 'Property',
    condition: 'Good',
    description: 'Spacious 2BHK, semi-furnished, family preferred',
    seller: 'Property Dealer',
    postedDate: '1 week ago',
  ),
];

// Product Card Widget (Reusable)
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, size: 50),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product.condition,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  if (product.images != null && product.images!.length > 1)
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${product.images!.length} photos',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
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
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          product.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        product.postedDate,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Page
class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images ?? [widget.product.image];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      itemCount: images.length,
                      onPageChanged: (index) {
                        setState(() {
                          selectedImageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.network(
                          images[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, size: 100),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  if (images.length > 1)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: selectedImageIndex == index
                                  ? Colors.blue
                                  : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[50]!, Colors.purple[50]!],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[100]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹ ${widget.product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            Chip(
                              label: Text(widget.product.condition),
                              backgroundColor: Colors.blue,
                              labelStyle: const TextStyle(color: Colors.white),
                            ),
                            Text('• ${widget.product.distance} km away'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.description,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Product Details',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildDetailRow('Category', widget.product.category),
                        _buildDetailRow('Condition', widget.product.condition),
                        _buildDetailRow('Location', widget.product.location),
                        _buildDetailRow(
                            'Distance', '${widget.product.distance} km away'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Seller Information',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                widget.product.seller[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.seller,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Posted ${widget.product.postedDate}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Buy'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Chat'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Call'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}