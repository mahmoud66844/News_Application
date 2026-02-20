import 'package:flutter/material.dart';
import 'package:news_app/ui/providers/theme_provider.dart';
import 'package:news_app/ui/utils/app_assets.dart';
import 'package:provider/provider.dart';

import '../../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), (){
      Navigator.push(context, AppRoutes.categoriesScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of(context);
    return Scaffold(
      body: Image.asset(themeProvider.isLightMode? AppAssets.splashLight: AppAssets.splashDark),
    );
  }
}
