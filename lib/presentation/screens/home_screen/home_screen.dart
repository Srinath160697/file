import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/constant/Color/colors.dart';
import 'package:project/data/firebase_service/services.dart';
import 'package:project/data/model/location_point.dart';
import 'package:project/presentation/bloc/location_bloc.dart';
import 'package:project/presentation/screens/authentication/logo_screen.dart';
import 'package:project/presentation/screens/home_screen/map_screen.dart';
import 'package:project/presentation/screens/home_screen/staggered_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService authService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationBloc>();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300, // outer “border” color
                  ),
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.only(right: 10),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                const Text('ABCD Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    )),
              ],
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(Icons.notification_add, color: Colors.black),
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                  ),
                  child: Text(
                    'GuardianRoute App',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share App'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_support),
                  title: const Text('Contact Us'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.rule),
                  title: const Text('Terms & Services'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help Improve the App'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    await authService.logout();
                    if (context.mounted) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LogoScreen()));
                    }
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Location Tracking",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: bloc.startTracking,
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.pinkAccent,
                                    width: 1.5,
                                  ),
                                ),
                                child: const Text(
                                  "Start",
                                  style: TextStyle(
                                    color: Colors.pinkAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: bloc.stopTracking,
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  backgroundColor: Colors.pinkAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text("Stop"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  "Best highlights",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Staggered(),
                ),
                const Text(
                  "Today",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: BlocBuilder<LocationBloc, List<LocationPoint>>(
                    builder: (_, points) {
                      if (points.isEmpty) {
                        return const Center(child: Text("No location data"));
                      }

                      final last10 = points.reversed.take(10).toList();

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        itemCount: last10.length,
                        itemBuilder: (_, i) {
                          final p = last10[i];

                          return _HistoryTile(point: p);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "leftFab",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MapScreen()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/map.png',
                    width: 26,
                    height: 26,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                  heroTag: "rightFab",
                  backgroundColor: Colors.pinkAccent,
                  onPressed: bloc.loadFakePoints,
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final LocationPoint point;

  const _HistoryTile({required this.point});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.location_on, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  point.timestamp.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.navigation,
              color: Colors.orangeAccent,
            ),
            onPressed: () async {
              final url =
                  "https://www.google.com/maps/dir/?api=1&destination=${point.latitude},${point.longitude}";
              await launchUrl(Uri.parse(url));
            },
          ),
        ],
      ),
    );
  }
}
