import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: Column(
        children: [
          // Search Bar Space<==========>
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.location_on_outlined),
            title: const Text("Use current location"),
            subtitle: const Text("Palazhi, Kozhikode"),
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (context, index) {
              return const ListTile(title: Text("Kozhikode"));
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ],
      ),
    );
  }
}
