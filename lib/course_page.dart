import 'package:financial_assistant/parameters.dart';
import 'package:financial_assistant/info.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ignore: must_be_immutable
class CoursePage extends StatelessWidget {
  CoursePage({super.key, required this.courseNumber});

  final int courseNumber;
  double curScroll = 0;

  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          // Quiz.quizNames[courseNumber],
          "Course",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
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
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (note) {
            curScroll = note.metrics.pixels /
                (note.metrics.maxScrollExtent - note.metrics.minScrollExtent);

            prefs.setDouble("course${courseNumber}_scroll", curScroll);
            updateTests();

            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "assets/courses/$courseNumber.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    Course.courseNames[courseNumber],
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    Course.courseDescriptions[courseNumber],
                    textAlign: TextAlign.justify,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (prefs.getInt("quiz${courseNumber}_stop") ==
                        Quiz.quizList[courseNumber].length) {
                      Navigator.of(context).pushReplacementNamed("/result",
                          arguments: {"testNumber": courseNumber});
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed("/quiz$courseNumber");
                    }
                  },
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
