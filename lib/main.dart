import 'package:flutter/material.dart';
import 'package:pre_projeto/common/sistem/routes.dart';
import 'package:pre_projeto/home/page/home_page.dart';
import 'package:pre_projeto/login/page/login_page.dart';
import 'package:pre_projeto/movie/page/movie_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(
        useMaterial3: true,
      )
      ..copyWith(
        textTheme: Theme.of(context).textTheme..apply(fontFamily: 'Inter')
      ),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.login: (context) => const LoginPage(),
        Routes.movieDetail: (context) => const MovieDetailPage(),
      },
    );
  }
}

