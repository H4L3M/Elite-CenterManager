import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:center_manager/ui/nav/add_participant.dart';
import 'package:center_manager/ui/nav/dashboard.dart';
import 'package:center_manager/ui/nav/participants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      selectedIndex: _selectedIndex,
      destinations: _destinations,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      // fabInRail: false,
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add_rounded),
      //   // child: const Text('Add New'),
      //   onPressed: () {
      //
      //   },
      // ),
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          select(),
        ],
      )
    );
  }

  Widget select() {
    switch (_selectedIndex) {
      case 0:
        // return const Dashboard();
        return const AddParticipant();
      case 1:
        return const Participants();
      case 2:
        return const AddParticipant();
      case 3:
        return const AddParticipant();
    }
    return Container(
      color: Colors.redAccent,
      child: const Text('Error'),
    );
  }
}

final _destinations = <AdaptiveScaffoldDestination>[
  const AdaptiveScaffoldDestination(
      title: 'Dashboard', icon: Icons.dashboard_outlined),
  const AdaptiveScaffoldDestination(
      title: 'Participants', icon: Icons.supervised_user_circle_outlined),
  const AdaptiveScaffoldDestination(
      title: 'Add New', icon: Icons.add_circle_rounded),
];
