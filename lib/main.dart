import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/screens/authentication/creator_account.dart';
import 'package:chat360/screens/authentication/creator_approval.dart';
import 'package:chat360/screens/authentication/otp_verification.dart';
import 'package:chat360/screens/authentication/phone_verification.dart';
import 'package:chat360/screens/authentication/user_account.dart';
import 'package:chat360/screens/category/category_screen.dart';
import 'package:chat360/screens/location/location_screen.dart';
import 'package:chat360/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'provider/chat_room_provider.dart';
import 'screens/authentication/user_launch.dart';
import 'screens/chat_room/chat_rooms.dart';
import 'screens/filter_chat/filter_chat.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  await Parse().initialize(
    "pYLM3p7I3jiAocohGfLQMvWgx486muD1QtvD9mxk",
    "https://parseapi.back4app.com",
    clientKey: "PLnQc8VAHS4mXEC9PkmuopSco2dchkmtD6tse1C4",
    debug: true,
    liveQueryUrl: "https://chat360.b4a.io",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatRoomProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        initialRoute: 'splash_screen',
        routes: {
          'splash_screen': (context) => const SplashScreen(),
          'home_screen': (context) => const HomeScreen(),
          'filter_chat': (context) => const FilterChatScreen(),
          'chat_room': (context) => const ChatRooms(),
          'location_screen': (context) => const LocationScreen(),
          'filter_screen': (context) => const FilterChatScreen(),
          'phone_verification': (context) => const PhoneVerification(),
          'otp_verification': (context) => const OTPVerification(),
          'category_screen': (context) => const CategoryScreen(),
          'profile_screen': (context) => const ProfileScreen(),
          'user_launch': (context) => const UserLaunch(),
          'creator_account': (context) => const CreatorAccount(),
          'user_account': (context) => const UserAccount(),
          'creator_approval': (context) => const CreatorApproval(),
        },
      ),
    );
  }
}
