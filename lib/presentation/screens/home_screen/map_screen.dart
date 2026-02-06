import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/data/model/location_point.dart';
import 'package:project/presentation/bloc/location_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, List<LocationPoint>>(
        builder: (_, points) {
          if (points.isEmpty) {
            return const Center(
                child: Text(
              "No location data, load data first...",
              textAlign: TextAlign.center,
            ));
          }

          final latLngs =
              points.map((e) => LatLng(e.latitude, e.longitude)).toList();

          final markers = <Marker>{};

          for (int i = 0; i < latLngs.length; i++) {
            markers.add(
              Marker(
                markerId: MarkerId("point_$i"),
                position: latLngs[i],
                infoWindow: InfoWindow(
                  title: "Point ${i + 1}",
                  snippet: points[i].timestamp.toString(),
                ),
                icon: i == 0
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)
                    : i == latLngs.length - 1
                        ? BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueBlue)
                        : BitmapDescriptor.defaultMarker,
              ),
            );
          }
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: latLngs.first,
                  zoom: 15,
                ),
                markers: markers,
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: latLngs,
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                },
              ),

              /// BOTTOM PANEL (EXACT IMAGE STYLE)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.pinkAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Finish"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
