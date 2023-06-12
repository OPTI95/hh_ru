import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'home_cubit/category_screen_cubit.dart';
import 'home_cubit/home_screen_cubit.dart';
import 'home_main_screen_other_widgets/home_main_screen_other_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 9, right: 8.5),
                  child: ImageIcon(
                    AssetImage("images/Icons.png"),
                    size: 30,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<HomeScreenCubit, HomeScreenState>(
                      builder: (context, state) {
                        if (context.watch<HomeScreenCubit>().state
                            is HomeScreenInitial) {
                          context.read<HomeScreenCubit>().getNameCity();
                          return const Text("");
                        } else {
                          return Text(
                            context.watch<HomeScreenCubit>().state
                                    is HomeScreenCityLoadedState
                                ? (state as HomeScreenCityLoadedState).nameSity
                                : "Ищу вас...",
                            style: const TextStyle(
                                fontFamily: "SF-Pro-Display",
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          );
                        }
                      },
                    ),
                    Text(
                      DateFormat('d MMMM, y', 'ru').format(DateTime.now()),
                      style: const TextStyle(
                          fontFamily: "SF-Pro-Display",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color.fromRGBO(0, 0, 0, 0.5)),
                    )
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          const AvatarIconWidget()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: BlocBuilder<CategoryScreenCubit, CategoryScreenState>(
          builder: (context, state) {
            if (state is CategoryScreenInitial) {
              context.read<CategoryScreenCubit>().getListCategories();
              return const Center(child: RefreshProgressIndicator());
            } else if (state is CategoryScreenLoading) {
              return const Center(child: RefreshProgressIndicator());
            } else if (state is CategoryScreenLoaded) {
              return ListView.separated(
                itemCount: state.list.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemBuilder: (context, index) => CategoryCard(
                  index: index,
                ),
              );
            } else {
              return const Center(
                child: RefreshProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
