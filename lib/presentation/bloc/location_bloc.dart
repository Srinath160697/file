import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/data/repository/location_repo.dart';
import 'package:project/data/repository/location_repo_impl.dart';
import 'package:project/data/model/location_point.dart';
import 'package:project/presentation/bloc/background_location_service.dart';

class LocationBloc extends Cubit<List<LocationPoint>> {
  final LocationRepo repo;

  LocationBloc(this.repo) : super([]) {
    repo.watchAll().listen(emit);
  }

  void startTracking() {
    BackgroundLocationService.start();
  }

  void stopTracking() {
    BackgroundLocationService.stop();
  }

  Future<void> loadFakePoints() async {
    if (repo is LocationRepoImpl) {
      await (repo as LocationRepoImpl).loadFakeData();
    }
  }
}
