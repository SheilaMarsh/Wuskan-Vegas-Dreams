import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/home/ui/home_screen.dart';
import 'package:wuskan/ui/loose/ui/loose_screen.dart';
import 'package:wuskan/ui/win/ui/win_screen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

class GameScreen extends StatefulWidget {
  GameScreen({required this.bet});
  final int bet;
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  late final List<int> bombs;
  List<int> horStepHistory = List.generate(4, (index) => -1);
  final List<double> coeff = [0, 1.1, 1.4, 2];
  int step = 1;
  late double winsum;
  int horizontal = 1;
  UserModel user = Hive.box<UserModel>('user').values.first;
  @override
  initState() {
    var rng = Random();
    bombs = List.generate(4, (index) => rng.nextInt(3));
    bombs[0] = -100;
    winsum = widget.bet.toDouble();
    print(bombs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
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
                bottom: 45.h, top: 40.h, left: 16.w, right: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => Scaffold(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.05),
                                    body: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [Spacer()],
                                        ),
                                        InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            width: 279.w,
                                            height: 72.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: Svg(
                                                        Assets.images
                                                            .onboardingbtn.path,
                                                        size: Size(
                                                            279.w, 72.h)))),
                                            child: Center(
                                              child: Text(
                                                'resume'.toUpperCase(),
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 35.w,
                                                    fontFamily: 'Bebas',
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24.h),
                                          child: InkWell(
                                            onTap: () => showCupertinoDialog(
                                                context: context,
                                                builder: (_) =>
                                                    CupertinoAlertDialog(
                                                      content: Text(
                                                          'You will loose the money spent on the game'),
                                                      title:
                                                      Text('Restart the game?'),
                                                      actions: [
                                                        CupertinoDialogAction(
                                                          isDefaultAction: true,
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text(
                                                            'Cancel',
                                                          ),
                                                        ),
                                                        CupertinoDialogAction(
                                                          onPressed: (){
                                                            user.balance=user.balance!-widget.bet;
                                                            Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      GameScreen(
                                                                        bet: widget.bet,
                                                                      )));
                                                            },
                                                          child: Text('Yes'),
                                                        ),
                                                      ],
                                                    )),
                                            child: Container(
                                              width: 279.w,
                                              height: 72.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: Svg(
                                                          Assets.images
                                                              .longbtnnlue.path,
                                                          size: Size(
                                                              279.w, 72.h)))),
                                              child: Center(
                                                child: Text(
                                                  'restart'.toUpperCase(),
                                                  style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 35.w,
                                                      fontFamily: 'Bebas',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () => showCupertinoDialog(
                                              context: context,
                                              builder: (_) =>
                                                  CupertinoAlertDialog(
                                                    content: Text(
                                                        'You will loose the money spent on the game'),
                                                    title:
                                                        Text('Exit the game?'),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                      CupertinoDialogAction(
                                                        onPressed: (){
                                                          user.balance=(user.balance!-widget.bet);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    HomeScreen()));},
                                                        child: Text('Yes'),
                                                      ),
                                                    ],
                                                  )),
                                          child: Container(
                                            width: 279.w,
                                            height: 72.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: Svg(
                                                        Assets.images
                                                            .longbtnnlue.path,
                                                        size: Size(
                                                            279.w, 72.h)))),
                                            child: Center(
                                              child: Text(
                                                'exit'.toUpperCase(),
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 35.w,
                                                    fontFamily: 'Bebas',
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                          icon: Icon(
                            Icons.menu_rounded,
                            color: AppColors.white,
                            size: 30.w,
                          )),
                      Spacer(),
                      Text(
                        '${user.balance}',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28.w,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas'),
                      ),
                      Image.asset(
                        Assets.images.coin.path,
                        filterQuality: FilterQuality.high,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      step == 1
                          ? 'Choose the side and tap'
                          : 'You will get ${winsum.round()}',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.w,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas'),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                              if (step < 4)
                                setState(() {
                                  step++;
                                  horizontal = i;
                                });
                              if (bombs[3] != i && step == 4) {
                                user.balance=user.balance!-widget.bet;
                                setState(() =>
                                    winsum = winsum * coeff[3] + widget.bet);
                                await Hive.box<UserModel>('user').clear();
                                await Hive.box<UserModel>('user').add(user);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            WinScreen(sum: winsum.toInt())));
                              } else {
                                await Hive.box<UserModel>('user').clear();
                                await Hive.box<UserModel>('user').add(user);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            LooseScreen(sum: winsum.toInt())));
                              }
                            }},
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: cellIcon(i, 4),
                            ),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(width: 328.w),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () async {
                              if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                              if (step < 3)
                                setState(() {
                                  step++;
                                  horizontal = i;
                                  horStepHistory[2] = i;
                                });
                              if (bombs[2] != i && step == 3) {
                                user.balance=user.balance!-widget.bet;
                                setState(() =>
                                    winsum = winsum * coeff[2] + widget.bet);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LooseScreen(
                                              sum: winsum.toInt(),
                                            )));
                              }
                            }},
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: cellIcon(i, 3),
                            ),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(width: 328.w),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          InkWell(
                            onTap: () async {if(Hive.box<UserModel>('user').values.first.balance!>=widget.bet){
                              if (step < 2)
                                setState(() {
                                  step++;
                                  horizontal = i;
                                  horStepHistory[1] = i;
                                });
                              if (bombs[1] != i && step == 2) {
                                user.balance=user.balance!-widget.bet;
                                setState(() => winsum *= coeff[1]);
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LooseScreen(
                                              sum: winsum.toInt(),
                                            )));
                              }
                            }},
                            child: Container(
                              width: 109.w,
                              height: 93.h,
                              child: cellIcon(i, 2),
                            ),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(width: 328.w),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            width: 109.w,
                            height: 93.h,
                            child: cellIcon(i, 1),
                          )
                      ],
                    ),
                    Assets.images.gameborder.svg(width: 328.w),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tap cost - ${widget.bet}',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28.w,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Bebas')),
                    Image.asset(
                      Assets.images.coin.path,
                      filterQuality: FilterQuality.high,
                    )
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                step > 1
                    ? InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    WinScreen(sum: winsum.toInt()))),
                        child: Container(
                          width: 279.w,
                          height: 72.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Svg(Assets.images.onboardingbtn.path,
                                      size: Size(279.w, 72.h)))),
                          child: Center(
                            child: Text(
                              'take a reward'.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 35.w,
                                  fontFamily: 'Bebas',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async => false);
  Widget? cellIcon(int indexCell, int stepInd) {
    if ((stepInd < step && indexCell == bombs[stepInd - 1]))
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 72.h,
        ),
      );
    if ((step == stepInd &&
        bombs[stepInd - 1] == indexCell &&
        bombs[stepInd - 1] != -100 &&
        stepInd > 1))
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 72.h,
        ),
      );
    if ((step == 4 &&
            bombs[3] != indexCell &&
            indexCell != horizontal &&
            stepInd > 3) ||
        (horStepHistory[stepInd - 1] == indexCell && step > stepInd))
      return Center(
        child: Assets.images.gamestar.svg(
            color: AppColors.white.withOpacity(0.5), width: 40.w, height: 40.h),
      );
    if (step < 4 && stepInd - 1 == step)
      return Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFFFC700).withOpacity(0.15),
                    spreadRadius: 0.3,
                    blurRadius: 7)
              ]),
          child: Assets.images.gamestar
              .svg(color: Color(0xFFFFC700), width: 40.w, height: 40.h),
        ),
      );

    ///Если попадаю на бомбу, то прощай - тут условия что я не попал
    if (step == 4 &&
        horizontal != bombs[3] &&
        stepInd == 4 &&
        indexCell == bombs[3])
      return Center(
        child: Image.asset(
          Assets.images.bomb.path,
          filterQuality: FilterQuality.high,
          height: 72.h,
        ),
      );
    if ((stepInd == 1 && indexCell == 1 && step > 1) ||
        (step > stepInd &&
            bombs[stepInd - 1] != indexCell &&
            bombs[stepInd - 1] != indexCell &&
            bombs[stepInd - 1] != -100 &&
            stepInd > 1) ||
        (horizontal != indexCell && step == stepInd && stepInd!=1))
      return Center(
        child: Assets.images.gamestar
            .svg(color: AppColors.white, width: 40.w, height: 40.h),
      );
    return indexCell == horizontal && step == stepInd
        ? Center(
            child: Column(
              children: [
                Spacer(),
                Image.asset(
                  'assets/images/${user.activeSkin}.png',
                  height: 70.h,
                )
              ],
            ),
          )
        : null;
  }
}
