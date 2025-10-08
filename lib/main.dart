import 'package:counta_flutter_app/core/app_routes/app_routes.dart';
import 'package:counta_flutter_app/core/dependency/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'service/socket_service.dart';
import 'utils/app_colors/app_colors.dart';
import 'view/components/device_utils/device_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DeviceUtils.lockDevicePortrait();
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  SocketApi.init();

  // Get.put(NetworkController());

  runApp(const MyApp()); 
/*   runApp(DevicePreview(
     enabled: !kReleaseMode,
     builder: (context) =>
         //====================
    const MyApp(), // Wrap your app
   ));*/
  MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(428, 926),
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.black,
          appBarTheme: const AppBarTheme(
            //surfaceTintColor: AppColors.brinkPink,
            toolbarHeight: 65,
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.white,
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 200),
        initialRoute: AppRoutes.splashScreen,
        navigatorKey: Get.key,
        getPages: AppRoutes.routes,
      ),
    );
  }
}
