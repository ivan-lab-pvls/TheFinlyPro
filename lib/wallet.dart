import 'package:financial_assistant/cards.dart';
import 'package:financial_assistant/parameters.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // Map<String, dynamic>

  @override
  void initState() {
    updateWallet = () {
      setState(() {
        debugPrint("$history");
      });
    };

    debugPrint("$history");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
          child: Text(
            "Take control your finances",
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
          history.isEmpty
              ? Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.background,
                        AppColors.lighterBack,
                        AppColors.background,
                      ],
                    ),
                  ),
                  margin: const EdgeInsets.only(bottom: 120),
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No information on income yet",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Click the \"Add income\" button",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecond,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.only(bottom: 90, left: 20, right: 20),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i in history)
                          IncomeCard(
                            data: i,
                          ),
                      ],
                    ),
                  ),
                ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 110, right: 25),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed("/addIncome"),
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
                ),
              )),
          const Align(
            alignment: Alignment.bottomCenter,
            child: NavBar(),
          )
        ],
      ),
    );
  }
}
