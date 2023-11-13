import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/category_list_model.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/resourses/colors.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final String accountType;
  const CategoryScreen({super.key, required this.accountType});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    getCategoryListResponse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: Consumer<CategoryListProvider>(builder: (context, model, child) {
        return Stack(
          children: [
            Wrap(
              children: List.generate(model.messageList.length, (index) {
                CategoryListModal response = model.getPostByIndex(index);
                return InkWell(
                  onTap: () {
                    model.setCategoryList(
                        response.categoryType, response.categoryName);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: model.categoryList[response.categoryType] == null
                          ? white
                          : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      response.categoryName,
                      style: TextStyle(
                        color: model.categoryList[response.categoryType] == null
                            ? primaryColor
                            : white,
                      ),
                    ),
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: loginButton(
                context: context,
                buttonText: "SUBMIT",
                buttonAction: () {
                  if (widget.accountType == "User") {
                    createUserAccountResponse(context: context);
                  } else {
                    createOrganizationAccountResponse(context: context);
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

class SelectCategoryType extends StatefulWidget {
  const SelectCategoryType({super.key});

  @override
  State<SelectCategoryType> createState() => _SelectMessageCategoryState();
}

class _SelectMessageCategoryState extends State<SelectCategoryType> {
  @override
  void initState() {
    super.initState();
    getCategoryListResponse(context: context);
  }

  List<Map<String, dynamic>> categoryItems = [];

  final categoryBox = Hive.box('categoryType');

  void getCategory() {
    final data = categoryBox.keys.map((key) {
      final item = categoryBox.get(key);
      return {"category": item['category'], "categoryId": item['categoryId']};
    }).toList();
    setState(() {
      categoryItems = data.reversed.toList();
      print(categoryItems);
    });
  }

  Future<void> createCategoryList(
      {required Map<String, dynamic> categoryTypes}) async {
    await categoryBox.add(categoryTypes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Consumer<CategoryListProvider>(builder: (context, model, child) {
        return Stack(
          children: [
            Wrap(
              children: List.generate(model.messageList.length, (index) {
                CategoryListModal response = model.getPostByIndex(index);
                return InkWell(
                  onTap: () {
                    model.setCategoryList(
                        response.categoryType, response.categoryName);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: model.categoryList[response.categoryType] == null
                          ? white
                          : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      response.categoryName,
                      style: TextStyle(
                        color: model.categoryList[response.categoryType] == null
                            ? primaryColor
                            : white,
                      ),
                    ),
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: loginButton(
                context: context,
                buttonText: "CONFIRM",
                buttonAction: () {
                  model.categoryList.forEach((key, value) {
                    createCategoryList(categoryTypes: {
                      'category': value,
                      'categoryId': value,
                    });
                  });
                  getCategory();
                  Navigator.pushNamed(context, 'chat_room');
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
