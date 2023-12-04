import 'package:chat360/provider/category_list_provider.dart';
import 'package:chat360/provider/keyword_list_provider.dart';
import 'package:chat360/provider/home_page_provider.dart';
import 'package:chat360/provider/main_provider.dart';
import 'package:chat360/provider/sub_category_list_provider.dart';
import 'package:chat360/screens/authentication/organization_account.dart';
import 'package:chat360/screens/authentication/creator_approval.dart';
import 'package:chat360/screens/authentication/otp_verification.dart';
import 'package:chat360/screens/authentication/phone_verification.dart';
import 'package:chat360/screens/authentication/user_account.dart';
import 'package:chat360/screens/category/keyword_screen.dart';
import 'package:chat360/screens/category/select_category_type.dart';
import 'package:chat360/screens/chat_room/image_chat.dart';
import 'package:chat360/screens/home/home_screen_live.dart';
import 'package:chat360/screens/location/location_screen.dart';
import 'package:chat360/screens/manage_creator/manage_creator.dart';
import 'package:chat360/screens/profile/edit_profile.dart';
import 'package:chat360/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'provider/chat_room_provider.dart';
import 'screens/authentication/user_launch.dart';
import 'screens/chat_room/chat_rooms.dart';
import 'screens/chat_room/chat_screen.dart';
import 'screens/filter_chat/filter_chat.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = 'pYLM3p7I3jiAocohGfLQMvWgx486muD1QtvD9mxk';
  const keyClientKey = 'PLnQc8VAHS4mXEC9PkmuopSco2dchkmtD6tse1C4';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, liveQueryUrl: 'https://chat360.b4a.io', debug: true);
  await Hive.initFlutter();
  await Hive.openBox('selectedCategories');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatRoomProvider()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => KeywordListProvider()),
        ChangeNotifierProvider(create: (context) => CategoryListProvider()),
        ChangeNotifierProvider(create: (context) => SubCategoryListProvider()),
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
          'category_screen': (context) => const KeywordScreen(),
          'profile_screen': (context) => const ProfileScreen(),
          'user_launch': (context) => const UserLaunch(),
          'creator_account': (context) => const OrganizationAccount(),
          'user_account': (context) => const UserAccount(),
          'creator_approval': (context) => const CreatorApproval(),
          'edit_profile': (context) => const EditProfile(),
          'category_types': (context) => const SelectCategoryType(navigateScreen: ''),
          'manage_creator': (context) => const ManageCreator(),
          'chat_screen': (context) => const ChatScreen(),
          'image_chat': (context) => const ImageChat(),
          'home_screen_live': (context) => const HomeScreenLive(),
        },
      ),
    );
  }
}
