import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/select_category_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget categoryListCard({
  required BuildContext context,
  required String navigateScreen
}) {
  final categoryProvider = Provider.of<KeywordListProvider>(context, listen: false);
  final widgetSize = MediaQuery.of(context).size;
  return SizedBox(
    height: 60,
    child: categoryProvider.categoryValue.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: widgetSize.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>  SelectCategoryType(navigateScreen: navigateScreen)));
                },
                child: const Text("Select Keywords For This Message"),
              ),
            ),
          )
        : ListView(
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
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>  SelectCategoryType(navigateScreen: navigateScreen)));
                  },
                  child: const Text("More"),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categoryValue.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        categoryProvider.categoryValue[index],
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
  );
}
