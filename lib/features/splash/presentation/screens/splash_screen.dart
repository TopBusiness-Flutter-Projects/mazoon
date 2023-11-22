import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/getsize.dart';
import '../cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() {
    _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(seconds: 8, milliseconds: 500),
      () {
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('onBoarding') != null) {
      if (prefs.getString('user') != null) {
        if (context.read<SplashCubit>().adsList.isNotEmpty) {
          Navigator.pushReplacementNamed(context, Routes.podAdsPageScreenRoute,
              arguments: context.read<SplashCubit>().adsList.first);
        } else {
          Navigator.pushReplacementNamed(context, Routes.homePageScreenRoute);
        }
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.loginRoute,
          ModalRoute.withName(
            Routes.initialRoute,
          ),
        );
      }
    } else {
      Navigator.pushReplacementNamed(
        context,
        Routes.onboardingPageScreenRoute,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();

    _startDelay();
    _getNotiStatus();
  }

  _getNotiStatus() async {
    await Preferences.instance.getNotiLights().then((value) {
      Preferences.instance.notiLight = value!;
    });
    await Preferences.instance.getNotiSound().then((value) {
      Preferences.instance.notiSound = value!;
    });
    await Preferences.instance.getNotiVibrate().then((value) {
      Preferences.instance.notiVisbrate = value!;
    });

    print('+++++++++++++++++++++++++++++++');
    print(
        '++sound = ${Preferences.instance.notiSound}+++++/n++ visbrate = ${Preferences.instance.notiVisbrate}++++++++++++++++++++');

    print('+++++++++++++++++++++++++++++++');
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset('assets/images/intro.gif');
    // return BlocBuilder<SplashCubit, SplashState>(
    //   builder: (context, state) {
    //     if (state is SplashLoading) {}
    //     if (state is SplashLoaded) {
    //       _startDelay();
    //     }
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: SizedBox(
                child: Image.asset(
                  'assets/images/intro.gif',
                  // height: getSize(context) / 1.2,
                  // width: getSize(context) / 1.2,
                ),
              ),
            ),
          ),
          // Positioned(
          //     bottom: 0,
          //     child: Container(
          //       alignment: Alignment.bottomCenter,
          //       child: Image.asset(
          //         ImageAssets.copyRight,
          //         width: getSize(context) / 1.2,
          //       ),
          //     )),
        ],
      ),
    );
    //   },
    // );
  }
}
