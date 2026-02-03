import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/data/entity/foods.dart';
import 'package:project/ui/cubit/home_cubit.dart';
import 'package:project/ui/views/detail.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/favorite_cubit.dart';
import 'cart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navIndex = 0;
  final TextEditingController searchController = TextEditingController();

  final iconList = const [
    Icons.home,
    Icons.favorite_rounded,
    Icons.person_rounded,
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getFoods();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text("Teslimat Adres",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                    Padding(
                      padding: const EdgeInsets.only(left: 90.0),
                      child: Text("Ev"
                        , style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                    ),
                  ],
                ),
                Icon(Icons.home_rounded,size: 32,)
              ],
            ),
          )
        ],
        title: Text(widget.title),
        backgroundColor:
        Theme.of(context).colorScheme.inversePrimary,
      ),

      /// 🔥 BODY
      body: navIndex == 0
          ? _homePage()
          : navIndex == 1
          ? _favoritesPage()
          : _profilePage(),

      /// 🔥 FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor:
        Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          );
        },
        child: const Icon(Icons.add_shopping_cart_outlined),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.endDocked,

      /// 🔥 BOTTOM NAV
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: navIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.smoothEdge,
        activeColor: Colors.lightBlue,
        onTap: (index) {
          setState(() {
            navIndex = index;
          });
        },
      ),
    );
  }

  /// ================= HOME =================
  Widget _homePage() {
    return BlocBuilder<HomeCubit, List<Foods>>(
      builder: (context, foodsList) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Ara",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      context.read<HomeCubit>().search("");
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  context.read<HomeCubit>().search(value);
                },
              ),
            ),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: foodsList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return _foodCard(foodsList[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  /// ================= FAVORITES =================
  Widget _favoritesPage() {
    return BlocBuilder<FavoritesCubit, List<int>>(
      builder: (context, favIds) {
        return BlocBuilder<HomeCubit, List<Foods>>(
          builder: (context, foods) {
            final favFoods =
            foods.where((e) => favIds.contains(e.id)).toList();

            if (favFoods.isEmpty) {
              return const Center(
                child: Text(
                  "Henüz favori eklenmedi ❤️",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favFoods.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return _foodCard(favFoods[index]);
              },
            );
          },
        );
      },
    );
  }

  /// ================= PROFILE =================
  Widget _profilePage() {
    return const Center(
      child: Text(
        "Profil Sayfası 👤",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _foodCard(Foods food) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPage(foods: food)
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// IMAGE
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      "http://kasimadalan.pe.hu/yemekler/resimler/${food.imageUrl}",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// NAME + PRICE + CART
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// NAME + PRICE
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${food.price} ₺",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 🛒 ADD TO CART
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          context.read<CartCubit>().addToCart(food);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${food.name} sepete eklendi 🛒"),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// ❤️ FAVORI
          Positioned(
            top: 8,
            right: 8,
            child: BlocBuilder<FavoritesCubit, List<int>>(
              builder: (context, favs) {
                final isFav = favs.contains(food.id);

                return InkWell(
                  onTap: () {
                    context
                        .read<FavoritesCubit>()
                        .toggleFavorite(food.id);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
