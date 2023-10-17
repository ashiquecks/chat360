import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/resourses/colors.dart';
import 'package:chat360/screens/authentication/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../widgets/button/button_widget.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            height: widgetSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: widgetSize.width / 2,
                  child: Image.asset('assets/images/logo_white.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: IntlPhoneField(
                    controller: mainProvider.userPhone,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      mainProvider.setUserPhone(phone.completeNumber);
                    },
                  ),
                ),
                loginButton(
                  context: context,
                  buttonText: "SEND OTP",
                  buttonAction: () => showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return OTPVerification();
                      }),
                ),
                const Text("we will send you one time password"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
