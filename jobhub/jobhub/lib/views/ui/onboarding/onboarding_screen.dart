import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/ui/onboarding/widgets/page_one.dart';
import 'package:jobhub/views/ui/onboarding/widgets/page_three.dart';
import 'package:jobhub/views/ui/onboarding/widgets/page_two.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<OnBoardNotifier>(builder: (context, OnBoardNotifier, child) {
      return Stack(
        children: [
          PageView(
            physics: OnBoardNotifier.isLastPage
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (page) {
              OnBoardNotifier.isLastPage = page == 2;
            },
            children: [
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
          Positioned(
              bottom: height * 0.09,
              left: 0,
              right: 0,
              child: Center(
                child: OnBoardNotifier.isLastPage
                    ? SizedBox.shrink()
                    : SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: JumpingDotEffect(
                          dotHeight: 12,
                          dotWidth: 12,
                          spacing: 10,
                          dotColor: Color(kDarkGrey.value).withOpacity(0.5),
                          activeDotColor: Color(kLight.value),
                          verticalOffset: 30,
                        ),
                      ),
              )),
          Positioned(
              child: OnBoardNotifier.isLastPage ? const SizedBox.shrink() : Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(2);
                    },
                    child: ReusableText(
                        text: "Skip",
                        style:
                            appstyle(16, Color(kLight.value), FontWeight.w500)),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    child: ReusableText(
                        text: "Next",
                        style:
                            appstyle(16, Color(kLight.value), FontWeight.w500)),
                  )
                ],
              ),
            ),
          )),
        ],
      );
    }));
  }
}
