import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/widgets/card/row_type_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCreator extends StatefulWidget {
  const ManageCreator({super.key});

  @override
  State<ManageCreator> createState() => _ManageCreatorState();
}

class _ManageCreatorState extends State<ManageCreator> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          profileStatusCard(context: context),
          ListView.separated(
            shrinkWrap: true,
            itemCount: mainProvider.categoryValue.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(mainProvider.categoryValue[index]),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              );
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
