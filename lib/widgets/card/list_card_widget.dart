import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/main_provider.dart';
import '../../resourses/colors.dart';

Widget categoryListCard({
  required List<Map<String, dynamic>> categoryList,
  required BuildContext context,
}) {
  return SizedBox(
    height: 60,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'category_screen');
            },
            child: const Text("All"),
          ),
        ),
        ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Consumer<MainProvider>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      value.changeCategory(
                        categoryList[index]['title'].toString(),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: value.selectedCategory ==
                                categoryList[index]['title']
                            ? primaryColor
                            : white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          categoryList[index]['title'].toString(),
                          style: TextStyle(
                            color: value.selectedCategory ==
                                    categoryList[index]['title']
                                ? white
                                : primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ],
    ),
  );
}
