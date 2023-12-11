import 'package:chat360/resources/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../provider/main_provider.dart';
import '../../widgets/button/button_widget.dart';
import '../../widgets/text/text_widgets.dart';

class OTPVerification extends StatefulWidget {
  final String phoneNumber;
  const OTPVerification({super.key, required this.phoneNumber});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // verifyphoneNumber();
  }

  var _verificationId = "";

  final pinController = TextEditingController();

  // Future<void> _verifyPhoneNumber() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: widget.phoneNumber,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       // Handle error
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       setState(() {
  //         _verificationId = verificationId;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       setState(() {
  //         _verificationId = verificationId;
  //       });
  //     },
  //   );
  // }

  UserCredential? responseCredential;

  verifyphoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        final response =
            await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          responseCredential = response;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 3),
        ));
      },
      codeSent: (String vID, int? resendToken) {
        setState(() {
          _verificationId = vID;
        });
      },
      codeAutoRetrievalTimeout: (String vID) {
        setState(() {
          _verificationId = vID;
        });
      },
      timeout: const Duration(seconds: 60),
    );
  }

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
              controller: pinController,
              focusNode: _pinOTPCodeFocus,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              // onCompleted: (pin) async {
              //   try {
              //     await FirebaseAuth.instance
              //         .signInWithCredential(PhoneAuthProvider.credential(
              //             verificationId: _verificationId, smsCode: pin))
              //         .then((value) async {
              //       if (value.user != null) {
              //         Navigator.pushNamed(context, 'user_account');
              //         mainProvider.setFirebaseCredential(
              //           responseCredential!.user!.uid,
              //           _verificationId,
              //         );
              //       }
              //     });
              //   } catch (e) {
              //     FocusScope.of(context).unfocus();
              //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //       content: Text("Invalid OTP"),
              //       duration: Duration(seconds: 3),
              //     ));
              //   }
              // },
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
