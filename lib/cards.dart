import 'package:financial_assistant/parameters.dart';
import 'package:financial_assistant/info.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key, required this.testNumber});

  final int testNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          if (prefs.getInt("quiz${testNumber}_stop") ==
              Quiz.quizList[testNumber].length) {
            Navigator.of(context)
                .pushNamed("/result", arguments: {"testNumber": testNumber});
          } else {
            Navigator.of(context).pushNamed("/quiz$testNumber");
          }
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Image.asset("assets/image/piggy.png"),
              Image.network(
                Images.urls[testNumber],
                height: 70,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 90,
                child: Text(
                  Quiz.quizNames[testNumber],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              LinearProgressIndicator(
                value: (prefs.getInt("quiz${testNumber}_stop") ?? 0) /
                    (Quiz.quizList[testNumber].length),
                color: AppColors.mainColor,
                minHeight: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.courseNumber});

  final int courseNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed("/course$courseNumber"),
        child: Container(
          // height: 100,

          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Quiz.quizNames[courseNumber],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      Course.courseDescriptions[courseNumber]
                          .replaceFirst("      ", ""),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.textSecond,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Training completed",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                        color: AppColors.textSecond,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    LinearProgressIndicator(
                      value:
                          prefs.getDouble("course${courseNumber}_scroll") ?? 0,
                      color: AppColors.mainColor,
                      minHeight: 1.5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              // Image.asset(
              //   "assets/image/piggy.png",
              //   width: 80,
              // ),
              Image.network(
                Images.urlsCourses[courseNumber],
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeCard extends StatelessWidget {
  const IncomeCard({super.key, required this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                data["date"],
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mainColor,
                ),
              )
            ],
          ),
          Text(
            '${data["amount"]}\$',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.newsNumber});

  final int newsNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed("/news$newsNumber"),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                News.titles[newsNumber],
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          News.contents[newsNumber].replaceAll("      ", ""),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecond,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          News.dates[newsNumber],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 10,
                    child: Image.asset(
                      "assets/news/$newsNumber.png",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
