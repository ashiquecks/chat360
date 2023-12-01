import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/keyword_list_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<List<KeywordsModal>>> getKeywordList({
  required String searchKeyword,
  required String subCategory,
}) async {
  try {
    QueryBuilder<ParseObject> queryPublisher = QueryBuilder<ParseObject>(
      ParseObject('Keywords'),
    );
    queryPublisher.orderByDescending('createdAt');
    if (searchKeyword != "") {
      queryPublisher.whereContains('keywordName', searchKeyword);
    }
    if (subCategory != "") {
      queryPublisher.whereContains('subCategoryId', subCategory);
    }

    final ParseResponse apiResponse = await queryPublisher.query();

    if (apiResponse.success == true) {
      final convertJson = await jsonDecode(apiResponse.results.toString());
      List<KeywordsModal> dataList = [];
      convertJson.forEach((e) {
        KeywordsModal chatMessageResponse = KeywordsModal.fromJson(e);
        dataList.add(chatMessageResponse);
      });
      return NetworkResponse(true, dataList);
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
      message: "Invalid response received form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'something went wrong please try again in a minute or two');
  }
}
