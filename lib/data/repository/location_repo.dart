import 'package:project/data/model/location_point.dart';

abstract class LocationRepo {
  Future<void> save(LocationPoint point);

  Stream<List<LocationPoint>> watchAll();

  List<LocationPoint> getAll();
}
