import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget profileDetailsCardUser({
  required BuildContext context,
  required String userName,
  required String userPhoneNumber,
  required String organizationName,
  required String gstNumber,
  required String buildingNumber,
}) {
  final widgetSize = MediaQuery.of(context).size;
  final mainProvider = Provider.of<MainProvider>(context, listen: false);
  final isOrganization = mainProvider.accountType == "OrganizationAccount";
  Widget divider = const Divider();
  return Container(
    width: widgetSize.width,
    margin: const EdgeInsets.all(15),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(boxShadow: const [
      BoxShadow(spreadRadius: 6, blurRadius: 6, color: Color.fromARGB(255, 214, 214, 214)),
    ], color: white, borderRadius: BorderRadius.circular(15)),
    child: isOrganization
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text(organizationName),
                trailing: Icon(
                  Icons.verified,
                  color: c1,
                ),
              ),
              divider,
              ListTile(title: Text(userPhoneNumber)),
              divider,
              ListTile(title: Text(gstNumber)),
              divider,
              ListTile(title: Text(buildingNumber)),
            ],
          )
        : Column(
            children: [
              ListTile(title: Text(userName)),
              divider,
              ListTile(title: Text(userPhoneNumber)),
            ],
          ),
  );
}
