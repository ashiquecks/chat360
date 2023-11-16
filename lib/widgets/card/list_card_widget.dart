import 'package:chat360/provider/category_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/main_provider.dart';
import '../../resources/colors.dart';

Widget categoryListCard({
  required List<Map<String, dynamic>> categoryList,
  required BuildContext context,
}) {
  final categoryProvider =
      Provider.of<CategoryListProvider>(context, listen: false);
  final widgetSize = MediaQuery.of(context).size;
  return SizedBox(
    height: 60,
    child: categoryProvider.categoryList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: widgetSize.width,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'category_types');
                },
                child: const Text("Select Keywords For This Message"),
              ),
            ),
          )
        : ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'category_types');
                  },
                  child: const Text("More"),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProvider.categoryLabel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        categoryProvider.categoryLabel[index].toString(),
                        style: const TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
  );
}

// Widget categoryListCard({
//   required List<Map<String, dynamic>> categoryList,
//   required BuildContext context,
// }) {
//   final categoryProvider =
//       Provider.of<CategoryListProvider>(context, listen: false);
//   final widgetSize = MediaQuery.of(context).size;
//   return SizedBox(
//     height: 60,
//     child: categoryProvider.categoryList.isEmpty
//         ? Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: widgetSize.width,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, 'category_types');
//                 },
//                 child: const Text("Select Keywords For This Message"),
//               ),
//             ),
//           )
//         : ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: categoryProvider.categoryLabel.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Text(
//                     categoryProvider.categoryLabel[index].toString(),
//                     style: const TextStyle(
//                       color: primaryColor,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//   );
// }



//  child: Container(
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: value.selectedCategory ==
//                                     categoryList[index]['title']
//                                 ? primaryColor
//                                 : white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Text(
//                               categoryList[index]['title'].toString(),
//                               style: TextStyle(
//                                 color: value.selectedCategory ==
//                                         categoryList[index]['title']
//                                     ? white
//                                     : primaryColor,
//                               ),
//                             ),
//                           ),
//                         ),