import 'package:chat360/modal/chat_message_modal.dart';
import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/chat_room_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/provider/sub_category_list_provider.dart';
import 'package:chat360/resources/app_them.dart';
import 'package:chat360/resources/colors.dart';
import 'package:chat360/screens/category/category_drawer.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';

Widget textColumCard({
  required String textCount,
  required String textLabel,
}) {
  return Column(
    children: [
      Text(
        textCount,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(textLabel),
    ],
  );
}

Widget messageBoxIconCard({
  required MainProvider mainProvider,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 15, top: 5),
    child: Row(
      children: [
        Image.asset(
          'assets/images/more.png',
          width: 30,
        ),
        InkWell(
          onTap: () {
            mainProvider.setCreateReply();
          },
          child: Image.asset(
            'assets/images/reply.png',
            width: 35,
          ),
        ),
      ],
    ),
  );
}

Widget imageMessageBox({
  required ChatMessageModal response,
}) {
  return Container(
    decoration: decorationMessageBox,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Image.network(response.photoMessage.url),
        ),
        response.message != "" && response.message != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  response.message,
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}

Widget searchBoxCard({required TextEditingController searchController, required void Function() searchAction}) {
  return Expanded(
    child: Card(
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: "   Search Keyword",
            suffixIcon: IconButton(onPressed: searchAction, icon: const Icon(Icons.search)),
          ),
        ),
      ),
    ),
  );
}

Widget profileCircleButton({
  required BuildContext context,
  required void Function() buttonAction,
  required String profileImage,
}) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: InkWell(
      onTap: buttonAction,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          profileImage.toString(),
        ),
      ),
    ),
  );
}

categoryButtonCard({
  required BuildContext context,
}) {
  return Card(
    color: white,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        onPressed: () {
          SideSheet.left(
            body: const DrawerCategory(drawerType: 'select',),
            context: context,
          );
        },
        icon: const Icon(Icons.grid_view),
      ),
    ),
  );
}


