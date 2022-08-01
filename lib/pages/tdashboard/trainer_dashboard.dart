import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:swim_app/pages/tdashboard/views/about_trainer.dart';
import 'package:swim_app/pages/tdashboard/views/appoiment.dart';
import 'package:swim_app/pages/tdashboard/views/time_setup.dart';
import 'package:swim_app/pages/tdashboard/views/trainer_main.dart';

class TrainerDashboard extends StatefulWidget {
  const TrainerDashboard({Key? key}) : super(key: key);

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  String title = "Trainer Dashboard";
  int index = 0;
  final screens = [
    const TrainerMainPage(),
    const Appoiment(),
    const TimeSlotSetup(),
    const AboutTrainer()
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.all_inbox, size: 30),
      const Icon(Icons.timeline_rounded, size: 30),
      const Icon(Icons.person, size: 30),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(title),
        centerTitle: true,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          color: Colors.lightBlueAccent,
          backgroundColor: Colors.transparent,
          height: 60,
          index: index,
          items: items,
          onTap: (index) => setState(() {
            this.index = index;
            if (index == 0) {
              title = "Trainer Dashboard";
            } else if (index == 1) {
              title = "Appointments";
            } else if (index == 2) {
              title = "Time Setup";
            } else if (index == 3) {
              title = "Trainer Profile";
            }
          }),
        ),
      ),
      body: screens[index],
    );
  }
}
