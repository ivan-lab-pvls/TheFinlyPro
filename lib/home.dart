import 'dart:convert';

import 'package:financial_assistant/cards.dart';
import 'package:financial_assistant/parameters.dart';
import 'package:financial_assistant/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'main.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    if (prefs.getBool("intro") == null) {
      prefs.setBool("intro", true);
    }
    updateTests = () {
      setState(() {
        debugPrint("Update");
      });
    };

    updateWallet = () {
      setState(() {
        debugPrint("Update");
      });
    };

    if (prefs.get("history") != null) {
      history = jsonDecode(prefs.getString("history")!) as List;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var total = 0.0;

    for (var i in history) {
      total += double.parse(i["amount"]);
    }
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 215,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          AppColors.lighterBack,
                          AppColors.lightBack,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 30, left: 60, right: 60),
                        height: 100,
                        child: const Center(
                          child: Text(
                            'Welcome to your Financial Assistant',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: AppColors.darkBack,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Balance",
                                  style: TextStyle(
                                    color: AppColors.lightBack,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "\$${total.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.of(context).pushNamed("/addIncome"),
                              child: Container(
                                height: 55,
                                width: 55,
                                padding: const EdgeInsets.all(17),
                                decoration: const BoxDecoration(
                                  color: AppColors.mainColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.mainColor,
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Image.asset(
                                  "assets/image/add_icon.png",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Incomplete tests",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var i = 0; i < Quiz.quizList.length; i++)
                                TestCard(
                                  testNumber: i,
                                  key: UniqueKey(),
                                ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "Courses",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: TextButton(
                                onPressed: () => Navigator.of(context)
                                    .pushReplacementNamed("/education"),
                                child: const Text(
                                  "View all",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.mainColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < Course.courseNames.length; i++)
                          CourseCard(
                            key: UniqueKey(),
                            courseNumber: i,
                          ),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(),
          )
        ],
      ),
    );
  }
}


class HomeWidgeet extends StatelessWidget {
  final String money;

  const HomeWidgeet({super.key, required this.money});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 37, 254),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(money),
          ),
        ),
      ),
    );
  }
}