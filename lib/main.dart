import 'package:flutter/material.dart';
import 'package:pondok207/screen/auth/auth_view_model.dart';
import 'package:pondok207/screen/auth/login_screen.dart';
import 'package:pondok207/screen/component/navigation_pane.dart';
import 'package:pondok207/screen/home/menu_view_model.dart';
import 'package:pondok207/screen/keranjang/cart_model_view.dart';
import 'package:pondok207/screen/pesananku/pesanan_view_model.dart';
import 'package:pondok207/screen/settings/profile_model_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => MenuViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => PesananViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ceckLogin();
  }

  Future ceckLogin() async {
    Future.delayed(const Duration(seconds: 6), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var islogin = pref.getBool("is_login");
      if (islogin != null && islogin) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const NavigationPage(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget example1 = SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 6000,
      imageSize: 740,
      imageSrc: "images/splash.jpg",
      backgroundColor: Color.fromRGBO(142, 3, 3, 3),
      pageRouteTransition: PageRouteTransition.Normal,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash screen Demo',
      home: example1,
    );
  }
}
