import 'package:financial_assistant/parameters.dart';
import 'package:financial_assistant/info.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.testNumber});

  final int testNumber;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late int currentQuestion;
  int? answer;
  late int score;

  bool showAnswer = false;

  @override
  void initState() {
    currentQuestion = prefs.getInt("quiz${widget.testNumber}_stop") ?? 0;
    score = prefs.getInt("quiz${widget.testNumber}_score") ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
          // Quiz.quizNames[widget.testNumber],
          "Quiz",
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
        child: Column(
          children: [
            Text(
              Quiz.quizNames[widget.testNumber],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
              maxLines: 5,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Quiz.quizList[widget.testNumber][currentQuestion]["question"]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      width: double.infinity,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.7,
                        children: [
                          for (int i = 0; i < 4; i++)
                            InkWell(
                              onTap: () {
                                if (!showAnswer) {
                                  setState(() {
                                    answer = i;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.mainColor,
                                    width: 1.2,
                                  ),
                                  color: showAnswer
                                      ? answer == i
                                          ? Colors.red
                                          : i ==
                                                  (Quiz.quizList[widget
                                                                  .testNumber]
                                                              [currentQuestion][
                                                          'correctAnswer'] as int) -
                                                      1
                                              ? Colors.green
                                              : null
                                      : answer == i
                                          ? AppColors.mainColor
                                          : null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "${(Quiz.quizList[widget.testNumber][currentQuestion]['answers']! as List)[i]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: answer == i ||
                                              i ==
                                                      (Quiz.quizList[widget
                                                                      .testNumber]
                                                                  [
                                                                  currentQuestion]
                                                              [
                                                              'correctAnswer'] as int) -
                                                          1 &&
                                                  showAnswer
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0;
                    i < Quiz.quizList[widget.testNumber].length;
                    i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: currentQuestion >= i
                          ? AppColors.mainColor
                          : AppColors.textSecond,
                      shape: BoxShape.circle,
                    ),
                    width: 10,
                    height: 10,
                  )
              ],
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (showAnswer == false) {
                    if (answer ==
                        (Quiz.quizList[widget.testNumber][currentQuestion]
                                ['correctAnswer']! as int) -
                            1) {
                      score++;
                    } else {
                      updateTests();
                      showAnswer = true;
                      prefs.setInt(
                          "quiz${widget.testNumber}_stop", currentQuestion + 1);
                      prefs.setInt("quiz${widget.testNumber}_score", score);
                      return;
                    }
                  } else {
                    showAnswer = false;
                  }
                  if (currentQuestion ==
                      Quiz.quizList[widget.testNumber].length - 1) {
                    updateTests();
                    Navigator.of(context)
                        .pushReplacementNamed("/result", arguments: {
                      "testNumber": widget.testNumber,
                    });
                    prefs.setInt(
                        "quiz${widget.testNumber}_stop", currentQuestion + 1);
                    prefs.setInt("quiz${widget.testNumber}_score", score);
                    return;
                  }
                  updateTests();
                  currentQuestion++;
                  prefs.setInt(
                      "quiz${widget.testNumber}_stop", currentQuestion);
                  prefs.setInt("quiz${widget.testNumber}_score", score);
                  answer = null;
                });
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
            ),
          ],
        ),
      ),
    );
  }
}
