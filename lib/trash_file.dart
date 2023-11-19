

// loginButton(
//               context: context,
//               buttonText: mainProvider.isCreator != true ? "Make a Creator Account" : "Manage Creator Account",
//               buttonAction: () {
//                 if (mainProvider.isCreator != true) {
//                   showModalBottomSheet(
//                     enableDrag: true,
//                     useSafeArea: true,
//                     context: context,
//                     builder: (BuildContext context) {
//                       return const UserLaunch();
//                     },
//                   );
//                 } else {
//                   Navigator.pushNamed(context, 'manage_creator');
//                 }
//               },
//             ),