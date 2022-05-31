
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hive/hive.dart';
import 'package:wuskan/gen/assets.gen.dart';
import 'package:wuskan/models/user/user_model.dart';
import 'package:wuskan/ui/home/ui/home_screen.dart';
import 'package:wuskan/utils/color_palette/colors.dart';

class SkinsScreen extends StatefulWidget {
  const SkinsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SkinsScreenState();
  }
}

class Skin {
  Skin({this.name, this.dispname, this.description, this.price});

  int? price;
  String? dispname;
  String? name;
  String? description;
}

class _SkinsScreenState extends State<SkinsScreen> {
  static List<Skin> skins = [
    Skin(
        name: 'mike',
        dispname: 'mike',
        description:
            'Kind and honest policeman trying to cope with all problems',
        price: 0),
    Skin(
        name: 'shotgunmike',
        dispname: 'shotgun mike',
        description:
            'Sometimes, it takes a couple of grams of lead to solve some problems',
        price: 2000),
    Skin(
        name: 'missqueen',
        dispname: 'miss queen',
        description:
            'Cunning and clever thief, capable ofboth stealing a smal trinket and mining an entire building',
        price: 3500),
    Skin(
        name: 'mitchell',
        dispname: 'mitchell',
        description:
            "He was in the police force even before Mike, so he's seen a lot of things",
        price: 6000),
    Skin(
        name: 'barbara',
        dispname: 'barbara',
        description:
            "The head of a gang of criminals hiding behind the guise of a business woman",
        price: 10000),
  ];
  UserModel user = Hive.box<UserModel>('user').values.first;
  int currInd = 0;
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
                    image: AssetImage(
                        'assets/images/${Hive.box<UserModel>('user').values.first.activeBg}.png'),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.only(bottom: 58.h, top: 56.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                          onPressed: () async {
                            await Hive.box<UserModel>('user').clear();
                            await Hive.box<UserModel>('user').add(user);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
    },
                            icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.white,
                            size: 30.w,
                            ),
                            ),
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
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  Container(
                    height: 350.h,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (currInd > 0) setState(() => currInd--);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Container(
                                height: 350.h,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.white,
                                    size: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/${skins[currInd].name}.png',filterQuality: FilterQuality.high,width: 230.w),
                                  Spacer(),
                                  Text(skins[currInd].dispname!.toUpperCase()
                                    ,style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 35.w,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Bebas',
                                        letterSpacing: -0.3.w
                                    ),)
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 350.h,
                            child: Center(
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (currInd >=0&&currInd<4) setState(() => currInd++);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: Container(
                                        height: 350.h,
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: AppColors.white,
                                            size: 30.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Text(skins[currInd].description!,style: TextStyle(
                      color: AppColors.white,
                      fontFamily: 'Bebas',
                      fontWeight: FontWeight.w700,
                      fontSize: 28.w,
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Hive.box<UserModel>('user').values.first.availableSkins!.contains(skins[currInd].name!) ? Container()
                      :Padding(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(skins[currInd].price!.toString(),style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28.w,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas'
                      ),),
                      Image.asset(Assets.images.coin.path,filterQuality: FilterQuality.high,)
                    ],
                  ),padding: EdgeInsets.only(bottom: 12.h),),
                  InkWell(
                    onTap: (){
                      final userData = user;
                      if(userData.availableSkins!.contains(skins[currInd].name)==false&&(userData.balance)!>=skins[currInd].price!){
                        setState((){
                          userData.balance=userData.balance!-skins[currInd].price!;
                          userData.availableSkins!.add(skins[currInd].name!);
                        });
                      }
                      if(userData.availableSkins!.contains(skins[currInd].name)==true&&userData.activeSkin! != skins[currInd]){
                        setState(()=>userData.activeSkin=skins[currInd].name);
                      }
                    },
                    child: Container(
                      width: 279.w,
                      height: 72.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Svg(pathSelector(),size: Size(279.w,72.h))
                        )
                      ),
                      child: Center(
                        child: Text(labelSelector(),style: TextStyle(
                          color: labelSelector()=='CHOSEN' ? AppColors.white.withOpacity(0.5) :AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Bebas',
                          fontSize: 35.w
                        ),),
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

  String labelSelector(){
    if(Hive.box<UserModel>('user').values.first.activeSkin==skins[currInd].name)return 'CHOSEN';
    if (Hive.box<UserModel>('user').values.first.availableSkins!.contains(skins[currInd].name!))return 'CHOOSE';
    return 'BUY';
  }
  String pathSelector(){
    if(Hive.box<UserModel>('user').values.first.activeSkin==skins[currInd].name)return Assets.images.inactivebtngray.path;
    if (Hive.box<UserModel>('user').values.first.availableSkins!.contains(skins[currInd].name!))return Assets.images.onboardingbtn.path;
    return Assets.images.onboardingbtn.path;
  }
}
