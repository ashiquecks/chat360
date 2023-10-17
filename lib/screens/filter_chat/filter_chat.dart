import 'package:flutter/material.dart';

class FilterChatScreen extends StatefulWidget {
  const FilterChatScreen({super.key});

  @override
  State<FilterChatScreen> createState() => _FilterChatScreenState();
}

class _FilterChatScreenState extends State<FilterChatScreen> {
  TextEditingController textLink = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Message"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ListTile(
                leading: Icon(Icons.location_on_outlined),
                title: Text("Use current location"),
                subtitle: Text("Palazhi, Kozhikode"),
              ),
              TextField(
                textAlign: TextAlign.start,
                controller: textLink,
                minLines: 6,
                maxLines: 120,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  label: Text("Link"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.start,
                controller: textLink,
                minLines: 6,
                maxLines: 120,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  label: Text("Message"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Send Link With Message"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
