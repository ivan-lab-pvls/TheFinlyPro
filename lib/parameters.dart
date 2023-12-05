library parameters;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class AppColors {
  static const mainColor = Color(0xFF4C4AEF);
  static const background = Color(0xFFE7E7EA);
  static const lighterBack = Color(0xFFcecef5);
  static const lightBack = Color(0xFFb8b7f8);
  static const textSecond = Color(0xFF858496);
  static const accentColor = Color(0xFFFF7422);
  static const darkBack = Color(0xFF3a3c44);
}

late Function() updateTests;
late Function() updateWallet;

var history = [];

String formatDateTime(DateTime dt) {
  return DateFormat('dd MMMM, y').format(dt);
}

String activePage = "home";

var pages = [
  "home",
  "teacher",
  "wallet",
  "addIncome",
  "inbox",
  "settings",
];

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0x88ffffff),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecond.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (activePage != 'home') {
                      setState(() {
                        activePage = "home";
                      });
                      Navigator.of(context)
                          .pushReplacementNamed("/home", arguments: {
                        "dir": "left",
                      });
                    }
                  },
                  icon: Image.asset(
                    "assets/icons/home_${activePage == 'home' ? 'fill' : 'line'}.png",
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (activePage != 'teacher') {
                      var dir =
                          pages.indexOf("teacher") > pages.indexOf(activePage)
                              ? "right"
                              : "left";
                      setState(() {
                        activePage = "teacher";
                      });
                      Navigator.of(context)
                          .pushReplacementNamed("/education", arguments: {
                        "dir": dir,
                      });
                    }
                  },
                  icon: Image.asset(
                    "assets/icons/teacher_${activePage == 'teacher' ? 'fill' : 'line'}.png",
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (activePage != 'wallet') {
                      var dir =
                          pages.indexOf("wallet") > pages.indexOf(activePage)
                              ? "right"
                              : "left";
                      setState(() {
                        activePage = "wallet";
                      });
                      Navigator.of(context)
                          .pushReplacementNamed("/wallet", arguments: {
                        "dir": dir,
                      });
                    }
                  },
                  icon: Image.asset(
                    "assets/icons/wallet_${activePage == 'wallet' ? 'fill' : 'line'}.png",
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (activePage != 'inbox') {
                      var dir =
                          pages.indexOf("inbox") > pages.indexOf(activePage)
                              ? "right"
                              : "left";
                      setState(() {
                        activePage = "inbox";
                      });
                      Navigator.of(context)
                          .pushReplacementNamed("/inbox", arguments: {
                        "dir": dir,
                      });
                    }
                  },
                  icon: Image.asset(
                    "assets/icons/inbox_${activePage == 'inbox' ? 'fill' : 'line'}.png",
                    height: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (activePage != 'settings') {
                      setState(() {
                        activePage = "settings";
                      });
                      Navigator.of(context)
                          .pushReplacementNamed("/settings", arguments: {
                        "dir": "right",
                      });
                    }
                  },
                  icon: Image.asset(
                    "assets/icons/settings_${activePage == 'settings' ? 'fill' : 'line'}.png",
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
