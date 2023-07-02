import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:valorant_wiki_app/ui/constants/colors/app_colors.dart';
import 'package:valorant_wiki_app/ui/constants/enums/fonts_enum.dart';
import 'package:valorant_wiki_app/ui/constants/localization/localization_constants.dart';
import 'package:valorant_wiki_app/ui/pages/agentsPage.dart';

import 'bloc/theme_cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: LocalizationConstants.path,
      supportedLocales: LocalizationConstants.supportedLocales,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        return MaterialApp(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            ScreenUtil.init(context);
            AppSizes.init();
            return MediaQuery(
              data: mediaQueryData,
              child: child!,
            );
          },
          title: 'ValorantWikiApp',
          debugShowCheckedModeBanner: false,
          theme: state.themeData,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          home: HomePage(),
        );
      }),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
      final themeCubit = context.read<ThemeCubit>();
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  themeCubit.setTheme();
                },
                icon: Icon(
                  MaterialIcons.brightness_3,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.blue
                      : AppColors.primaryColor,
                ),
              ),
            ],
            centerTitle: true,
            title: Text(
              "Valorant",
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.blue
                    : AppColors.primaryColor,
                fontSize: AppSizes.headlineMedium,
                fontWeight: AppWeights.veryBold,
                fontFamily: AppFonts.valorant,
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AgentsPage()));
                  },
                  child: Text(""),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
