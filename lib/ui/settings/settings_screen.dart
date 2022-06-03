import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/main.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/coins/coins_screen.dart';
import 'package:wuskan/ui/onboarding/ui/onboarding.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<SettingsScreen> {
  int selectedSum = 250;
  InAppReview inappreview = InAppReview.instance;
  UserModel user = Hive.box<UserModel>('user').values.first;
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
              padding: EdgeInsets.only(
                  bottom: 45.h, top: 56.h, left: 20.w, right: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.h,
                          )),
                      Spacer(),
                      Text(
                        '${Hive.box<UserModel>('user').values.first.balance}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.h,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Image.asset(
                          Assets.images.coin.path,
                          filterQuality: FilterQuality.high,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  if(!subscribed)RawBtn(
                    label: 'buy premium',
                    svgPath: Assets.images.prembtn.path,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => OnBoardingScreen())),
                  ),
                  if(subscribed)RawBtn(
                    onTap: ()async {
                      if(Hive.box<UserModel>('user').values.first.lastUpdate!.day-DateTime.now().day>=1){
                        setState(()=> user.balance=user.balance!+user.dailyCoinBalance!);
                        await Hive.box<UserModel>('user').clear();
                        await Hive.box<UserModel>('user').add(user);
                          }else{
                        print('День еще не прошел');
                      }
                    },
                      label: 'get daily coins',
                      svgPath: Assets.images.settingsprplbtn.path),
                  if(subscribed)RawBtn(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>DailyCoinsScreen())),
                      label: 'change coin balance',
                      svgPath: Assets.images.settingsprplbtn.path),
                  RawBtn(
                    onTap: ()=>openPrivacyPolicy(),
                      label: 'privacy policy',
                      svgPath: Assets.images.longbtnnlue.path),
                  RawBtn(
                      onTap: ()=>openTermsOfUse(),
                      label: 'terms of use',
                      svgPath: Assets.images.longbtnnlue.path),
                  RawBtn(
                    onTap:()=>inappreview.requestReview(),
                      label: 'rate app',
                      svgPath: Assets.images.longbtnnlue.path),
                  RawBtn(
                    onTap:()=>openSupport(),
                      label: 'support',
                      svgPath: Assets.images.longbtnnlue.path),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

class RawBtn extends StatelessWidget {
  RawBtn({this.onTap, required this.label, required this.svgPath});
  final String label;
  final VoidCallback? onTap;
  final String svgPath;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 280.w,
            height: 72.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Svg(svgPath, size: Size(280.w, 72.h)))),
            child: Center(
              child: Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: label == 'buy premium'
                      ? Color(0xFFFFDE41)
                      : AppColors.white,
                  fontSize: 35.w,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Bebas',
                ),
              ),
            ),
          ),
        ),
      );
}
