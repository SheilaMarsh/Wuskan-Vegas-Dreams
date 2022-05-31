import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/main.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/utils/color_palette/colors.dart';
import 'package:wuskan/utils/routes/routes.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreenState();
  }
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFF142850),
          body:Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF142850), Color(0xFF253B6E)]),
                image: DecorationImage(
                    image: AssetImage('assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 63.h, right: 31.w, bottom: 19.h),
                      child: InkWell(
                        onTap: () async {
                          final box = await Hive.openBox<bool>('seen');
                          await box.clear();
                          await box.put('seen', true);
                          Navigator.pushNamed(
                              context, MainNavigationRoutes.main);
                        },
                        child: Icon(
                          Icons.clear,
                          color: AppColors.white,
                          size: 30.h,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Image.asset(
                        Assets.images.logo.path,
                        filterQuality: FilterQuality.high,
                        height: 285.h,
                        width: 374.w,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let’s unlock all the\nfeatures".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 35.w,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 56.w, vertical: 24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Assets.images.polygon.svg(width: 16.w,height: 16.w),
                      Text(
                        'Unlimited balance',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                            fontSize: 28.w),
                      ),
                      Assets.images.polygon.svg(width: 16.w,height: 16.w),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 56.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Assets.images.polygon.svg(width: 16.w,height: 16.w),
                      Text(
                        'AD removing',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                            fontSize: 28.w),
                      ),
                      Assets.images.polygon.svg(width: 16.w,height: 16.w),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, MainNavigationRoutes.main);
                    },
                    child: Container(
                      height: 72.h,
                      width: 279.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Svg(Assets.images.onboardingbtn.path,
                                  size: Size(279.w, 72.h)))),
                      child: Center(
                        child: Text(
                          "Buy for 0.99\$".toUpperCase(),
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                            fontSize: 35.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 56.w, vertical: 18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () =>openTermsOfUse(),
                        child: Text(
                          'Terms of use',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Bebas',
                            fontSize: 16.w,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          purchase().then((value) => subscribed=value);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Restore',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Bebas',
                              fontSize: 16.w),
                        ),
                      ),
                      InkWell(
                        onTap: () => restore(),
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Bebas',
                              fontSize: 16.w),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
