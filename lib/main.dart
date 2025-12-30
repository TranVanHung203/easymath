import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math/common/cubit/is_authorized_cubit.dart';
import 'package:math/core/di/injection.dart';
import 'package:math/core/services/voice_service.dart';
import 'package:math/core/utils/theme/app_color.dart';
import 'package:math/features/auth/view_models/auth_cubit.dart';
import 'package:math/features/auth/views/sign_in_page.dart';
import 'package:math/features/chuc_donvi/view_models/chuc_donvi_cubit.dart';
import 'package:math/features/home/presentation/pages/dashboard_page.dart';
import 'package:math/features/home/view_models/roadmap_cubit.dart';
import 'package:math/features/math/tenbyten/view_models/ten_by_ten_cubit.dart';
import 'package:math/features/progress/view_models/progress_cubit.dart';
import 'package:math/features/math/slider_game/view_models/slider_game_cubit.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await VoiceService.instance.init();
  await initializeDependencies();
  runApp(
    ScreenUtilInit(
      designSize: const Size(473, 932),
      minTextAdapt: true,
      child: DevicePreview(
        enabled: false,
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthCubit>()),
            BlocProvider(create: (_) => sl<ProgressCubit>()),
            BlocProvider(create: (_) => sl<RoadmapCubit>()),
            BlocProvider(create: (_) => sl<ChucDonviCubit>()),
            BlocProvider(create: (_) => sl<SliderGameCubit>()),
            BlocProvider(create: (_) => sl<TenByTenCubit>()),
            BlocProvider(
              create: (_) => sl<IsAuthorizedCubit>()..isAuthorized(),
            ),
          ],
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: BlocBuilder<IsAuthorizedCubit, bool>(
        builder: (context, isAuthorized) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Easy Math',
            theme: ThemeData(
              fontFamily: 'Baloo2',
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary600),
            ),
            home: isAuthorized
                ? DashboardPage()
                // ? const DraggableExampleApp()
                // ? const MyHomePage(title: 'Easy Math')
                : const SignInPage(),
            // home: AddInfomationPage(),
          );
        },
      ),
    );
  }
}
