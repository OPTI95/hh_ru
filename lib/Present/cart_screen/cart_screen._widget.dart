import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../home_screen/home_cubit/home_screen_cubit.dart';
import '../home_screen/home_main_screen_other_widgets/home_main_screen_other_widgets.dart';
import 'cart_cubit/cart_screen_cubit.dart';

class CartScreenWidget extends StatefulWidget {
  const CartScreenWidget({super.key});

  @override
  State<CartScreenWidget> createState() => _CartScreenWidgetState();
}

class _CartScreenWidgetState extends State<CartScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
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
                                      ? (state as HomeScreenCityLoadedState)
                                          .nameSity
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
                            DateFormat('d MMMM, y', 'ru')
                                .format(DateTime.now()),
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
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: BlocBuilder<CartScreenCubit, CartScreenState>(
                builder: (context, state) {
                  if (state is CartScreenLoadedState) {
                    return SliverList.builder(
                      itemCount: (context.watch<CartScreenCubit>().state
                              as CartScreenLoadedState)
                          .list
                          .length,
                      itemBuilder: (context, index) {
                        return Row(
            children: [
              SizedBox(
                width: 62,
                height: 62,
                child: Card(
                  elevation: 0,
                  color: const Color.fromRGBO(248, 247, 245, 1),
                  child: context.read<CartScreenCubit>().listCart.isEmpty
                      ? Container()
                      : CachedNetworkImage(
                          imageUrl: context
                              .read<CartScreenCubit>()
                              .listCart[index]
                              .image_url,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (context.read<CartScreenCubit>().state
                              as CartScreenLoadedState)
                          .list[index]
                          .name,
                      style: const TextStyle(
                          fontFamily: "SfPro",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          "${(context.read<CartScreenCubit>().state as CartScreenLoadedState).list[index].price} ₽",
                          style: const TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          " · ${(context.read<CartScreenCubit>().state as CartScreenLoadedState).list[index].weight}г",
                          style: const TextStyle(
                              fontFamily: "SfPro",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 32,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(239, 238, 236, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 13,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(()  {
                           context
                              .read<CartScreenCubit>()
                              .removeCountFoodInCart((context
                                      .read<CartScreenCubit>()
                                      .state as CartScreenLoadedState)
                                  .list[index]);
                        });
                      },
                      child: const Icon(
                        Icons.remove,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    BlocBuilder<CartScreenCubit, CartScreenState>(
                      builder: (context, state) {
                        return Text(
                          (context.watch<CartScreenCubit>().state
                                  as CartScreenLoadedState)
                              .list[index]
                              .count
                              .toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "SfPro",
                              fontWeight: FontWeight.w500),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () async {
                        await context
                            .read<CartScreenCubit>()
                            .addCountFoodInCart((context
                                    .read<CartScreenCubit>()
                                    .state as CartScreenLoadedState)
                                .list[index]);
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                  ],
                ),
              )
            ],
          );
                      },
                    );
                  } else {
                    context.read<CartScreenCubit>().getListCartFood();
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
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: (context.watch<CartScreenCubit>().state
                      is CartScreenLoadedState)
                  ? SliverList(
                      delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 48,
                        child: (context.watch<CartScreenCubit>().state
                                        as CartScreenLoadedState)
                                    .list
                                    .length >
                                0
                            ? ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                    Color.fromRGBO(51, 100, 224, 1),
                                  ),
                                ),
                                child: Text(
                                  "Оплатить "+ context.watch<CartScreenCubit>().price.toString()+" ₽",
                                  style: const TextStyle(
                                      fontFamily: "SfPro",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              )
                            : const Center(
                                child: Text(
                                  "Корзина пуста",
                                  style: TextStyle(
                                      fontFamily: "SfPro",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                      ),
                    ]))
                  : SliverList(
                      delegate: SliverChildListDelegate([Container()]),
                    ),
            )
          ],
        ),
      ),
    );
  }
}


