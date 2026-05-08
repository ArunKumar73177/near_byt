import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'services/product_service.dart';
import 'services/location_service.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  String? selectedCategory;
  String? selectedCondition;
  List<XFile> pickedImages = [];
  // For web preview: store bytes
  List<Uint8List> webImageBytes = [];
  bool _isSubmitting = false;

  double? _latitude;
  double? _longitude;

  final LocationService _locationService = LocationService();
  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Electronics', 'Vehicles', 'Property',
    'Furniture', 'Sports', 'Fashion', 'Books', 'Other'
  ];
  final List<String> conditions = ['New', 'Like New', 'Good', 'Fair', 'Used'];

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    final saved = await _locationService.getSavedLocation();
    if (saved != null) {
      setState(() {
        _latitude = saved['latitude'];
        _longitude = saved['longitude'];
        _locationController.text = saved['fullAddress'] ?? '';
      });
    }
  }

  Future<void> _pickImages() async {
    if (pickedImages.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 5 images allowed')),
      );
      return;
    }

    final List<XFile> selected = await _picker.pickMultiImage();
    if (selected.isEmpty) return;

    final toAdd = selected.take(5 - pickedImages.length).toList();

    if (kIsWeb) {
      // Read bytes for web preview
      List<Uint8List> bytes = [];
      for (final f in toAdd) {
        bytes.add(await f.readAsBytes());
      }
      setState(() {
        pickedImages.addAll(toAdd);
        webImageBytes.addAll(bytes);
      });
    } else {
      setState(() {
        pickedImages.addAll(toAdd);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      pickedImages.removeAt(index);
      if (kIsWeb) webImageBytes.removeAt(index);
    });
  }

  Widget _buildImagePreview(int index) {
    if (kIsWeb) {
      return Image.memory(
        webImageBytes[index],
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(pickedImages[index].path),
        fit: BoxFit.cover,
      );
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (pickedImages.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least 3 images')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ProductService.createProduct(
        title: _titleController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        category: selectedCategory!,
        condition: selectedCondition!,
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim(),
        latitude: _latitude ?? 0.0,
        longitude: _longitude ?? 0.0,
        imageFiles: pickedImages,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product listed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        _resetForm();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    setState(() {
      selectedCategory = null;
      selectedCondition = null;
      pickedImages = [];
      webImageBytes = [];
    });
    _loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Product to Sell',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Images Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product Images * (Min: 3, Max: 5)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: pickedImages.length +
                            (pickedImages.length < 5 ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == pickedImages.length) {
                            return GestureDetector(
                              onTap: _pickImages,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_photo_alternate, size: 36),
                                      SizedBox(height: 4),
                                      Text('Add Photo',
                                          style: TextStyle(fontSize: 11)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: _buildImagePreview(index),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 16),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pickedImages.length < 3
                            ? 'Please add ${3 - pickedImages.length} more image(s)'
                            : '${pickedImages.length} of 5 images added',
                        style: TextStyle(
                          fontSize: 12,
                          color: pickedImages.length < 3
                              ? Colors.red
                              : Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Details Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Product Title *',
                          hintText: 'e.g. iPhone 13 Pro Max',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                        v!.isEmpty ? 'Please enter a title' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Price (₹) *',
                          hintText: 'e.g. 45000',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                        v!.isEmpty ? 'Please enter a price' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category *',
                          border: OutlineInputBorder(),
                        ),
                        items: categories
                            .map((c) => DropdownMenuItem(
                            value: c, child: Text(c)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => selectedCategory = v),
                        validator: (v) =>
                        v == null ? 'Please select a category' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedCondition,
                        decoration: const InputDecoration(
                          labelText: 'Condition *',
                          border: OutlineInputBorder(),
                        ),
                        items: conditions
                            .map((c) => DropdownMenuItem(
                            value: c, child: Text(c)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => selectedCondition = v),
                        validator: (v) =>
                        v == null ? 'Please select a condition' : null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description *',
                      hintText: 'Describe your product in detail...',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                    v!.isEmpty ? 'Please enter a description' : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location *',
                      hintText: 'e.g. Meerut, Uttar Pradesh',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                    v!.isEmpty ? 'Please enter a location' : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Post Advertisement',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}