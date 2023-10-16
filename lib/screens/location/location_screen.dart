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
          const ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text("Use current location"),
            subtitle: Text("Palazhi, Kozhikode"),
          ),
          // Recent Selected Location <==========>
          ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return ListTile(
                title: const Text("Kerala"),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
