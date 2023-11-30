import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/modal/message_list_modal.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/provider/sub_category_list_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:chat360/widgets/popup/dialog_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> showExitPopup() async {
    return await showDialog(context: context, builder: (context) => exitDialogBox(context: context)) ?? false;
  }

  @override
  void initState() {
    super.initState();
    getChatListResponse(context: context);
    getCategoryListResponse(context: context);
    getSubCategoryListResponse(context: context);
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context, listen: false);

    var subCategory = Provider.of<SubCategoryListProvider>(context, listen: false);
    var category = Provider.of<CategoryListProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          backgroundColor: primaryColor,
          title: SizedBox(
            width: 120,
            child: Image.asset("assets/images/chatsidelogo.png"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  getChatListResponse(context: context);
                  Navigator.pushNamed(context, 'profile_screen');
                  subCategory.setDrawerCategory(category.categoryList);
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    mainProvider.profileImage.toString(),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Consumer<HomePageProvider>(builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.messageList.length,
            itemBuilder: (context, index) {
              MessageListModal responsePost = value.getPostByIndex(index);
              return messageListCard(
                cardAction: () async {
                  mainProvider.setMessageId(responsePost.objectId);
                  getChatMessageResponse(
                    context: context,
                    messagedId: responsePost.objectId,
                    isFirst: false,
                  );
                },
                messageTitle: responsePost.chatTitle,
              );
            },
          );
        }),
        floatingActionButton: CircleAvatar(
          maxRadius: 30,
          backgroundColor: primaryColor,
          child: IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: white,
            ),
            onPressed: () async {
              Navigator.pushNamed(context, 'chat_room');
            },
          ),
        ),
      ),
    );
  }
}
