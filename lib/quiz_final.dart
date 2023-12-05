import 'package:financial_assistant/parameters.dart';
import 'package:financial_assistant/info.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ignore: must_be_immutable
class QuizFinal extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  QuizFinal({super.key});

  late int testNumber;

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;

    testNumber = args["testNumber"];
    var score = prefs.getInt("quiz${testNumber}_score") ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: AppColors.mainColor,
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
        toolbarHeight: 80,
        leadingWidth: 90,
        centerTitle: true,
        actions: const [
          SizedBox(
            width: 90,
          )
        ],
        title: Text(
          Quiz.quizNames[testNumber],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              AppColors.background,
              AppColors.lighterBack,
            ],
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(child: Image.asset("assets/image/Trophy.png")),
            const Text(
              "A perfect score",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "$score / ${Quiz.quizList[testNumber].length}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.mainColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "We are proud of you! You have shown a great result. Keep up the good work!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecond,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.mainColor,
                ),
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
