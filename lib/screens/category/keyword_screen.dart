import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/keyword_list_model.dart';
import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/category_drawer.dart';
import 'package:chat360/screens/filter_chat/filter_chat.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/card/mini_size_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:side_sheet/side_sheet.dart';

class KeywordScreen extends StatefulWidget {
  const KeywordScreen({
    super.key,
  });

  @override
  State<KeywordScreen> createState() => _KeywordScreenState();
}

class _KeywordScreenState extends State<KeywordScreen> {
  @override
  void initState() {
    super.initState();
    getKeywordListResponse(context: context, searchKeyword: '', subCategory: '');
  }

  TextEditingController searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: primaryColor,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create_keyword');
                },
                icon: Icon(Icons.add, color: white),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 30,
              backgroundColor: primaryColor,
              child: IconButton(
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    text: "Your Account has a Creator Type",
                    confirmBtnColor: Colors.black,
                    type: QuickAlertType.confirm,
                    confirmBtnText: "Confirm",
                    onConfirmBtnTap: () {
                      // Navigator.pushNamed(context, 'filter_screen');
                      if (mainProvider.accountType == "UserAccount") {
                        createUserAccountResponse(context: context, isCreator: true);
                      } else {
                        createOrganizationAccountResponse(context: context);
                      }
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.pop(context);
                      });
                    },
                  );
                },
                icon: Icon(Icons.arrow_forward_ios, color: white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
