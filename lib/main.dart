import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Present/cart_screen/cart_cubit/cart_screen_cubit.dart';
import 'Present/food_screen/food_cubit/food_screen_cubit.dart';
import 'Present/home_screen/home_cubit/category_screen_cubit.dart';
import 'Present/home_screen/home_cubit/home_screen_cubit.dart';
import 'Present/navigation_bar_screen/navigation_bar_cubit/index_bottom_navigation_bar_cubit.dart';
import 'Present/navigation_bar_screen/navigation_bar_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  initializeDateFormatting();
  runApp(const Wrapper());
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeScreenCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryScreenCubit(),
        ),
        BlocProvider(
          create: (context) => IndexBottomNavigationBarCubit(),
        ),
         BlocProvider(
          create: (context) => FoodScreenCubit(),
        ),
        BlocProvider(
          create: (context) => CartScreenCubit(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NavigatorBar(),
    );
  }
}
