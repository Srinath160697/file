import 'dart:async';

import 'package:project/core/fake_data/fake_location_data.dart';
import 'package:project/data/repository/location_repo.dart';
import 'package:project/data/model/location_point.dart';

class LocationRepoImpl implements LocationRepo {
  final List<LocationPoint> _points = [];

  final _controller = StreamController<List<LocationPoint>>.broadcast();

  @override
  Future<void> save(LocationPoint point) async {
    _points.add(point);
    _controller.add(List.from(_points));
  }

  @override
  Stream<List<LocationPoint>> watchAll() {
    return _controller.stream;
  }

  @override
  List<LocationPoint> getAll() {
    return _points;
  }

  Future<void> loadFakeData() async {
    _points.clear();

    for (final item in fakeLocationsJson) {
      final lat = item["lat"] as double;
      final lng = item["lng"] as double;
      final time = item["time"] as String;

      _points.add(
        LocationPoint(
          latitude: lat,
          longitude: lng,
          timestamp: DateTime.parse(time),
        ),
      );
    }

    _controller.add(List.from(_points));
  }
}
