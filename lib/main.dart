import 'dart:ui';

import 'package:financial_assistant/add_income.dart';
import 'package:financial_assistant/course_page.dart';
import 'package:financial_assistant/education.dart';
import 'package:financial_assistant/home.dart';
import 'package:financial_assistant/intro.dart';
import 'package:financial_assistant/news.dart';
import 'package:financial_assistant/news_page.dart';
import 'package:financial_assistant/parameters.dart';
import 'package:financial_assistant/quiz_final.dart';
import 'package:financial_assistant/info.dart';
import 'package:financial_assistant/quiz_page.dart';
import 'package:financial_assistant/settings.dart';
import 'package:financial_assistant/wallet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fsfdgfd.dart';
import 'xasfasd.dart';

late SharedPreferences prefs;
bool a = true;
bool d = false;
final config = FirebaseRemoteConfig.instance;
//print('get');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: Data.currentPlatform);
  await config.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  ));
  await Nortif().activate();
  prefs = await SharedPreferences.getInstance();
  await callS();
  runApp(const MainApp());
}

var routes = <String, Widget>{
  '/': const IntroWidget(),
  '/home': const HomeWidget(),
  '/education': const Education(),
  '/result': QuizFinal(),
  for (int i = 0; i < Quiz.quizList.length; i++)
    '/quiz$i': QuizPage(testNumber: i),
  for (int i = 0; i < Course.courseNames.length; i++)
    '/course$i': CoursePage(courseNumber: i),
  '/wallet': const Wallet(),
  '/addIncome': const AddIncome(),
  '/inbox': const NewsPage(),
  for (int i = 0; i < News.titles.length; i++)
    '/news$i': NewsReadPage(newsNumber: i),
  '/settings': const Settings(),
};
final rateCallView = InAppReview.instance;
Future<void> callS() async {
  bool isRated = prefs.getBool('updatexx') ?? false;
  if (!isRated) {
    if (await rateCallView.isAvailable()) {
      rateCallView.requestReview();
      await prefs.setBool('updatexx', true);
    }
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var intro = prefs.getBool("intro") ?? false;
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkNewUpdatesAnddata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return HomeWidgeet(money: mxsafs!);
            } else {
              return intro ? const HomeWidget() : const IntroWidget();
            }
          } else {
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.asset('assets/image/icon.png'),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
      onGenerateRoute: (settings) {
        var args = settings.arguments as Map<String, dynamic>?;
        var dir = "right";
        if (args != null && args.containsKey("dir")) {
          dir = args["dir"];
        }
        return PageRouteBuilder(
            settings:
                settings,
            pageBuilder: (_, __, ___) => routes[settings.name] ?? Placeholder(),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(dir == "left" ? -1 : 1, 0),
                        end: Offset(0, 0))
                    .animate(a),
                child: c));
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 50,
          color: AppColors.background,
        ),
      ),
    );
  }
}
