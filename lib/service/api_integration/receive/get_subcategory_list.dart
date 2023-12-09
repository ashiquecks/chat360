import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/category_model.dart';
import 'package:chat360/service/server_response/server_response.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<NetworkResponse<List<CategoryModel>>> getSubCategoryList() async {
  try {
    QueryBuilder<ParseObject> queryPublisher = QueryBuilder<ParseObject>(
      ParseObject('KeywordSubCategory'),
    );
    // queryPublisher.whereEqualTo('categoryId', categoryId);
    queryPublisher.orderByDescending('createdAt');
    final ParseResponse apiResponse = await queryPublisher.query();

    if (apiResponse.success == true) {
      final convertJson = await jsonDecode(apiResponse.results.toString());
      List<CategoryModel> chatMessageList = [];
      convertJson.forEach((e) {
        CategoryModel chatMessageResponse = CategoryModel.fromJson(e);
        chatMessageList.add(chatMessageResponse);
      });
      return NetworkResponse(true, chatMessageList);
    } else {
      return NetworkResponse(
        false,
        null,
        message: 'Invalid response received from server! please try again in a minutes or two',
      );
    }
  } on SocketException {
    return NetworkResponse(
      false,
      null,
      message: "Unable to reach the internet! Please try again in  a minutes or two",
    );
  } on FormatException {
    return NetworkResponse(
      false,
      null,
      message: "Invalid response receved form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'somthing went wrong please try again in a minute or two');
  }
}