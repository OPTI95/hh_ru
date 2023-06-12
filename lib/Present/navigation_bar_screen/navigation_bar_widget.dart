import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_ru/Present/cart_screen/cart_screen._widget.dart';
import 'package:hh_ru/Present/home_screen/home_screen.dart';
import '../food_screen/food_screen_widget.dart';
import 'navigation_bar_cubit/index_bottom_navigation_bar_cubit.dart';

class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    const BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/home.png")), label: "Главная"),
    const BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/search-normal.png")),
        label: "Поиск"),
    const BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/bag.png")), label: "Корзина"),
    const BottomNavigationBarItem(
        icon: ImageIcon(AssetImage("images/profile-circle.png")),
        label: "Аккаунт")
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBottomNavigationBarCubit,
        IndexBottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: IgnorePointer(
              ignoring: (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).show,
              child: BottomNavigationBar(
                  enableFeedback: false,
                  backgroundColor: (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).show
                      ? const Color.fromRGBO(154, 154, 154, 1)
                      : Colors.white,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    setState(() {
                      try {} catch (e) {}
                      context
                          .read<IndexBottomNavigationBarCubit>()
                          .setIndex(value);
                    });
                  },
                  selectedFontSize: 10,
                  unselectedFontSize: 10,
                  selectedLabelStyle:
                      const TextStyle(fontFamily: "SfPro", fontWeight: FontWeight.w500),
                  unselectedLabelStyle:
                      const TextStyle(fontFamily: "SfPro", fontWeight: FontWeight.w500),
                  currentIndex: (context
                                  .read<IndexBottomNavigationBarCubit>()
                                  .state as IndexBottomNavigationBarInitial)
                              .index ==
                          5
                      ? 0
                      : (context.read<IndexBottomNavigationBarCubit>().state
                              as IndexBottomNavigationBarInitial)
                          .index,
                  showUnselectedLabels: true,
                  iconSize: 25,
                  selectedItemColor: const Color.fromRGBO(51, 100, 224, 1),
                  unselectedItemColor: (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).show
                      ? const Color.fromRGBO(113, 115, 120, 1)
                      : const Color.fromRGBO(165, 169, 178, 1),
                  items: [
                    bottomNavigationBarItem.elementAt(0),
                    bottomNavigationBarItem.elementAt(1),
                    bottomNavigationBarItem.elementAt(2),
                    bottomNavigationBarItem.elementAt(3)
                  ]),
            ),
            body: (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).index == 0
                ? const HomeScreen()
                : (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).index == 1
                    ? const Center(
                        child: Text("Поиск"),
                      )
                    : (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).index == 2
                        ? const CartScreenWidget()
                        : (context.watch<IndexBottomNavigationBarCubit>().state as IndexBottomNavigationBarInitial).index == 5
                            ? HomeScreenMore(index: context.read<IndexBottomNavigationBarCubit>().currentIndexCategory)
                            : const Center(child: Text("Аккаунт")));
      },
    );
  }
}
