// ignore_for_file: prefer_const_constructors
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:flash/screens/welcome_screen.dart';
import 'package:flash/screens/login_screen.dart';
import 'package:flash/screens/registration_screen.dart';
import 'package:flash/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User loggedInUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(FlashChat());
}

class FlashChat extends StatefulWidget {
  const FlashChat({super.key});

  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  final _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  void checkLoggedIn() async {
    // print(_auth.currentUser);
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Navigator.pop(context);
        isLoggedIn = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: isLoggedIn ? ChatScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen()
      },
    );
  }
}

// class FlashChat extends StatelessWidget {
//   FlashChat({super.key});
//   final _auth = FirebaseAuth.instance;
//
//   void checkLoggedIn() async {
//     // print(_auth.currentUser);
//     try {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         // Navigator.pop(context);
//         isLoggedIn = true;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }
//
//   void initState() {
//     checkLoggedIn();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
