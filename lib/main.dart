import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task/src/core/constants/const_methods.dart';
import 'package:task/src/core/constants/themes.dart';
import 'package:task/src/core/global_bloc/app_cubit/app_cubit.dart';
import 'package:task/src/core/global_bloc/bloc_observer.dart';
import 'package:task/src/core/router/app_router.dart';
import 'package:task/src/core/services/cache_helper.dart';
import 'package:task/src/core/services/dio_helper.dart';
import 'package:task/src/core/services/network_checker_helper.dart';
import 'package:task/src/core/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runZonedGuarded(
    () async {
      Bloc.observer = MyBlocObserver();
      await NotificationService.initialize();
      await CacheHelper.init();
      NetworkCheckerHelper.init();
      DioHelper.init();
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      logError("Global Error: $error");
      logError("Global StackTrace: $stackTrace");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..initAppCubit(),
          lazy: false,
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return Sizer(
            builder: (BuildContext context, Orientation orientation,
                DeviceType deviceType) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.onGenerateRoutes,
                themeMode: cubit.themeMode,
                theme: LightTheme.lightTheme,
                darkTheme: DarkTheme.darkTheme,
                title: '',
              );
            },
          );
        },
      ),
    );
  }
}
