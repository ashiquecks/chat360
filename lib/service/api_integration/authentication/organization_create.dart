import 'dart:convert';
import 'dart:io';
import 'package:chat360/modal/organization_model.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import '../../server_response/server_response.dart';

Future<NetworkResponse<OrganizationModal>> createOrganization({
  required String userID,
  required String userName,
  required String phoneNumber,
  required String password,
  required String organizationName,
  required String gstNumber,
  required String buildingNumber,
  required ParseFile profilePick,
  required bool verifiedOrganization,
  required Object categoryTypes,
}) async {
  try {
    ParseObject response = ParseObject('OrganizationAccount')
      ..set('userName', userName)
      ..set('phoneNumber', phoneNumber)
      ..set('profilePick', profilePick)
      ..set('organizationName', organizationName)
      ..set('gstNumber', gstNumber)
      ..set('buildingNumber', buildingNumber)
      ..set('verifiedOrganization', false)
      ..set('categoryTypes', categoryTypes);
    await response.save();

    QueryBuilder queryPublisher = QueryBuilder(response);
    final userCreateResponse = await queryPublisher.query();

    if (userCreateResponse.success == true) {
      final jsonString = jsonDecode(response.toString());
      OrganizationModal responseData = OrganizationModal.fromJson(jsonString);

      return NetworkResponse(true, responseData,
          message: "success fully created");
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
          "Invalid response receded form the server! Please try again in a minutes or two",
    );
  } catch (e) {
    return NetworkResponse(false, null,
        message: 'something went wrong please try again in a minute or two');
  }
}
