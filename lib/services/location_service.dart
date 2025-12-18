// lib/services/location_service.dart

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service class to handle all location-related operations
/// Singleton pattern ensures only one instance exists throughout the app
class LocationService {
  // Singleton instance
  static final LocationService _instance = LocationService._internal();

  // Factory constructor returns the same instance
  factory LocationService() => _instance;

  // Private constructor
  LocationService._internal();

  // SharedPreferences keys for storing location data
  static const String _keyLatitude = 'user_latitude';
  static const String _keyLongitude = 'user_longitude';
  static const String _keyCity = 'user_city';
  static const String _keyState = 'user_state';
  static const String _keyCountry = 'user_country';
  static const String _keyFullAddress = 'user_full_address';

  /// Request location permission from the user
  /// Returns true if permission is granted, false otherwise
  Future<bool> requestLocationPermission() async {
    try {
      final status = await Permission.location.request();
      return status.isGranted;
    } catch (e) {
      print('Error requesting location permission: $e');
      return false;
    }
  }

  /// Check if location permission is already granted
  /// Returns true if permission is granted, false otherwise
  Future<bool> hasLocationPermission() async {
    try {
      final status = await Permission.location.status;
      return status.isGranted;
    } catch (e) {
      print('Error checking location permission: $e');
      return false;
    }
  }

