part of 'injection.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //core
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  // Hide status bar and navigation bar for full-screen experience
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  FlutterNativeSplash.remove();
  final sharedPrefs = await SharedPreferences.getInstance();

  // Register SharePrefsService first
  sl.registerLazySingleton(() => SharePrefsService(prefs: sharedPrefs));

  // Register DioClient without interceptor
  sl.registerLazySingleton(() => DioClient());

  // Register AuthApiService
  sl.registerLazySingleton(() => AuthApiService(dioClient: sl()));

  // Register CheckTokenInterceptor
  sl.registerLazySingleton(
    () => CheckTokenInterceptor(sharePrefsService: sl()),
  );

  // Add interceptor to DioClient
  sl<DioClient>().addInterceptor(sl<CheckTokenInterceptor>());

  // Register remaining dependencies
  sl
    ..registerLazySingleton(
      () => AuthRepository(authApiService: sl(), sharePrefsService: sl()),
    )
    ..registerFactory<IsAuthorizedCubit>(
      () => IsAuthorizedCubit(sharePrefsService: sl()),
    )
    ..registerFactory<AuthCubit>(() => AuthCubit(authRepository: sl()));

  _roadmapInit();
  _activitiesInit();
  _chucDonViInit();
  _progressInit();
  _gameInit();
}

void _gameInit() {
  sl
    ..registerFactory(() => TenByTenCubit())
    ..registerFactory(() => SliderGameCubit());
}

void _progressInit() {
  sl
    ..registerLazySingleton(() => ProgressApiService(dioClient: sl()))
    ..registerLazySingleton(() => ProgressRepository(progressApiService: sl()))
    ..registerFactory(() => ProgressCubit(getAllProgresss: sl()));
}

void _chucDonViInit() {
  sl
    ..registerLazySingleton<ChucDonviApiService>(() => ChucDonviMockService())
    ..registerLazySingleton(
      () => ChucDonviRepository(sl<ChucDonviApiService>()),
    )
    ..registerFactory(() => ChucDonviCubit(sl<ChucDonviRepository>()));
}

void _roadmapInit() {
  sl
    ..registerLazySingleton(() => RoadmapApiService(dioClient: sl()))
    ..registerLazySingleton(() => RoadmapRepository(roadmapApiService: sl()))
    ..registerFactory(() => RoadmapCubit(getAllRoadmaps: sl()));
}

void _activitiesInit() {
  sl
    ..registerLazySingleton(() => ActivitiesApiService(dioClient: sl()))
    ..registerLazySingleton(
      () => ActivitiesRepository(activitiesApiService: sl()),
    )
    ..registerFactory(() => IsCheckCubit(activitiesRepository: sl()));
}

void resetSingleton() {
  sl
    ..resetLazySingleton<SharePrefsService>()
    // ..resetLazySingleton<NavigatorKeyService>()
    // ..resetLazySingleton<DashboardCubit>()
    // ..resetLazySingleton<IsAuthorizedCubit>()
    ..resetLazySingleton<DioClient>();
}
