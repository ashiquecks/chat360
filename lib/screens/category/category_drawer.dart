import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/category_model.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/sub_category_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerCategory extends StatefulWidget {
  final String drawerType;
  const DrawerCategory({super.key, required this.drawerType});

  @override
  State<DrawerCategory> createState() => _DrawerCategoryState();
}

class _DrawerCategoryState extends State<DrawerCategory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryListProvider>(
      builder: (context, categoryValue, child) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: categoryValue.categoryList.length,
          itemBuilder: (context, index) {
            CategoryModel categoryResponse = categoryValue.getPostByIndex(index);
            return Consumer<SubCategoryListProvider>(
              builder: (context, subCategoryValue, child) {
                return ExpansionTile(
                  title: Text(categoryResponse.categoryName),
                  children: [
                    if (subCategoryValue.drawerList.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: subCategoryValue.drawerList[categoryResponse.objectId].length,
                        itemBuilder: (context, index) {
                          var response = subCategoryValue.drawerList[categoryResponse.objectId]?[index];
                          return ListTile(
                            onTap: () {
                              if (widget.drawerType == "select") {
                                getKeywordListResponse(
                                  context: context,
                                  searchKeyword: '',
                                  subCategory: response.objectId,
                                );
                                Navigator.pop(context);
                              } else {
                                categoryValue.setSubCategoryElements(response);
                                Navigator.pop(context);

                              }
                            },
                            title: Text(response.subCategory ?? "No name"),
                          );
                        },
                      )
                    else
                      const CircularProgressIndicator(),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
