import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

import 'provider/chat_room_provider.dart';
import 'screens/chat_room/chat_rooms.dart';
import 'screens/filter_chat/filter_chat.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart.dart';
import 'screens/splash/splash_screen.dart';

Future<void> main() async {
  await Parse().initialize(
    "pYLM3p7I3jiAocohGfLQMvWgx486muD1QtvD9mxk", "https://parseapi.back4app.com",
    clientKey: "PLnQc8VAHS4mXEC9PkmuopSco2dchkmtD6tse1C4",
    debug: true,
    liveQueryUrl: "https://chat360.b4a.io",
    // autoSendSessionId: true,
    // coreStore: CoreStoreMemoryImp(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatRoomProvider())
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
          'login_screen': (context) => const LoginScreen(),
          'home_screen': (context) => const HomeScreen(),
          'filter_chat': (context) => const FilterChatScreen(),
          'chat_room': (context) => const ChatRooms(),
        },
      ),
    );
  }
}
