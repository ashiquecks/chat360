import 'package:chat360/api_functions/create_function.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChatScreen extends StatefulWidget {
  const FilterChatScreen({super.key});

  @override
  State<FilterChatScreen> createState() => _FilterChatScreenState();
}

class _FilterChatScreenState extends State<FilterChatScreen> {
  TextEditingController textLink = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: Colors.green,
                ),
                title: Text("Use current location"),
                subtitle: Text("Palazhi, Kozhikode"),
              ),
              const SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.start,
                controller: textLink,
                minLines: 6,
                maxLines: 120,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  label: Text("Message"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (mainProvider.accountType == "UserAccount") {
                      createUserAccountResponse(context: context, isCreator: true);
                    } else {
                      createOrganizationAccountResponse(context: context);
                    }
                  },
                  child: const Text("Send Link With Message"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class FilterChatScreen extends StatefulWidget {
//   const FilterChatScreen({super.key});

//   @override
//   State<FilterChatScreen> createState() => _FilterChatScreenState();
// }

// class _FilterChatScreenState extends State<FilterChatScreen> {
//   TextEditingController textLink = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final mainProvider = Provider.of<MainProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Message"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const ListTile(
//                 leading: Icon(Icons.location_on_outlined),
//                 title: Text("Use current location"),
//                 subtitle: Text("Palazhi, Kozhikode"),
//               ),
//               TextField(
//                 textAlign: TextAlign.start,
//                 controller: textLink,
//                 minLines: 6,
//                 maxLines: 120,
//                 decoration: const InputDecoration(
//                   alignLabelWithHint: true,
//                   label: Text("Link"),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 textAlign: TextAlign.start,
//                 controller: textLink,
//                 minLines: 6,
//                 maxLines: 120,
//                 decoration: const InputDecoration(
//                   alignLabelWithHint: true,
//                   label: Text("Message"),
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (mainProvider.accountType == "UserAccount") {
//                       createUserAccountResponse(context: context, isCreator: true);
//                     } else {
//                       createOrganizationAccountResponse(context: context);
//                     }
//                   },
//                   child: const Text("Send Link With Message"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
