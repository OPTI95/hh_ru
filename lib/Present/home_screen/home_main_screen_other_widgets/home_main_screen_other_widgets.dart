import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation_bar_screen/navigation_bar_cubit/index_bottom_navigation_bar_cubit.dart';
import '../home_cubit/category_screen_cubit.dart';

//Карточка категории в главном меню

class CategoryCard extends StatefulWidget {
  final int index;
  const CategoryCard({super.key, required this.index});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(children: [
            CachedNetworkImage(
                 imageUrl: (context.read<CategoryScreenCubit>().state
                        as CategoryScreenLoaded)
                    .list[widget.index]
                    .image_url,
                    fit: BoxFit.contain,
              ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 12),
              child: SizedBox(
                width: 180,
                child: Text(
                  (context.read<CategoryScreenCubit>().state
                          as CategoryScreenLoaded)
                      .list[widget.index]
                      .name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'SfPro',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ]),
        ),
      ),
      onTap: () async {
        context.read<IndexBottomNavigationBarCubit>().currentIndexCategory =
            widget.index;
        context.read<IndexBottomNavigationBarCubit>().setIndex(5);
        setState(() {});
      },
    );
  }
}

class AvatarIconWidget extends StatelessWidget {
  const AvatarIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.asset(
        'images/Avatar.png',
        width: 44,
        height: 44,
      ),
    );
  }
}
