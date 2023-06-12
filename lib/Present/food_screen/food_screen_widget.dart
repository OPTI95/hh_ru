import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_screen/home_cubit/category_screen_cubit.dart';
import '../home_screen/home_main_screen_other_widgets/home_main_screen_other_widgets.dart';
import '../navigation_bar_screen/navigation_bar_cubit/index_bottom_navigation_bar_cubit.dart';
import 'food_cubit/food_screen_cubit.dart';
import 'food_screen_more/food_screen_more_widget.dart';

class HomeScreenMore extends StatefulWidget {
  final int index;
  const HomeScreenMore({super.key, required this.index});

  @override
  State<HomeScreenMore> createState() => _HomeScreenMoreState();
}

class _HomeScreenMoreState extends State<HomeScreenMore>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var categoryStream = StreamController<int>();
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    context.read<FoodScreenCubit>().emit(FoodScreenInitial());
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }



  @override
  void dispose() async{
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            pinned: true,
            leading: IconButton(
              iconSize: 20,
              icon: const Icon(Icons.arrow_back_ios_new),
              splashColor: Colors.white70,
              onPressed: () {
                context.read<IndexBottomNavigationBarCubit>().setIndex(0);
                setState(() {});
              },
            ),
            title: Text(
              (context.read<CategoryScreenCubit>().state
                      as CategoryScreenLoaded)
                  .list[widget.index]
                  .name,
              style: const TextStyle(
                  fontFamily: "SfPro",
                  fontWeight: FontWeight.w500,
                  fontSize: 18),
            ),
            actions: const [AvatarIconWidget()],
          ),
          context.watch<FoodScreenCubit>().state is FoodScreenLoadedState
              ? SliverPersistentHeader(
                  pinned: true,
                  delegate: MyHeaderDelegate(categoryStream: categoryStream),
                )
              : SliverList(
                  delegate: SliverChildListDelegate([
                  const Center(
                    child: LinearProgressIndicator(),
                  )
                ])),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: BlocBuilder<FoodScreenCubit, FoodScreenState>(
              builder: (context, state) {
                if (state is FoodScreenLoadedState) {
                  return SliverGrid.builder(
                      itemCount: (context.read<FoodScreenCubit>().state
                              as FoodScreenLoadedState)
                          .foodList
                          .length,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: child,
                              );
                            },
                            child: FoodCard(index: index));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 14,
                              childAspectRatio: 110 / 156));
                } else {
                  context.read<FoodScreenCubit>().getListFoods();
                  return SliverList(
                      delegate: SliverChildListDelegate([
                    const Center(
                      child: RefreshProgressIndicator(),
                    )
                  ]));
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  StreamController<int> categoryStream;
  MyHeaderDelegate({required this.categoryStream});
  int num = 0;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StreamBuilder<Object>(
        stream: categoryStream.stream,
        initialData: num,
        builder: (context, snapshot) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 8,
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: (context.read<FoodScreenCubit>().state
                          as FoodScreenLoadedState)
                      .tegsList
                      .length +
                  1,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const SizedBox(
                    width: 10,
                    height: 10,
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      num = index - 1;
                      await context
                          .read<FoodScreenCubit>()
                          .getListFoodsWhereTegs(num);
                      setState() {}
                      categoryStream.sink.add(index - 1);
                    },
                    child: Chip(
                        backgroundColor: index - 1 == num
                            ? const Color.fromRGBO(51, 100, 224, 1)
                            : const Color.fromRGBO(248, 247, 245, 1),
                        side: const BorderSide(
                          style: BorderStyle.none,
                        ),
                        useDeleteButtonTooltip: false,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text(
                          (context.read<FoodScreenCubit>().state
                                  as FoodScreenLoadedState)
                              .tegsList[index - 1],
                          style: TextStyle(
                              fontSize: 14,
                              color: index - 1 == num
                                  ? Colors.white
                                  : Colors.black),
                        )),
                  );
                }
              },
            ),
          );
        });
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
