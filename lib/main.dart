import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:runmawi/AppUtils/AppConstants.dart';
import 'package:runmawi/Home.dart';
import 'package:runmawi/Model/Homeprovider.dart';
import 'package:runmawi/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async{
  // HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = prefs.getString(AppConstants.SHARED_PREFERENCE_USER_Id).toString().toLowerCase()!="null" ? true : false;
  runApp( MyApp(isLoggedIn));
}

class MyApp extends StatelessWidget {
  bool? isLogin;
   MyApp(this.isLogin);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//     print("object"+ AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).toString());
// bool isLogin =    AppPrefrence.getString(AppConstants.SHARED_PREFERENCE_USER_Id).toString().toLowerCase()!="null"?true:false;
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: HomeProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Runmawi',
            navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "IBMPlexSans"
          ),
          home:
          isLogin==true?const Home():
          const SplashScreen()
        ),
      ),
    );
  }

}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

// ... other methods and getters
}

