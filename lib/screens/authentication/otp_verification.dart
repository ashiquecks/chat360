import 'package:chat360/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../provider/main_provider.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/text/text_widgets.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {



  // final pinController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: primaryColor),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final widgetSize = MediaQuery.of(context).size;
    return SizedBox(
      width: widgetSize.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          boldText(labelText: "We have send OTP on Your number"),
          SizedBox(
            width: widgetSize.width / 1.2,
            child: Pinput(
              length: 6,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              controller: mainProvider.passwordController,
              focusNode: _pinOTPCodeFocus,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
            ),
          ),
          SizedBox(
            width: widgetSize.width / 1.5,
            child: verifyButton(
              context: context,
              buttonText: "VERIFY OTP",
              buttonAction: () => Navigator.pushNamed(context, 'user_account'),
            ),
          ),
          normalRichText(
            textOne: "Didn't receive an OTP? ",
            textTwo: "Recent OTP",
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
