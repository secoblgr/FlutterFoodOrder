import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/ui/cubit/home_cubit.dart';

import '../cubit/favorite_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, List<int>>(
      builder: (context, favoriteIds) {
        final allFoods = context.read<HomeCubit>().state;

        final favoriteFoods = allFoods
            .where((food) => favoriteIds.contains(food.id))
            .toList();

        if (favoriteFoods.isEmpty) {
          return const Center(
            child: Text(
              "Henüz favori eklemedin ❤️",
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: favoriteFoods.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final food = favoriteFoods[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      "http://kasimadalan.pe.hu/yemekler/resimler/${food.imageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
