import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/category_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<CategoryModel>>> getCategoryList() async {
  try {
    QueryBuilder<ParseObject> queryPublisher = QueryBuilder<ParseObject>(
      ParseObject('KeywordCategory'),
    );
    queryPublisher.orderByDescending('createdAt');
    final ParseResponse apiResponse = await queryPublisher.query();

    if (apiResponse.success == true) {
      final convertJson = await jsonDecode(apiResponse.results.toString());
      List<CategoryModel> dataList = [];
      convertJson.forEach((e) {
        CategoryModel chatMessageResponse = CategoryModel.fromJson(e);
        dataList.add(chatMessageResponse);
      });
      return NetworkResponse(true, dataList);
    } else {
      return NetworkResponse(
        false,
        null,
        message:
            'Invalid response received from server! please try again in a minutes or two',
      );
    }
  } on SocketException {
    return NetworkResponse(
      false,
      null,
      message:
          "Unable to reach the internet! Please try again in  a minutes or two",
    );
  } on FormatException {
    return NetworkResponse(
      false,
      null,
      message:
          "Invalid response received form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'something went wrong please try again in a minute or two');
  }
}
