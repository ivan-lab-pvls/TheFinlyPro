import 'package:financial_assistant/parameters.dart';


import 'package:flutter/material.dart';


import 'package:in_app_review/in_app_review.dart';


import 'package:url_launcher/url_launcher.dart';


class Settings extends StatelessWidget {

  const Settings({super.key});


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,

        leading: null,

        title: const Padding(

          padding: EdgeInsets.fromLTRB(0, 20, 0, 8),

          child: Text(

            "Settings",

            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),

            textAlign: TextAlign.center,

            maxLines: 3,

          ),

        ),

        toolbarHeight: 80,

      ),

      backgroundColor: AppColors.background,

      body: Stack(

        children: [

          Container(

            padding: const EdgeInsets.all(15),

            margin: const EdgeInsets.all(15),

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(15),

              color: Colors.white,

            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                InkWell(

                  onTap: () {
    launchUrl(Uri.parse("https://docs.google.com/document/d/1AppFda5nE6oe6PNP0K9pm3kqOca84qNmIcvgPCAvYQs/edit?usp=sharing"));
  },

                  child: Row(

                    children: [

                      Image.asset(

                        "assets/icons/tick.png",

                        width: 30,

                      ),

                      const SizedBox(

                        width: 10,

                      ),

                      const Text(

                        "Privacy Policy",

                        style: TextStyle(

                          fontSize: 18,

                          color: AppColors.textSecond,

                        ),

                      ),

                    ],

                  ),

                ),

                Container(

                  height: 1.5,

                  color: AppColors.background,

                  margin: const EdgeInsets.symmetric(vertical: 10),

                ),

                InkWell(

                  onTap: () {
    launchUrl(Uri.parse("https://docs.google.com/document/d/1puxImVJkzCfSCnhRkege2oBOMH9hFKBWbr8JRQ5_5Bo/edit?usp=sharing"));
  },

                  child: Row(

                    children: [

                      Image.asset(

                        "assets/icons/chat.png",

                        width: 30,

                      ),

                      const SizedBox(

                        width: 10,

                      ),

                      const Text(

                        "Terms of use",

                        style: TextStyle(

                          fontSize: 18,

                          color: AppColors.textSecond,

                        ),

                      ),

                    ],

                  ),

                ),

                Container(

                  height: 1.5,

                  color: AppColors.background,

                  margin: const EdgeInsets.symmetric(vertical: 10),

                ),

                InkWell(

                  onTap: () {

                    InAppReview.instance.openStoreListing(

                      appStoreId: '6473792200',

                    );

                  },

                  child: Row(

                    children: [

                      Image.asset(

                        "assets/icons/star.png",

                        width: 30,

                      ),

                      const SizedBox(

                        width: 10,

                      ),

                      const Text(

                        "Rate app",

                        style: TextStyle(

                          fontSize: 18,

                          color: AppColors.textSecond,

                        ),

                      ),

                    ],

                  ),

                ),

              ],

            ),

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

