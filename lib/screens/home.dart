import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/data_model.dart';
import 'package:quiz_app/screens/question_no.dart';
import 'package:quiz_app/widgets/question_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key, @required this.questionNo}) : super(key: key);
  final int? questionNo;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? controller;

  void nonAnsSelect() async {
    context.read<DataModel>().nonAnsselected();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: QuestionNumber(
                questionNo: context.read<DataModel>().questionNo),
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 800)));
    context.read<DataModel>().btnPressed(false);
    context.read<DataModel>().btnColorChange(false);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(
            seconds: context.read<DataModel>().baseData[widget.questionNo! - 1]
                ['time']),
        vsync: this);
    controller!.repeat();
    pageNaviTimer = Timer(
        Duration(
            seconds: context.read<DataModel>().baseData[widget.questionNo! - 1]
                ['time']), () {
      nonAnsSelect();
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
    pageNaviTimer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final List data = context.watch<DataModel>().baseData;
    final List optiondata = data[widget.questionNo! - 1]['options'];
    return Scaffold(
        body: SafeArea(
            child: Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Visibility(
                  visible:
                      context.read<DataModel>().isBtnPressed ? false : true,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: TweenAnimationBuilder(
                      tween: Tween<double>(begin: 1, end: 0),
                      duration: Duration(
                          seconds: data[widget.questionNo! - 1]['time']),
                      builder: (context, double value, _) {
                        return LinearProgressIndicator(
                          minHeight: 7,
                          value: value,
                          backgroundColor: Colors.black,
                          valueColor: controller!.drive(
                              ColorTween(begin: Colors.white, end: Colors.red)),
                        );
                      }),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(right: 5),
                        child: Center(
                          child: Text('${widget.questionNo}/${data.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Stack(
                        children: [
                          AnimatedContainer(
                            height: 35,
                            width: context.watch<DataModel>().containerWidth,
                            duration: const Duration(seconds: 1),
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade800,
                                border: Border.all(
                                    width: 1.5, color: Colors.grey.shade700),
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          Container(
                            height: 35,
                            width: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: Colors.grey.shade700),
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Streak",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "|",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  "|",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.local_fire_department,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    Text(
                                      '${context.read<DataModel>().streak}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 35,
                        width: 60,
                        margin: const EdgeInsets.only(right: 1),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.military_tech_outlined,
                              color: Colors.purple[300],
                              size: 20,
                            ),
                            AnimatedFlipCounter(
                              value: context.read<DataModel>().rank == 0
                                  ? 0
                                  : context.read<DataModel>().rank,
                              suffix: 'th',
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInBack,
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 60,
                        margin: const EdgeInsets.only(right: 1),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.bubble_chart_outlined,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            AnimatedFlipCounter(
                                value: context.read<DataModel>().score,
                                duration: const Duration(seconds: 1),
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.purple[900],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Text(
                    "${data[widget.questionNo! - 1]['question']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: optiondata.length,
                  itemBuilder: (_, index) => QuestionCard(
                    index: index,
                    optionName: "${optiondata[index]['option']}",
                    correctAnswer: optiondata[index]['correct'],
                    questNo: widget.questionNo,
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    )));
  }
}
