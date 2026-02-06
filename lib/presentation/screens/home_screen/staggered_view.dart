import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ActivityData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;

  ActivityData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
  });
}

class Staggered extends StatefulWidget {
  const Staggered({super.key});

  @override
  State<Staggered> createState() => _StaggeredState();
}

class _StaggeredState extends State<Staggered> {
  final List<ActivityData> demoActivities = [
    ActivityData(
      title: "Activities",
      subtitle: "12 this week",
      icon: Icons.directions_run,
      backgroundColor: Colors.blueAccent,
    ),
    ActivityData(
      title: "Distance",
      subtitle: "18.5 km",
      icon: Icons.map,
      backgroundColor: Colors.deepPurple,
    ),
    ActivityData(
      title: "Calories",
      subtitle: "2,450 kcal",
      icon: Icons.local_fire_department,
      backgroundColor: Colors.deepOrangeAccent,
    ),
    ActivityData(
      title: "Weekly Goal",
      subtitle: "75% completed",
      icon: Icons.flag,
      backgroundColor: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: demoActivities.length,
      itemBuilder: (context, index) {
        final data = demoActivities[index];
        final isEven = index % 2 == 0;
        final height = isEven ? 160.0 : 130.0;

        return ActivityCard(
          data: data,
          height: height,
        );
      },
    );
  }
}

class ActivityCard extends StatelessWidget {
  final ActivityData data;
  final double height;

  const ActivityCard({
    super.key,
    required this.data,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: data.backgroundColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: data.backgroundColor.withOpacity(1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: data.backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              data.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            data.subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
