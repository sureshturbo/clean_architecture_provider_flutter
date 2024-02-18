import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_app/Provider/AuthProvider/auth_provider.dart';
import 'package:rest_api_app/Provider/Database/db_provider.dart';
import 'package:rest_api_app/Provider/TaskProvider/add_task_provider.dart';
import 'package:rest_api_app/Provider/TaskProvider/delete_task_provider.dart';
import 'package:rest_api_app/Styles/colors.dart';
import 'package:rest_api_app/splash.dart';

import 'Provider/ProductProvider/app_navigation_provider.dart';
import 'Provider/ProductProvider/get_provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(create: (_) => AddTaskProvider()),
        ChangeNotifierProvider(create: (_) => DeleteTaskProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => AppNavigation(),),

      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: primaryColor,
            ),
            floatingActionButtonTheme:
                FloatingActionButtonThemeData(backgroundColor: primaryColor),
            primaryColor: primaryColor),
        home: const SplashScreen(),
      ),
    );
  }
}
