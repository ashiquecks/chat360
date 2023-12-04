import 'dart:async';
import 'package:chat360/api_functions/get_function.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/provider/sub_category_list_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:chat360/widgets/card/mini_size_card.dart';
import 'package:chat360/widgets/popup/dialog_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreenLive extends StatefulWidget {
  const HomeScreenLive({Key? key}) : super(key: key);

  @override
  _HomeScreenLiveState createState() => _HomeScreenLiveState();
}

class _HomeScreenLiveState extends State<HomeScreenLive> {
  Future<bool> showExitPopup() async {
    return await showDialog(context: context, builder: (context) => exitDialogBox(context: context)) ?? false;
  }

  List<ParseObject> taskList = [];

  StreamController<List<ParseObject>> streamController = StreamController();

  final LiveQuery liveQuery = LiveQuery(debug: true);
  late Subscription<ParseObject> subscription;

  final QueryBuilder<ParseObject> queryTodo = QueryBuilder<ParseObject>(ParseObject('ChatList'));

  @override
  void initState() {
    super.initState();
    getCategoryListResponse(context: context);
    getSubCategoryListResponse(context: context);
    getTodoList();
    startLiveQuery();
  }

  void startLiveQuery() async {
    subscription = await liveQuery.client.subscribe(queryTodo);
    subscription.on(LiveQueryEvent.create, (value) {
      taskList.add(value);
      streamController.add(taskList);
    });
  }

  void cancelLiveQuery() async {
    liveQuery.client.unSubscribe(subscription);
  }

  void getTodoList() async {
    final ParseResponse apiResponse = await queryTodo.query();

    if (apiResponse.success && apiResponse.results != null) {
      taskList.addAll(apiResponse.results as List<ParseObject>);
      streamController.add(apiResponse.results as List<ParseObject>);
    } else {
      taskList.clear();
      streamController.add([]);
    }
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
            profileCircleButton(
              context: context,
              buttonAction: () {
                Navigator.pushNamed(context, 'profile_screen');
                subCategory.setDrawerCategory(category.categoryList);
              },
              profileImage: mainProvider.profileImage.toString(),
            ),
          ],
        ),
        body: Consumer(
          builder: (BuildContext context, value, Widget? child) {
            return StreamBuilder<List<ParseObject>>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(
                      child: SizedBox(width: 100, height: 100, child: CircularProgressIndicator()),
                    );
                  default:
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error..."),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("No Data..."),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10.0),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final messageList = snapshot.data![index];
                          final title = messageList.get<String>('chatTitle')!;
                          final objectId = messageList.get<String>('objectId')!;
                          return messageListCard(
                            cardAction: () async {
                              mainProvider.setMessageId(objectId);
                              getChatMessageResponse(
                                context: context,
                                messagedId: objectId,
                                isFirst: false,
                              );
                            },
                            messageTitle: title,
                          );
                        },
                      );
                    }
                }
              },
            );
          },
        ),
        floatingActionButton: CircleAvatar(
          maxRadius: 30,
          backgroundColor: primaryColor,
          child: IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: white,
            ),
            onPressed: () async {
              subCategory.setDrawerCategory(category.categoryList);
              Navigator.pushNamed(context, 'chat_room');
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    cancelLiveQuery();
    streamController.close();
    super.dispose();
  }
}
