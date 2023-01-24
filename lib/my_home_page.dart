import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool isActive = false;
  int counter = 0;
  //
  @override
  void initState() {
    //
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3733));
    //
    _controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          debugPrint('Animation completed');
          setState(() {
            isActive = false;
          });
          _controller.reset();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.oneDollarApp),
          centerTitle: true,
          backgroundColor: AppStrings.textColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  AppStrings.congratulations,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppStrings.textColor,
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.05,
                // ),
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: double.infinity,
                      child: Lottie.asset(AppStrings.celebrationBoxPath),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: Text(
                          counter.toString(),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppStrings.textColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: isActive
                          ? GestureDetector(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.50,
                                width: double.infinity,
                                child: Center(
                                  child: Lottie.asset(
                                    AppStrings.celebrationPath,
                                    animate: false,
                                    controller: _controller,
                                    // onLoaded: (composition) {
                                    //   _controller.duration = composition.duration;
                                    //   debugPrint(composition.duration.inMilliseconds
                                    //       .toString());
                                    // },
                                  ),
                                ),
                              ),
                              onTap: () {
                                resetAnimation();
                              },
                            )
                          : Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.50,
                              color: Colors.white.withOpacity(0.55),
                            ),
                      onTap: () {
                        startAnimation();
                      },
                    ),
                  ],
                ),
                const Text(
                  AppStrings.clickOnTheBox,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppStrings.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  startAnimation() {
    setState(() {
      isActive = true;
      counter++;
      debugPrint('pressed');
    });
    _controller.forward();
  }

  resetAnimation() {
    setState(() {
      _controller.reset();
      counter++;
      debugPrint('reset animation !!!');
    });
    _controller.forward();
  }
}
