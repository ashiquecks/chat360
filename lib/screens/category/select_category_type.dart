import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/keyword_list_model.dart';
import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/category_drawer.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/card/mini_size_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

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
    getKeywordListResponse(context: context, searchKeyword: '', subCategory: '');
  }

  TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final keywordListProvider = Provider.of<KeywordListProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  searchBoxCard(
                    searchController: searchControl,
                    searchAction: () {
                      getKeywordListResponse(
                        context: context,
                        searchKeyword: searchControl.text,
                        subCategory: '',
                      );
                    },
                  ),
                  categoryButtonCard(context: context),
                ],
              ),
            )),
        body: Consumer<KeywordListProvider>(builder: (context, model, child) {
          return SingleChildScrollView(
            child: Wrap(
              children: List.generate(model.keywordList.length, (index) {
                KeywordsModal response = model.getPostByIndex(index);
                return InkWell(
                  onTap: () {
                    model.setCategoryList(response.keywordType, response.keywordName);
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
                      response.keywordName,
                      style: TextStyle(
                        color: model.categoryList[response.keywordType] == null ? primaryColor : white,
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
        floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: primaryColor,
          child: IconButton(
            onPressed: () {
              keywordListProvider.createCategoryValueList();
              Navigator.pushNamed(context, widget.navigateScreen);
            },
            icon: Icon(Icons.add, color: white),
          ),
        ),
      ),
    );
  }
}
