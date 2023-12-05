import 'package:financial_assistant/cards.dart';
import 'package:financial_assistant/parameters.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
          child: Text(
            "Business news",
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
            margin: const EdgeInsets.only(bottom: 90),
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All news",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/reverse.png",
                        height: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < 10; i++)
                          NewsCard(
                            newsNumber: i,
                          ),
                      ],
                    ),
                  ),
                )
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
