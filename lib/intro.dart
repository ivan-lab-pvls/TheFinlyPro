import 'package:financial_assistant/parameters.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroWidget extends StatefulWidget {
  const IntroWidget({super.key});

  @override
  State<IntroWidget> createState() => _IntroWidgetState();
}

class _IntroWidgetState extends State<IntroWidget> {
  var currentPage = 0;

  var titles = ["Comprehensive Financial Education", "We value tour feedback"];
  var content = [
    "From budgeting basics to advanced investment strategies, "
        "the app provides a comprehensive learning hub that caters "
        "to users of all financial literacy levels.",
    "Every day we are getting better due to your ratings and"
        " reviews — that helps us protect your accounts.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
            child: const Text(
              "Skip",
              style: TextStyle(
                color: AppColors.accentColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.background,
              AppColors.background,
              AppColors.lighterBack,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        padding:
            const EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                margin: const EdgeInsets.only(bottom: 40),
                child: Image.asset("assets/image/start_$currentPage.png"),
              ),
            ),
            Column(
              children: [
                Text(
                  titles[currentPage],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  content[currentPage],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecond,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == 0
                            ? AppColors.mainColor
                            : AppColors.textSecond,
                      ),
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentPage == 1
                            ? AppColors.mainColor
                            : AppColors.textSecond,
                      ),
                      width: 8,
                      height: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    if (currentPage == 1) {
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      setState(() {
                        currentPage++;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => launchUrl(Uri.https("google.com")),
                      child: const Text(
                        "Terms of use",
                        style: TextStyle(
                          color: AppColors.textSecond,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      color: AppColors.textSecond,
                      width: 1,
                    ),
                    InkWell(
                      onTap: () => launchUrl(Uri.https("google.com")),
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: AppColors.textSecond,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
