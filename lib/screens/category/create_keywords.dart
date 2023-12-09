import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/category_drawer.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class CreateKeyword extends StatefulWidget {
  const CreateKeyword({super.key});

  @override
  State<CreateKeyword> createState() => _CreateKeywordState();
}

class _CreateKeywordState extends State<CreateKeyword> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryListProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async{
        getKeywordListResponse(context: context, searchKeyword: '', subCategory: '');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              onPressed: () async {
                SideSheet.left(
                    body: const DrawerCategory(
                      drawerType: 'creator',
                    ),
                    context: context);
              },
              icon: const Icon(Icons.grid_on),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                enabled: false,
                controller: categoryProvider.selectedCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Category",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                enabled: false,
                controller: categoryProvider.selectedSubCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Sub Category",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: categoryProvider.newKeyword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Keywords",
                ),
              ),
            ),
            loginButton(
              context: context,
              buttonText: "SUBMIT",
              buttonAction: () async {
                createKeywordResponse(context: context);
              },
            )
          ],
        ),
      ),
    );
  }
}
