import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/keyword_list_model.dart';
import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/category_drawer.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    getKeywordListResponse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "   Search Keyword",
                            suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          SideSheet.left(
                            body: const DrawerCategory(),
                            context: context,
                          );
                        },
                        icon: const Icon(Icons.grid_view),
                      ),
                    ),
                  )
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
              if (mainProvider.accountType == "UserAccount") {
                createUserAccountResponse(context: context, isCreator: true);
              } else {
                createOrganizationAccountResponse(context: context);
              }
            },
            icon: Icon(Icons.add, color: white),
          ),
        ),
      ),
    );
  }
}
