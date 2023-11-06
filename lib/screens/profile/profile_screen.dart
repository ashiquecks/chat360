import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resourses/colors.dart';
import 'package:chat360/screens/authentication/creator_account.dart';
import 'package:chat360/screens/authentication/user_launch.dart';
import 'package:chat360/widgets/button/button_widget.dart';
import 'package:chat360/widgets/card/card_widget.dart';
import 'package:chat360/widgets/card/colum_type_card.dart';
import 'package:chat360/widgets/card/row_type_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          profileImageCard(
            profileImage: mainProvider.userProfilePick.toString(),
            context: context,
          ),
          profileStatusCard(context: context),
          profileDetailsCard(
            context: context,
            userName: mainProvider.userName.toString(),
            userPhoneNumber: mainProvider.userPhone.toString(),
          ),
          loginButton(
            context: context,
            buttonText: "Make a Creator Account",
            buttonAction: () => showModalBottomSheet(
              enableDrag: true,
              useSafeArea: true,
              context: context,
              builder: (BuildContext context) {
                return const UserLaunch();
              },
            ),
          ),
        ],
      ),
    );
  }
}
