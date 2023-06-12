import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart_screen/cart_cubit/cart_screen_cubit.dart';
import '../../navigation_bar_screen/navigation_bar_cubit/index_bottom_navigation_bar_cubit.dart';
import '../food_cubit/food_screen_cubit.dart';

class FoodCard extends StatefulWidget {
  final int index;
  const FoodCard({
    super.key,
    required this.index,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> with TickerProviderStateMixin {
  late AnimationController controller;
  PersistentBottomSheetController? bottomSheetController;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<IndexBottomNavigationBarCubit>().setShowBool(true);
        bottomSheetController =
            showBottomSheetMoreInfoFood(context, widget.index);

        setState(() {});
      },
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(248, 247, 245, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CachedNetworkImage(
                    imageUrl: (context.read<FoodScreenCubit>().state
                            as FoodScreenLoadedState)
                        .foodList[widget.index]
                        .image_url,
                    width: 110,
                    height: 110,
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 109,
              child: Text(
                (context.read<FoodScreenCubit>().state as FoodScreenLoadedState)
                    .foodList[widget.index]
                    .name,
                style: const TextStyle(
                    height: 1,
                    fontFamily: "SfPro",
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> showBottomSheetMoreInfoFood(
      BuildContext context, int index) {
    return Scaffold.of(context).showBottomSheet(
      transitionAnimationController: controller,
      elevation: 0,
      enableDrag: false,
      constraints:
          BoxConstraints.expand(height: MediaQuery.of(context).size.height),
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.4),
      (context) => Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.value,
              child: child,
            );
          },
          child: SizedBox(
            width: 343,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          width: 311,
                          height: 232,
                          child: Card(
                            elevation: 0,
                            color: const Color.fromRGBO(248, 247, 245, 1),
                            child: MoreInfoCurrentFoodImageWithButtonsWidget(
                              bottomSheet: bottomSheetController,
                              index: widget.index,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      (context.read<FoodScreenCubit>().state
                              as FoodScreenLoadedState)
                          .foodList[index]
                          .name,
                      maxLines: 5,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: "SfPro",
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(
                          "${(context.read<FoodScreenCubit>().state as FoodScreenLoadedState).foodList[index].price} ₽",
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "SfPro",
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          " · ${(context.read<FoodScreenCubit>().state as FoodScreenLoadedState).foodList[index].weight}г",
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "SfPro",
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                        )
                      ],
                    ),
                    Text(
                      (context.read<FoodScreenCubit>().state
                              as FoodScreenLoadedState)
                          .foodList[index]
                          .description,
                      maxLines: 10,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "SfPro",
                          fontWeight: FontWeight.w400),
                    ),
                    ButtonBlueWidget(
                      bottomSheetController: bottomSheetController,
                      index: widget.index,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MoreInfoCurrentFoodImageWithButtonsWidget extends StatelessWidget {
  PersistentBottomSheetController? bottomSheet;
  final int index;
  MoreInfoCurrentFoodImageWithButtonsWidget(
      {super.key, required this.bottomSheet, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            height: 200,
            imageUrl:
                (context.read<FoodScreenCubit>().state as FoodScreenLoadedState)
                    .foodList[index]
                    .image_url,
                    
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    icon: const ImageIcon(
                      AssetImage("images/Vector.png"),
                      size: 19,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close_sharp,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      context
                          .read<IndexBottomNavigationBarCubit>()
                          .setShowBool(false);

                      bottomSheet?.close();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonBlueWidget extends StatelessWidget {
  final int index;
  const ButtonBlueWidget({
    super.key,
    required this.bottomSheetController,
    required this.index,
  });

  final PersistentBottomSheetController? bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  context
                      .read<IndexBottomNavigationBarCubit>()
                      .setShowBool(false);

                  bottomSheetController?.close();
                  await context.read<CartScreenCubit>().addFoodInCart((context
                          .read<FoodScreenCubit>()
                          .state as FoodScreenLoadedState)
                      .foodList[index]);
                  final snackBar = SnackBar(
                    backgroundColor: const Color.fromRGBO(51, 100, 224, 1),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    content: Row(
                      children: [
                        const Icon(Icons.shopping_cart, color: Colors.white),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            "${(context.read<FoodScreenCubit>().state as FoodScreenLoadedState).foodList[index].name} добавлено в корзину!",
                            style: const TextStyle(
                                fontFamily: "SfPro",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ), // Add the text
                      ],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: const MaterialStatePropertyAll(
                    Color.fromRGBO(51, 100, 224, 1),
                  ),
                ),
                child: const Text(
                  "Добавить в корзину",
                  style: TextStyle(
                      fontFamily: "SfPro",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
