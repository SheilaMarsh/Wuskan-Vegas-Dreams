import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/backgrounds/backgrounds_screen.dart';
import 'package:wuskan/ui/game/ui/game_screen.dart';
import 'package:wuskan/ui/settings/settings_screen.dart';
import 'package:wuskan/ui/skins/skins_screen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedSum = 250;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xFF142850),
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF142850), Color(0xFF253B6E)]),
                image: DecorationImage(
                    image: AssetImage('assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 45.h,top: 56.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${Hive.box<UserModel>('user').values.first.balance!}',style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.h,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas',
                        ),),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Image.asset(
                          Assets.images.logo.path,
                          filterQuality: FilterQuality.high,
                          width: 385.w,
                          height: 265.h,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24.h,bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Choose the bet sum",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28.w,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.only(left: 56.w,right:56.w, top: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$selectedSum',
                          style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Bebas',
                              fontSize: 28.w),
                        ),
                        Image.asset(Assets.images.coin.path)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Container(
                            width: 18.w,height: 4.h,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      selectedSum!=10
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=10),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=50),
                          child:Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.h),
                              child:Container(
                            width: 56.w,height: 4.h,
                            color: AppColors.white,
                          ))),
                      selectedSum!=50
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=50),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=250),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 56.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          )),
                      selectedSum!=250 ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=250),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=500),
                          child:Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 56.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          ),
                      ),
                      selectedSum!=500
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=500),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                          onTap: ()=>setState(()=>selectedSum=1000),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Container(
                              width: 56.w,height: 4.h,
                              color: AppColors.white,
                            ),
                          )),
                      selectedSum!=1000
                          ? InkWell(
                        child: Container(
                          width: 4.w,height: 16.h,
                          color: AppColors.white,
                        ),
                        onTap: ()=>setState(()=>selectedSum=1000),
                      )
                          : Container(
                        width: 16.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                            color: AppColors.yellow,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Color(0xFFBF9500),width: 1.r)
                        ),
                      ),
                      InkWell(
                        onTap: ()=>setState(()=>selectedSum=1000),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Container(
                            width: 18.w,height: 4.h,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: InkWell(
                      onTap: ()=>Navigator.push(context, PageTransition<Widget>(child: GameScreen(bet: selectedSum),type:PageTransitionType.rightToLeft)),
                      child: Container(
                        height: 72.h,
                        width: 279.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Svg(Assets.images.onboardingbtn.path,
                                    size: Size(279.w, 72.h)))),
                        child: Center(
                          child: Text(
                            "Start".toUpperCase(),
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
                    EdgeInsets.symmetric(horizontal: 56.w, vertical: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(context, PageTransition(child: SkinsScreen(), type: PageTransitionType.rightToLeft)),
                          child: Container(
                            width: 77.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Svg(Assets.images.shortbtnblue.path,size: Size(72.w,72.w))
                                )
                            ),
                            child: Center(
                              child: Assets.images.skinslogo.svg(width: 20.w,height: 29.h),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ()=>Navigator.push(context, PageTransition(child: BackgroundScreen(), type: PageTransitionType.rightToLeft)),
                          child: Container(
                            width: 77.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: Svg(Assets.images.shortbtnblue.path,size: Size(72.w,72.w))
                              )
                            ),
                            child: Center(
                              child: Assets.images.bglogo.svg(width: 26.w,height: 26.h),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingsScreen())),
                          child: Container(
                            width: 77.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Svg(Assets.images.shortbtnblue.path,size: Size(72.w,72.w))
                                )
                            ),
                            child: Center(
                              child: Assets.images.settingslogo.svg(width: 26.w,height: 29.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }

}
