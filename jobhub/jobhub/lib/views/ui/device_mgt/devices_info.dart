import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/device_mgt/widgets/device_info.dart';
import 'package:jobhub/views/ui/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';
import '../../common/drawer/drawer_widget.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var onBoardNotifier = Provider.of<OnBoardNotifier>(context);
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Device Management",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpacer(size: 50),
                  Text(
                    "You are logged in into your account on these devices",
                    style: appstyle(16, Color(kDark.value), FontWeight.normal),
                  ),
                  HeightSpacer(size: 50),
                  DevicesInfo(
                    date: loginDate,
                    device: "Samsung M53",
                    ipAdress: '192.10.192.2',
                    location: 'Delhi',
                    platform: 'Android',
                  ),
                  HeightSpacer(size: 50),
                  DevicesInfo(
                    date: loginDate,
                    device: "Samsung M51",
                    ipAdress: '192.10.193.2',
                    location: 'Bangalore',
                    platform: 'Android',
                  ),
                ],
              ),
            ),
            Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
              return Padding(
                padding: EdgeInsets.all(8.0.h),
                child: GestureDetector(
                  onTap: () {
                    zoomNotifier.currentIndex = 0;
                    onBoardNotifier.isLastPage = false;
                    Get.to(() => OnBoardingScreen());
                  },
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableText(
                          text: "Sign Out",
                          style: appstyle(
                              16, Color(kOrange.value), FontWeight.w600))),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
