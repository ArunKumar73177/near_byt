// lib/services/location_service.dart

import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/secrets.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  static const String _googleApiKey = googleMapsApiKey;

  static const String _keyLatitude = 'user_latitude';
  static const String _keyLongitude = 'user_longitude';
  static const String _keyCity = 'user_city';
  static const String _keyState = 'user_state';
  static const String _keyCountry = 'user_country';
  static const String _keyFullAddress = 'user_full_address';

  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // ← change to low for web
        timeLimit: const Duration(seconds: 15), // ← increase timeout
      );
      print('Location obtained: ${position.latitude}, ${position.longitude}');
      return position;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  Future<Map<String, String>?> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json'
          '?latlng=$latitude,$longitude&key=$_googleApiKey';

      final response = await Dio().get(url);

      if (response.data['status'] == 'OK') {
        final results = response.data['results'] as List;
        if (results.isEmpty) return null;

        // Extract address components from first result
        final components =
        results[0]['address_components'] as List;

        String city = '';
        String state = '';
        String country = '';

        for (final component in components) {
          final types = List<String>.from(component['types']);
          if (types.contains('locality')) {
            city = component['long_name'];
          } else if (types.contains('administrative_area_level_1')) {
            state = component['long_name'];
          } else if (types.contains('country')) {
            country = component['long_name'];
          }
        }

        // Use formatted_address as full address
        final fullAddress = results[0]['formatted_address'] as String? ?? '';

        // Build a shorter display address (city, state)
        String displayAddress = '';
        if (city.isNotEmpty) displayAddress = city;
        if (state.isNotEmpty) {
          displayAddress += displayAddress.isNotEmpty ? ', $state' : state;
        }
        if (displayAddress.isEmpty) displayAddress = fullAddress;

        print('Address obtained: $displayAddress');

        return {
          'city': city.isNotEmpty ? city : 'Unknown City',
          'state': state.isNotEmpty ? state : 'Unknown State',
          'country': country.isNotEmpty ? country : 'Unknown Country',
          'fullAddress': displayAddress.isNotEmpty ? displayAddress : 'Unknown Location',
        };
      } else {
        print('Geocoding API error: ${response.data['status']}');
        return null;
      }
    } catch (e) {
      print('Error getting address from coordinates: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchAndSaveLocation() async {
    try {
      print('Fetching current location...');

      Position? position = await getCurrentLocation();
      if (position == null) {
        print('Failed to get GPS position');
        return null;
      }

      Map<String, String>? address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (address == null) {
        print('Failed to get address from coordinates');
        return null;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_keyLatitude, position.latitude);
      await prefs.setDouble(_keyLongitude, position.longitude);
      await prefs.setString(_keyCity, address['city']!);
      await prefs.setString(_keyState, address['state']!);
      await prefs.setString(_keyCountry, address['country']!);
      await prefs.setString(_keyFullAddress, address['fullAddress']!);

      print('Location saved to storage');

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

  Future<Map<String, dynamic>?> getSavedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey(_keyLatitude) ||
          !prefs.containsKey(_keyLongitude)) {
        print('No saved location found');
        return null;
      }

      final latitude = prefs.getDouble(_keyLatitude);
      final longitude = prefs.getDouble(_keyLongitude);
      final city = prefs.getString(_keyCity);
      final state = prefs.getString(_keyState);
      final country = prefs.getString(_keyCountry);
      final fullAddress = prefs.getString(_keyFullAddress);

      if (latitude == null || longitude == null) return null;

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

  double calculateDistance(double startLat, double startLng,
      double endLat, double endLng) {
    try {
      double meters = Geolocator.distanceBetween(
          startLat, startLng, endLat, endLng);
      return meters / 1000;
    } catch (e) {
      return 0.0;
    }
  }

  String formatDistance(double distanceInKm) {
    if (distanceInKm < 1) {
      return '${(distanceInKm * 1000).round()} m';
    }
    return '${distanceInKm.toStringAsFixed(1)} km';
  }

  Future<bool> isLocationServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      return false;
    }
  }

  Future<void> openAppSettings() async {
    try {
      await Geolocator.openAppSettings();
    } catch (e) {
      print('Error opening app settings: $e');
    }
  }

  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openLocationSettings();
    } catch (e) {
      print('Error opening location settings: $e');
    }
  }
}