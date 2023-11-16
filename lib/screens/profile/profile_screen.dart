import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resources/colors.dart';
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
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'edit_profile');
            },
            icon: const Icon(
              Icons.edit,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profileImageCard(
              context: context,
            ),
            profileStatusCard(context: context),
            profileDetailsCardUser(
              context: context,
              userName: mainProvider.userName.toString(),
              userPhoneNumber: mainProvider.userPhone.toString(),
              organizationName: mainProvider.organizationName.toString(),
              gstNumber: mainProvider.gstNumber.toString(),
              buildingNumber: mainProvider.buildingNumber.toString(),
            ),
            loginButton(
              context: context,
              buttonText: mainProvider.isCreator != true ? "Make a Creator Account" : "Manage Creator Account",
              buttonAction: () {
                if (mainProvider.isCreator != true) {
                  showModalBottomSheet(
                    enableDrag: true,
                    useSafeArea: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const UserLaunch();
                    },
                  );
                }else{
                  // Manage Creator Account
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