  /// Get the user's current GPS location
  /// Returns Position object with latitude, longitude, and other data
  /// Returns null if location cannot be obtained
  Future<Position?> getCurrentLocation() async {
    try {
      // Step 1: Check if location services are enabled on the device
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        throw Exception('Location services are disabled. Please enable location in settings.');
      }

      // Step 2: Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();

      // Step 3: Request permission if denied
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permission denied by user');
          throw Exception('Location permission denied. Please grant location access.');
        }
      }

      // Step 4: Handle permanently denied permissions
      if (permission == LocationPermission.deniedForever) {
        print('Location permissions are permanently denied');
        throw Exception('Location permissions are permanently denied. Please enable in app settings.');
      }

      // Step 5: Get current position with high accuracy
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10), // Timeout after 10 seconds
      );

      print('Location obtained: ${position.latitude}, ${position.longitude}');
      return position;

    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  /// Convert GPS coordinates to a human-readable address
  /// Returns a map containing city, state, country, and full address
  /// Returns null if conversion fails
  Future<Map<String, String>?> getAddressFromCoordinates(
      double latitude,
      double longitude) async {
    try {
      // Use geocoding to get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        // Extract address components
        String city = place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea ??
            'Unknown City';

        String state = place.administrativeArea ?? 'Unknown State';
        String country = place.country ?? 'Unknown Country';

        // Create full address string
        String fullAddress = '';
        if (place.locality != null && place.locality!.isNotEmpty) {
          fullAddress = place.locality!;
        }
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          if (fullAddress.isNotEmpty) {
            fullAddress += ', ${place.administrativeArea!}';
          } else {
            fullAddress = place.administrativeArea!;
          }
        }

        // Fallback to Unknown Location if empty
        if (fullAddress.isEmpty) {
          fullAddress = 'Unknown Location';
        }

        print('Address obtained: $fullAddress');

        return {
          'city': city,
          'state': state,
          'country': country,
          'fullAddress': fullAddress,
        };
      }

      print('No placemarks found for coordinates');
      return null;

    } catch (e) {
      print('Error getting address from coordinates: $e');
      return null;
    }
  }

  /// Fetch current location and save it to device storage
  /// This is the main method to call when you need fresh location data
  /// Returns a map with all location data or null if failed
  Future<Map<String, dynamic>?> fetchAndSaveLocation() async {
    try {
      print('Fetching current location...');

      // Get GPS position
      Position? position = await getCurrentLocation();
      if (position == null) {
        print('Failed to get GPS position');
        return null;
      }

      // Convert coordinates to address
      Map<String, String>? address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (address == null) {
        print('Failed to get address from coordinates');
        return null;
      }

      // Save all data to SharedPreferences for future use
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_keyLatitude, position.latitude);
      await prefs.setDouble(_keyLongitude, position.longitude);
      await prefs.setString(_keyCity, address['city']!);
      await prefs.setString(_keyState, address['state']!);
      await prefs.setString(_keyCountry, address['country']!);
      await prefs.setString(_keyFullAddress, address['fullAddress']!);

      print('Location saved to storage');

      // Return combined data
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'city': address['city'],
        'state': address['state'],
        'country': address['country'],
        'fullAddress': address['fullAddress'],
      };

    } catch (e) {
      print('Error in fetchAndSaveLocation: $e');
      return null;
    }
  }

  /// Retrieve previously saved location from device storage
  /// This is faster than fetching new location data
  /// Returns null if no saved location exists
  Future<Map<String, dynamic>?> getSavedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Check if location data exists
      if (!prefs.containsKey(_keyLatitude) || !prefs.containsKey(_keyLongitude)) {
        print('No saved location found');
        return null;
      }

      // Retrieve all saved data
      final latitude = prefs.getDouble(_keyLatitude);
      final longitude = prefs.getDouble(_keyLongitude);
      final city = prefs.getString(_keyCity);
      final state = prefs.getString(_keyState);
      final country = prefs.getString(_keyCountry);
      final fullAddress = prefs.getString(_keyFullAddress);

      // Validate that we have at least coordinates
      if (latitude == null || longitude == null) {
        print('Saved location data is incomplete');
        return null;
      }

      print('Loaded saved location: $fullAddress');

      return {
        'latitude': latitude,
        'longitude': longitude,
        'city': city ?? 'Unknown',
        'state': state ?? 'Unknown',
        'country': country ?? 'Unknown',
        'fullAddress': fullAddress ?? 'Unknown Location',
      };

    } catch (e) {
      print('Error getting saved location: $e');
      return null;
    }
  }

  /// Clear all saved location data from device storage
  Future<void> clearSavedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyLatitude);
      await prefs.remove(_keyLongitude);
      await prefs.remove(_keyCity);
      await prefs.remove(_keyState);
      await prefs.remove(_keyCountry);
      await prefs.remove(_keyFullAddress);
      print('Saved location cleared');
    } catch (e) {
      print('Error clearing saved location: $e');
    }
  }

  /// Calculate straight-line distance between two GPS coordinates
  /// Returns distance in kilometers
  /// Uses the Haversine formula for accurate calculation
  double calculateDistance(
      double startLatitude,
      double startLongitude,
      double endLatitude,
      double endLongitude,
      ) {
    try {
      // Geolocator.distanceBetween returns distance in meters
      double distanceInMeters = Geolocator.distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );

      // Convert meters to kilometers
      double distanceInKm = distanceInMeters / 1000;

      return distanceInKm;
    } catch (e) {
      print('Error calculating distance: $e');
      return 0.0;
    }
  }

  /// Open device settings so user can manually grant location permission
  /// Useful when permissions are permanently denied
  Future<void> openAppSettings() async {
    try {
      await Geolocator.openAppSettings();
    } catch (e) {
      print('Error opening app settings: $e');
    }
  }

  /// Open device location settings
  /// Useful when location services are disabled
  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (e) {
      print('Error opening location settings: $e');
    }
  }

  /// Get a formatted string showing distance
  /// Examples: "2.5 km", "350 m", "0 km"
  String formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      // Show in meters if less than 1 km
      int meters = (distanceInKm * 1000).round();
      return '$meters m';
    } else {
      // Show in km with 1 decimal place
      return '${distanceInKm.toStringAsFixed(1)} km';
    }
  }

  /// Check if the device has location services enabled
  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      print('Error checking location service: $e');
      return false;
    }
  }
}