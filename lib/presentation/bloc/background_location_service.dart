import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:project/data/model/location_point.dart';
import 'package:project/data/repository/location_repo_impl.dart';

class BackgroundLocationService {
  static Timer? _timer;
  static LocationRepoImpl? repo;

  /// MUST be called once (main.dart / DI setup)
  static void init(LocationRepoImpl repository) {
    repo = repository;
  }

  static Future<void> start() async {
    if (repo == null) {
      throw Exception(
          "BackgroundLocationService not initialized. Call init() first.");
    }

    /// 1️⃣ Check & request permission
    final permission = await _ensurePermission();
    if (!permission) return;

    /// 2️⃣ SAVE LOCATION IMMEDIATELY
    await _captureAndSave();

    /// 3️⃣ Continue saving every 5 minutes
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(minutes: 5),
      (_) async {
        await _captureAndSave();
      },
    );
  }

  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// 🔹 Handles actual GPS + save
  static Future<void> _captureAndSave() async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      await repo!.save(
        LocationPoint(
          latitude: pos.latitude,
          longitude: pos.longitude,
          timestamp: DateTime.now(),
        ),
      );
    } catch (e) {
      // Optional: log error
      print("Location capture failed: $e");
    }
  }

  /// 🔹 Permission handling
  static Future<bool> _ensurePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
