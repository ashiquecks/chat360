import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/keyword_list_model.dart';
import 'package:chat360/service/server_response/server_response.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<NetworkResponse<KeywordsModal>> createKeywords({
  required String keywordName,
  required String categoryName,
  required String categoryId,
  required String keywordType,
  required String subCategory,
  required String subCategoryId,
  required BuildContext context,
}) async {
  try {
    ParseObject response = ParseObject("Keywords")
    ..set('keywordName', keywordName)
    ..set('keywordType',keywordType)
    ..set('categoryId', categoryId)
    ..set('categoryName', categoryName)
    ..set('subCategory', subCategory)
    ..set('subCategoryId', subCategoryId);
    await response.save();

    QueryBuilder queryPublisher = QueryBuilder(response);
    ParseResponse userCreateResponse = await queryPublisher.query();

    if (userCreateResponse.success == true) {
      final jsonString = jsonDecode(jsonEncode(response));

      KeywordsModal responseData = KeywordsModal.fromJson(jsonString);

      return NetworkResponse(true, responseData, message: "success fully created");
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
      message: "Invalid response receded form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null, message: 'something went wrong please try again in a minute or two');
  }
}
