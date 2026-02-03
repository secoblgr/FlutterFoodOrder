import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/data/repositories/cart_repository.dart';
import 'package:project/data/repositories/fav_repository.dart';
import 'package:project/ui/cubit/cart_cubit.dart';
import 'package:project/ui/cubit/favorite_cubit.dart';
import 'package:project/ui/cubit/home_cubit.dart';
import 'package:project/ui/views/splash.dart';

void main() {
  final favRepo = FavoritesRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => CartCubit(CartRepository())),
        BlocProvider(create: (context) => FavoritesCubit(favRepo)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade500),
      ),
      home: SplashPage(),
    );
  }
}
