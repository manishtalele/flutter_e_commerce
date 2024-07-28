import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_e_commerce/controller/remoteconfig.dart';
import 'package:flutter_e_commerce/controller/user_provider.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';
import 'package:flutter_e_commerce/view/auth/login_screen.dart';
import 'package:flutter_e_commerce/view/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await fetchAndActivateRemoteConfig();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: bgcolor,
            foregroundColor: primarycolor,
            elevation: 0,
            centerTitle: true),
        scaffoldBackgroundColor: bgcolor,
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool userlogged = false;
  bool loader = true;

  void checkuserlog() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userLogged = prefs.getBool('userLogged') ?? false;
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false).setUserLogged(userLogged);
  }

  @override
  void initState() {
    checkuserlog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final userProvider = Provider.of<UserProvider>(context);
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return userProvider.userLogged
            ? const HomeScreen()
            : const LoginScreen();
      },
    );
  }
}
