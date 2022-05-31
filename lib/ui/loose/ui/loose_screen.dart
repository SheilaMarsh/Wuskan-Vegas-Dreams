import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/home/ui/home_screen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

class LooseScreen extends StatefulWidget {
  final int sum;
  const LooseScreen({Key? key, required this.sum}) : super(key: key);

  @override
  State<LooseScreen> createState() => _LooseScreenState();
}

class _LooseScreenState extends State<LooseScreen> {
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  initState(){
    user.balance=user.balance!-widget.sum;
    Hive.box<UserModel>('user').clear().then((value) => Hive.box<UserModel>('user').add(user));
    super.initState();
  }
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
              padding: EdgeInsets.only(top: 64.h, left: 20.w, right: 20.w,bottom: 58.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomeScreen())),
                        icon: Icon(
                          Icons.clear,
                          size: 30.w,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text('You lose'.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 35.h,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Bebas',
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '- ${widget.sum}',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28.w,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas'),
                      ),
                      Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,)
                    ],
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      Assets.images.lose.path,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fill,
                      width: 375.w,
                      height: 375.h,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: InkWell(
                      onTap: ()=>Navigator.push(context, PageTransition<Widget>(child: HomeScreen(),type:PageTransitionType.rightToLeft)),
                      child: Container(
                        height: 72.h,
                        width: 279.w,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: Svg(Assets.images.onboardingbtn.path,
                                    size: Size(279.w, 72.h)))),
                        child: Center(
                          child: Text(
                            "try again".toUpperCase(),
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
                  )
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
