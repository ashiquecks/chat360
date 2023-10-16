import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}
// This page very impotent this selected who is creator

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, 'creator_approval');
                  },
                  title: const Text("Category one"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
                const Divider()
              ],
            );
          }),
    );
  }
}
