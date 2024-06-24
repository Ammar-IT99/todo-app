
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/auth_Provider.dart';
import 'package:todo_app/Providers/list_provider.dart';
import 'package:todo_app/auth/login/login_Screen.dart';
import 'Home_Screen.dart';
import 'My_Theme.dart';
 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Providers/app_config_provider.dart';
import 'auth/register/register_Screen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
       options: const FirebaseOptions(
         apiKey: 'AIzaSyDfmoOgWexKIRC_TBz1mNabaCWILFK3QzU',
         appId: '1:241949930177:android:9a3020897e62128786da40',
         messagingSenderId: '241949930177',
         projectId: 'todo-apps-d50f2',
         storageBucket: 'todo-apps-d50f2.appspot.com',
       )
   );
   await Firebase.initializeApp();
   // await FirebaseFirestore.instance.disableNetwork();
   // FirebaseFirestore.instance.settings =
   //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=> ListProvider()),
    ChangeNotifierProvider(create: (context)=> AuthProviders()),
    ChangeNotifierProvider(  create: (context) => AppConfigProvider())
  ],
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
        debugShowCheckedModeBanner: false,
        initialRoute: loginScreen.routeName,
        routes: {
          loginScreen.routeName:(context)=> loginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          registerScreen.routeName:(context)=> registerScreen(),

        },
        theme: MyTheme.lightMode,
            darkTheme: MyTheme.darkMode,
    themeMode: provider.appTheme,);
  }
}
