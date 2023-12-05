import 'dart:convert';

import 'package:financial_assistant/parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final ctrl = TextEditingController();
  final nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var total = 0.0;

    for (var i in history) {
      total += double.parse(i["amount"]);
    }
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
          "Add income",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: 30, top: 30, right: 30, bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Balance",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecond,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "\$${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please, enter the amount of money transfer in the field below",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecond,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Enter amount",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                    controller: ctrl,
                    decoration: InputDecoration(
                      fillColor: AppColors.mainColor,
                      prefix: ctrl.text == "" ? null : const Text("\$"),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                      ),
                      hintText: "\$0",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Enter transfer names",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      fillColor: AppColors.mainColor,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.mainColor),
                      ),
                      hintText: "Name",
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (ctrl.text != "" && nameCtrl.text != "")
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 100),
                child: InkWell(
                  onTap: () {
                    history.add({
                      "amount":
                          ctrl.text[0] == "." ? "0${ctrl.text}" : ctrl.text,
                      "date": formatDateTime(DateTime.now()),
                      "name": nameCtrl.text,
                    });

                    prefs.setString("history", jsonEncode(history));
                    updateWallet();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 70,
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
