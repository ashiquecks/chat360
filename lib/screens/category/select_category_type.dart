import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/keyword_list_model.dart';
import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCategoryType extends StatefulWidget {
  final String navigateScreen;
  const SelectCategoryType({super.key, required this.navigateScreen});

  @override
  State<SelectCategoryType> createState() => _SelectMessageCategoryState();
}

class _SelectMessageCategoryState extends State<SelectCategoryType> {
  @override
  void initState() {
    super.initState();
    getKeywordListResponse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Consumer<KeywordListProvider>(builder: (context, model, child) {
        return Stack(
          children: [
            Wrap(
              children: List.generate(model.keywordList.length, (index) {
                KeywordsModal response = model.getPostByIndex(index);
                return InkWell(
                  onTap: () {
                    model.setCategoryList(response.keywordType, response.categoryName);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: model.categoryList[response.keywordType] == null ? white : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      response.categoryName,
                      style: TextStyle(
                        color: model.categoryList[response.keywordType] == null ? primaryColor : white,
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
                  model.createCategoryValueList();
                  Navigator.pushNamed(context, widget.navigateScreen);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
